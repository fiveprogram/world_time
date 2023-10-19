import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:world_time_api/presentation/notifiers/clock_notifier.dart';

import '../../data/model/time_info.dart';
import '../../data/service/world_api.dart';
import '../notifiers/timezones_notification.dart';

final timeZonesProvider = StateNotifierProvider((ref) => TimezoneNotifier());

class TimeZonePage extends HookConsumerWidget {
  TimeZonePage({super.key});

  late String _timezone;
  final GlobalKey<ScaffoldState> _scaffKey = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState<bool>(false);
    final timeZones = ref.watch(timeZonesProvider.notifier).state;

    return Scaffold(
      key: _scaffKey,
      appBar: AppBar(
        title: const Text('Select timezone'),
      ),
      body: SingleChildScrollView(
        // ignore: unnecessary_null_comparison
        child: timeZones != null
            ? Column(
                children: [
                  DropdownSearch<String>(
                    onChanged: (tz) {
                      _timezone = tz ?? '';
                    },
                    items: timeZones,
                    selectedItem: _timezone,
                  ),
                  ElevatedButton(
                    onPressed: isLoading.value
                        ? null
                        : () async {
                            isLoading.value = true;

                            bool exists = false;

                            ref
                                .read(clocksProvider.notifier)
                                .state
                                .forEach((element) {
                              if (element.timezone == _timezone) {
                                exists = true;
                              }
                            });
                            if (!exists) {
                              TimeInfo? info =
                                  await WorldTimeApi.getTimezoneTime(_timezone);
                              if (info == null) return;
                              ref.read(clocksProvider.notifier).state.add(info);
                              isLoading.value = false;
                              Navigator.pop(context);
                            } else {
                              isLoading.value = false;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "The timezone clock is already available in the list."),
                              ));
                            }
                          },
                    child: isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text("Add"),
                  )
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:world_time_api/presentation/notifiers/clock_notifier.dart';
import 'package:world_time_api/presentation/widgets/clock_container.dart';
import 'package:world_time_api/presentation/widgets/clock_hands.dart';

import '../../data/model/time_info.dart';
import '../../data/service/world_api.dart';
import '../../res/routes.dart';

final timeProvider = StateProvider<DateTime>((ref) => DateTime.now());

final timezone = FutureProvider<TimeInfo?>((ref) async {
  return WorldTimeApi.getCurrentTime(timeZone: '');
});

class ClockPage extends HookConsumerWidget {
  ClockPage({super.key});

  late Timer timer;
  late Timer timer2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final timer = ref.read(timeProvider);
        timer.add(const Duration(seconds: 1));
        print(timer);
      });

      print(timer);
    });

    final time = ref.watch(timeProvider);
    final timeInfo = ref.watch(timezone);

    List<TimeInfo> clocks = ref.watch(clocksProvider.notifier).state;
    final time2 = ref.watch(timeProvider);

    return Scaffold(
        body: SafeArea(
            child: ListView(
      padding: const EdgeInsets.all(16.0),
      children: <Widget>[
        Row(
          children: [
            const Spacer(),
            MaterialButton(
              padding: const EdgeInsets.all(8.0),
              color: Colors.pink,
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.timezonesPage);
              },
            ),
          ],
        ),
        Column(
          children: [
            ClockContainer(
              child: CustomPaint(
                painter: ClockHands(time),
              ),
            ),
            const SizedBox(height: 20),
            timeInfo.when(
              data: (timeInfo) => Text(timeInfo?.timezone ?? ''),
              error: (err, stack) => Container(),
              loading: () => const CircularProgressIndicator(),
            ),
            Text(
              DateFormat.jm().format(time),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10.0),
          ],
        ),
        SizedBox(
            height: 160,
            child: clocks.isNotEmpty
                ? ListView.builder(
                    itemCount: clocks.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      TimeInfo clock = clocks[index];
                      var time = time2.toUtc();
                      int offset = clock.rawOffset + clock.dstOffset;
                      if (clock.rawOffset > 0) {
                        time = time.add(Duration(seconds: offset));
                      } else if (clock.rawOffset < 0) {
                        time = time.subtract(Duration(seconds: (offset * -1)));
                      }
                      return Card(
                        child: Stack(
                          children: [
                            Container(
                              width: 300,
                              padding: const EdgeInsets.all(32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    clock.timezone,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    clock.utcOffset,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            DateFormat.yMMMd().format(time)),
                                      ),
                                      Text(
                                        DateFormat.jm().format(time),
                                        textAlign: TextAlign.right,
                                        style: const TextStyle(
                                          fontSize: 24.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  ref
                                      .read(clocksProvider.notifier)
                                      .remove(clock);
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                : const SizedBox())
      ],
    )));
  }
}

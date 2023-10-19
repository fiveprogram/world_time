import 'package:state_notifier/state_notifier.dart';

import '../../data/service/world_api.dart';

class TimezoneNotifier extends StateNotifier<List<String>> {
  TimezoneNotifier() : super([]) {
    _init();
  }

  _init() async {
    state = await WorldTimeApi.getTimeZones() ?? [];
  }
}

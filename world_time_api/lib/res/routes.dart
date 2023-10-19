import 'package:flutter/material.dart';
import 'package:world_time_api/presentation/pages/time_zone_page_renew.dart';

import '../presentation/pages/clock_page_renew.dart';

class AppRoutes {
  static const String timezonesPage = 'timezones_page';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case timezonesPage:
        return _buildRoute(TimeZonePage(), settings);
      default:
        return _buildRoute(ClockPage(), settings);
    }
  }

  static _buildRoute(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}

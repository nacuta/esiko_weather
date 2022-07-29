import 'package:flutter/widgets.dart';

import '../home_page.dart';

class Routes {
  static final mainRoute = <String, WidgetBuilder>{
    '/home': (context) => const HomePageInitial(),
    // '/settings': (context) => SettingsScreen(),
  };
}

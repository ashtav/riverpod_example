import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:riverpod_example/app/data/local/shared_preferences.dart';
import 'package:riverpod_example/app/utils/fetch/src/fetch.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/core/theme.dart';
import 'app/modules/home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LazyUi.config(radius: 7.0, theme: AppTheme.light);

  prefs = SharedPreferences.getInstance();

  // use fetch
  UseFetch(
      baseUrl: 'https://dummyjson.com/',
      onRequest: (status, data) {
        logg('listen to request: $status');
      }).init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod Example',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? widget) {
        double fontDeviceSize = MediaQuery.of(context).textScaleFactor;

        // prevent user from scaling font size
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: fontDeviceSize > 1.1 ? 1.1 : 1.0,
            ),
            child: LzToastOverlay(child: widget));
      },
      home: const HomeView(),
    );
  }
}

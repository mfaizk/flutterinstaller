import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutterinstaller/Pages/on_connect_route/home_page.dart';
import 'package:flutterinstaller/Pages/on_no_connection_route/no_connection.dart';
import 'package:flutterinstaller/helpers/provider_class.dart';

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _enablePlatformOverrideForDesktop();
  runApp(ProviderScope(child: MaterialApp(home: MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        AsyncValue<ConnectivityResult> status = ref.watch(netStatusProvider);
        return status.when(
          data: (data) {
            if (data == ConnectivityResult.bluetooth ||
                data == ConnectivityResult.ethernet ||
                data == ConnectivityResult.mobile ||
                ConnectivityResult.wifi == data) {
              return const HomePage();
            } else {
              return const NoConnection();
            }
          },
          error: (error, s) => Text(error.toString()),
          loading: () => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).backgroundColor,
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).progressIndicatorTheme.color,
              ),
            ),
          ),
        );
      },
    );

    // return MaterialApp(
    //   theme: ThemeData(primarySwatch: Colors.blue),
    //   home: const HomePage(),
    // );
  }
}

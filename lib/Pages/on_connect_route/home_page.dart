import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterinstaller/helpers/net_checker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final netChecker = Provider((ref) => NetChecker());
  final netStatusProvider =
      StreamProvider.autoDispose<ConnectivityResult>((ref) async* {
    // return NetChecker().connectionStatusController.stream;

    final status = NetChecker().connectionStatusController;

    await for (final value in status.stream) {
      yield value;
    }
  });
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // final status = ref.read(netStatusProvider);

        AsyncValue<ConnectivityResult> status = ref.watch(netStatusProvider);

        print(status.asData);

        return Scaffold(
          body: status.when(
            data: (data) {
              print(data.toString());
              if (ConnectivityResult.mobile == data ||
                  ConnectivityResult.wifi == data) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(data.name.toString()),
                  ),
                );
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: Text("Offline"),
                  ),
                );
              }
            },
            error: (e, s) => Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(e.toString()),
              ),
            ),
            loading: () => Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}

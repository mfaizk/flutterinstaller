import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterinstaller/helpers/provider_class.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // final status = ref.read(netStatusProvider);

        AsyncValue<ConnectivityResult> status = ref.watch(netStatusProvider);

        return Scaffold(
          body: status.when(
            data: (data) {
              if (ConnectivityResult.mobile == data ||
                  ConnectivityResult.wifi == data) {
                return Container(
                  color: Theme.of(context).primaryColor,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      data.name.toString(),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                );
              } else {
                return Container(
                  color: Theme.of(context).primaryColor,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      "Offline",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                );
              }
            },
            error: (e, s) => Container(
              color: Theme.of(context).primaryColor,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  e.toString(),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
            loading: () => Container(
              color: Theme.of(context).primaryColor,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).backgroundColor,
              )),
            ),
          ),
        );
      },
    );
  }
}

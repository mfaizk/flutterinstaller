import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterinstaller/helpers/provider_class.dart';
import 'package:flutterinstaller/widget/download_button.dart';
import 'package:flutterinstaller/widget/set_sdk_to_download.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0D0D0D),
        title: Text(
          "Sdk Installer",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SetSdkToDownload(),
                const DownloadButton(),
                // Consumer(
                //   builder: (context, ref, child) {
                //     AsyncValue<double> progress = ref.watch(downloadProgress);
                //     return progress.when(data: (data) {
                //       return Text(data.toString());
                //     }, error: (e, s) {
                //       return Text(e.toString());
                //     }, loading: () {
                //       return const CircularProgressIndicator();
                //     });
                //   },
                // ),
                Consumer(
                  builder: (context, ref, child) {
                    final value = ref.watch(progress);
                    print(value.progress);
                    return Text(value.progress.toString());
                  },
                )
              ],
            ),
          )),
    );
  }
}

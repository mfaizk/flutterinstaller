import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
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
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SetSdkToDownload(),
                const Text('----------Flutter Installer----------'),
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.05)),
                Consumer(
                  builder: (context, ref, child) {
                    final value = ref.watch(progress);
                    print(value.progress);

                    return AnimatedSwitcher(
                        duration: const Duration(seconds: 1),
                        child: value.progress == 0.0
                            ? const DownloadButton()
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width,
                                color: Theme.of(context).primaryColor,
                                child: AnimatedSwitcher(
                                    duration: const Duration(seconds: 1),
                                    child: value.dCompleted == false ||
                                            value.status == ""
                                        ? Container(
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.4,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: value.total == -1
                                                ? const LinearProgressIndicator()
                                                : FAProgressBar(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    progressColor: Colors.green,
                                                    currentValue:
                                                        value.progress.toInt(),
                                                    displayText: '%',
                                                  ),
                                          )
                                        : Text(value.status)),
                              ));
                  },
                ),
              ],
            ),
          )),
    );
  }
}

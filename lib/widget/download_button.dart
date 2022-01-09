import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterinstaller/helpers/download_helper.dart';
import 'package:flutterinstaller/helpers/provider_class.dart';

class DownloadButton extends ConsumerWidget {
  const DownloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.3,
        color: Colors.red,
        child: MaterialButton(
          color: Colors.yellow,
          onPressed: () {
            ref.read(progress).flutterDownloader();
          },
          child: Text("Download"),
        ),
      ),
    );
  }
}

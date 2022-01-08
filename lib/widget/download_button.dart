import 'package:flutter/material.dart';
import 'package:flutterinstaller/helpers/download_helper.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            DownloadHelper().flutterDownloader();
          },
          child: Text("Download"),
        ),
      ),
    );
  }
}

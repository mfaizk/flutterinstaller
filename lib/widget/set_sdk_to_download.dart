import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SetSdkToDownload extends StatefulWidget {
  const SetSdkToDownload({Key? key}) : super(key: key);

  @override
  _SetSdkToDownloadState createState() => _SetSdkToDownloadState();
}

class _SetSdkToDownloadState extends State<SetSdkToDownload> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Lottie.asset(
        'assets/flutter.json',
      ),
    );
  }
}

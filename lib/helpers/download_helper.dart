import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';

class DownloadHelper extends ChangeNotifier {
  double progress = 0.0;
  // StreamController<double> progress = StreamController<double>();
  var shell = Shell();
  String stableUrl =
      "https://github.com/flutter/flutter/archive/refs/heads/master.zip";

  var dio = Dio();

  showProgress(c, t) async {
    double percentage = ((c / t) * 100).floorToDouble();

    progress = percentage;
    notifyListeners();
    // print(state.toString());
  }

  flutterDownloader() async {
    // String path = await getPath();

    await dio.download(stableUrl, await getPath() + "/Sdk",
        onReceiveProgress: showProgress);

    // print(response.headers);
  }

  // print(response.headers);
}

Future getPath() async {
  Directory? path = await getDownloadsDirectory();
  String? dPath = path?.path;
  // print(dPath);

  return dPath;
}

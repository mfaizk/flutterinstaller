import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';

class DownloadHelper {
  StreamController<double> progress = StreamController<double>();

  var shell = Shell();
  String stableUrl =
      "https://github.com/flutter/flutter/archive/refs/heads/master.zip";

  var dio = Dio();
  DownloadHelper() {}

  flutterDownloader() async {
    // String path = await getPath();

    var response = await dio.download(
      stableUrl,
      await getPath() + "/Sdk",
      onReceiveProgress: (count, total) {
        double percentage = ((count / total) * 100).floorToDouble();
        progress.add(percentage);
      },
    );

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

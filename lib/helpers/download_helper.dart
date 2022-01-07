import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';

class DownloadHelper {
  StreamController<int> progress = StreamController<int>();
  var shell = Shell();

  DownloadHelper() {
    shell.run('''
     git --version
  ''').then((value) {
      print(value.errLines);
      print(value.outText);
    });
  }

  String stableUrl =
      "https://github.com/flutter/flutter/archive/refs/heads/master.zip";

  var dio = Dio();

  flutterDownloader() async {
    // String path = await getPath();

    var response = await dio.download(
      stableUrl,
      await getPath() + "/Sdk",
      onReceiveProgress: (count, total) {
        int percentage = ((count / total) * 100).floor();
        progress.sink.add(percentage);
      },
    );

    // print(response.headers);
  }

  Future getPath() async {
    Directory? path = await getDownloadsDirectory();
    String? dPath = path?.path;
    // print(dPath);

    return dPath;
  }
}

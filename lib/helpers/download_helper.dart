import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';

class DownloadHelper {
  DownloadHelper() {
    var shell = Shell();
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
    print(await getPath());
    var response = await dio.download(stableUrl, await getPath() + "/Sdk");
    print(response.headers);
  }

  Future getPath() async {
    Directory? path = await getDownloadsDirectory();
    String? dPath = path?.path;
    print(dPath);

    return dPath;
  }
}

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:process_run/shell.dart';

class DownloadHelper extends ChangeNotifier {
  double progress = 0.0;
  var total = 0;
  bool dCompleted = false;
  String status = "";
  bool dStared = false;
  String path = "";
  // StreamController<double> progress = StreamController<double>();
  var shell = Shell();
  String stableUrl =
      "https://github.com/flutter/flutter/archive/refs/heads/master.zip";

  var dio = Dio();

  showProgress(c, t) async {
    double percentage = ((c / t) * 100).floorToDouble();
    // print(t);
    total = t;
    progress = percentage;
    notifyListeners();
    // print(state.toString());
  }

  flutterDownloader() async {
    String path = await getPath();
    dStared = true;
    notifyListeners();
    path = await getPath();
    await dio
        .download(stableUrl, await getPath() + "/.flutter/Sdk",
            onReceiveProgress: showProgress)
        .whenComplete(() {
      dCompleted = !dCompleted;
      status = "Extracting Sdk";
      dStared = false;
      notifyListeners();
      unArchiver(path + '/.flutter/Sdk', path);
    }).catchError((e) {
      status = e.toString();
      print(status);
      dStared = false;
      notifyListeners();
    });
    // print(response.headers);
  }

  Future getPath() async {
    Directory? path = await getDownloadsDirectory();
    String? dPath = path?.path;
    // print(dPath);

    return dPath;
  }

  unArchiver(String location, path) async {
    if (Platform.isLinux) {
      await Directory(path + "/.envSdk").create();
      String locToExtractFolder = path + "/.envSdk";
      String gitInitPah = locToExtractFolder + "/flutter-master/";
      Shell().run('''
    unzip $location -d $locToExtractFolder
    ''').whenComplete(() {
        status = "Extraction Completed";
        progress = 1.0;
        notifyListeners();
      }).catchError((e) {
        print(e.toString());
      });

      Shell().run('''
  git init $gitInitPah
  ''');
    }
  }

  // print(response.headers);
}

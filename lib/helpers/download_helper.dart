import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;
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
    // getHomepath();
  }

  unArchiver(String location, path) async {
    if (Platform.isLinux) {
      await Directory(path + "/.envSdk").create();
      String locToExtractFolder = path + "/.envSdk";
      String gitInitPah = locToExtractFolder + "/flutter-master/";

      if (!(await Directory(gitInitPah).exists())) {
        Shell().run('''
    
    unzip $location -d $locToExtractFolder 
    git init $gitInitPah
    ''').whenComplete(() {
          status = "Extraction Completed";
          progress = 1.0;
          setPathInLinux();
          notifyListeners();
        }).catchError((e) {
          status = e.toString();
          notifyListeners();
        });
      } else {
        Directory(gitInitPah).delete(recursive: true).whenComplete(() {
          Shell().run('''
    
    unzip $location -d $locToExtractFolder 
    git init $gitInitPah
    ''').whenComplete(() {
            status = "Extraction Completed";
            progress = 1.0;
            setPathInLinux();
            notifyListeners();
          }).catchError((e) {
            status = e.toString();
            notifyListeners();
          });
        });
      }
    }
  }

  Future shellChecker() async {
    String? currentShell;
    var shellC = shellEnvironment.entries;
    for (var item in shellC) {
      if (item.key == "SHELL") {
        currentShell = item.value;
        print(currentShell);
      }
    }
    return currentShell;
  }

  //linux specificCode
  void setPathInLinux() async {
    // print('yo');

    String currentShell = await shellChecker();
    status = 'Setting Path';
    notifyListeners();
    try {
      if (currentShell.toString().contains('fish')) {
        File(p.joinAll([getHomepath(), '.config', 'fish', 'config.fish']))
            .writeAsStringSync(
                "\nset fish_user_paths " +
                    p.join(await getPath(), '.envSdk', 'flutter-master',
                        'bin' + (" :\$fish_user_paths\n")),
                mode: FileMode.append);
      } else if (currentShell.toString().contains('zsh')) {
        // print('zsh');
        File(p.joinAll([
          getHomepath(),
          '.zshrc',
        ])).writeAsStringSync(
            "\nPATH=" +
                p.join(
                    path, '.envSdk', 'flutter-master', 'bin' + (" :\$PATH\n")),
            mode: FileMode.append);
      } else if (currentShell.toString().contains('bash')) {
        File(p.joinAll([getHomepath(), '.bashrc'])).writeAsStringSync(
            "\nPATH=" +
                p.join(
                    path, '.envSdk', 'flutter-master', 'bin' + (" :\$PATH\n")),
            mode: FileMode.append);
        // print('bash');
      } else {
        status =
            'Shell not recognised we only support fish,zsh and bash shell currently';
        notifyListeners();
      }
    } on Exception catch (e) {
      status = e.toString();
      notifyListeners();
    }
    dStared = !dStared;
    status = 'Installation Completed';
    notifyListeners();
  }

  Future getPath() async {
    Directory? path = await getDownloadsDirectory();
    String? dPath = path?.path;
    // print(dPath);

    return dPath;
  }

  String getHomepath() {
    String os = Platform.operatingSystem;
    String home = "";
    Map<String, String> envVars = Platform.environment;
    if (Platform.isMacOS) {
      home = envVars['HOME'].toString();
    } else if (Platform.isLinux) {
      home = envVars['HOME'].toString();
    } else if (Platform.isWindows) {
      home = envVars['UserProfile'].toString();
    }
    stdout.writeln(home);
    return home;
  }
  // print(response.headers);
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutterinstaller/helpers/download_helper.dart';
import 'package:flutterinstaller/helpers/net_checker.dart';

final netStatusProvider =
    StreamProvider.autoDispose<ConnectivityResult>((ref) async* {
  // return NetChecker().connectionStatusController.stream;

  final status = NetChecker().connectionStatusController;

  await for (final value in status.stream) {
    // print(value.toString());

    yield value;
  }
});

// final downloadProgress = StreamProvider<double>((ref) async* {
//   final progress = DownloadHelper().progress;

//   await for (final value in progress.stream) {
//     yield value;
//   }
// });

final progress = ChangeNotifierProvider<DownloadHelper>((ref) {
  return DownloadHelper();
});

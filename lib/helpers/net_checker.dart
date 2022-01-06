import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetChecker {
  StreamController<ConnectivityResult> connectionStatusController =
      StreamController<ConnectivityResult>();

  NetChecker() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult event) {
      connectionStatusController.add(_getStatusFromResult(event));
    });
  }

  ConnectivityResult _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityResult.mobile;
      case ConnectivityResult.wifi:
        return ConnectivityResult.wifi;
      case ConnectivityResult.ethernet:
        return ConnectivityResult.ethernet;
      case ConnectivityResult.none:
        return ConnectivityResult.none;
      default:
        return ConnectivityResult.none;
    }
  }
}





// enum NetworkStatus { Online, Offline }

// class NetworkStatusService {
//   StreamController<NetworkStatus> networkStatusController =
//       StreamController<NetworkStatus>();

//   NetworkStatusService() {
//     Connectivity().onConnectivityChanged.listen((status){
//       networkStatusController.add(_getNetworkStatus(status));
//     });
//   }

//   NetworkStatus _getNetworkStatus(ConnectivityResult status) {
//     return status == ConnectivityResult.mobile || status == ConnectivityResult.wifi 
//? NetworkStatus.Online
// : NetworkStatus.Offline;
//   }
// }

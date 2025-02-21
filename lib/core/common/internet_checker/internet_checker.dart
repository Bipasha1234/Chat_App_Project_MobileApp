import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  Future<bool> checkConnectivity() async {
    ConnectivityResult result =
        (await Connectivity().checkConnectivity()) as ConnectivityResult;
    return result != ConnectivityResult.none;
  }
}

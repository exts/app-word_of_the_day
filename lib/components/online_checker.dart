import 'package:connectivity/connectivity.dart';

class OnlineChecker {
  static Future<bool> isNotOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none;
  }
}

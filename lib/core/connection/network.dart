import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager {
  static Future<bool> isNetworkAvailable() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}

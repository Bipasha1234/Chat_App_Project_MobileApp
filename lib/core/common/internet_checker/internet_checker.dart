import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectivity {
  late StreamSubscription _subscription;
  bool isDeviceConnected = false;

  // Method to initialize the connectivity checker and listen for connectivity changes
  Future<void> initializeConnectivity() async {
    // Check initial internet connection
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    // Listen to connectivity changes
    _subscription = InternetConnectionChecker().onStatusChange.listen(
      (status) {
        isDeviceConnected = (status == InternetConnectionStatus.connected);
      },
    );
  }

  // Method to cancel the subscription when the widget is disposed
  void dispose() {
    _subscription.cancel();
  }

  // Method to check if the device is connected
  bool get isConnected => isDeviceConnected;
}

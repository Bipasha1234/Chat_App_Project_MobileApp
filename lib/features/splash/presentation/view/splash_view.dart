// import 'package:cool_app/features/splash/presentation/view_model/splash_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SplashView extends StatefulWidget {
//   const SplashView({super.key});

//   @override
//   State<SplashView> createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<SplashCubit>().init(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min, // Adjusts spacing properly
//               children: [
//                 SizedBox(
//                   height: 350,
//                   width: 350,
//                   child: Image.asset('assets/images/chattix.png'),
//                 ),
//                 const SizedBox(height: 10), // Minimal gap
//                 const Text(
//                   'Chat Application',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 15), // Small gap before loading
//                 const CircularProgressIndicator(),
//               ],
//             ),
//           ),
//           const Positioned(
//             bottom: 20,
//             left: 0,
//             right: 0,
//             child: Text(
//               'Developed by: Bipasha Lamsal',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 10),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:cool_app/features/splash/presentation/view_model/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late StreamSubscription _subscription;
  bool isDeviceConnected = false;
  bool showInternetDialog = false;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    context.read<SplashCubit>().init(context);
  }

  _checkConnectivity() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (!isDeviceConnected) {
      _showNoInternetDialog();
    }

    _subscription = InternetConnectionChecker().onStatusChange.listen(
      (status) {
        isDeviceConnected = (status == InternetConnectionStatus.connected);
        if (!isDeviceConnected && !showInternetDialog) {
          _showNoInternetDialog();
        } else if (isDeviceConnected && showInternetDialog) {
          _showInternetBackDialog();
        }
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  _showNoInternetDialog() {
    setState(() {
      showInternetDialog = true;
    });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('No Internet Connection'),
        content: const Text('Please check your internet connectivity.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  _showInternetBackDialog() {
    setState(() {
      showInternetDialog = false;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Internet Back'),
        content: const Text(
            'Your internet connection is back. You can continue now.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 350,
                  width: 350,
                  child: Image.asset('assets/images/chattix.png'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Chat Application',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const CircularProgressIndicator(),
              ],
            ),
          ),
          const Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Text(
              'Developed by: Bipasha Lamsal',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}

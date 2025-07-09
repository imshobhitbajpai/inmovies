import 'dart:async';

import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetConnectivity extends GetxController {
  StreamSubscription<List<ConnectivityResult>>? _connectionCheckStream;
  bool isConnected = true;

  InternetConnectivity() {
    _initSubs();
  }

  Future<bool> isConnectedToInternet() async {
    return (await InternetConnection().hasInternetAccess);
  }

  _initSubs() async {
    bool justLaunched = true;
    List<ConnectivityResult> directCheckResult = await Connectivity().checkConnectivity();
    await Future.delayed(const Duration(seconds: 5));
    _connectionCheckStream = Connectivity().onConnectivityChanged.listen(
      (changingResult) {
        debugPrint("### connectivity().onConnectivityChanged.listen: $changingResult ###");
        if (justLaunched) {
          justLaunched = false;
          return;
        }
        if (const ListEquality().equals(directCheckResult, changingResult)) {
          return;
        }
        directCheckResult = changingResult;
        if (!changingResult.contains(ConnectivityResult.none)) {
          isConnected = true;
          debugPrint("$runtimeType======ONLINE====");
          Get.showSnackbar(const GetSnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green,
            title: 'Online',
            message: 'Internet Connection is back',
          ));
        } else {
          isConnected = false;
          debugPrint("$runtimeType======OFFLINE====");
          Get.showSnackbar(
            const GetSnackBar(
                duration: Duration(seconds: 3),
                backgroundColor: Colors.red,
                title: 'Offline',
                message: 'No Internet Connection'),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _connectionCheckStream?.cancel();
    super.dispose();
  }
}

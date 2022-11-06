import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';


enum ConnectivityStatus{
  ON,
  OFF,
  CHECK
}


final connectionProvider = StateNotifierProvider<ConnectivityProvider, ConnectivityStatus>((ref) => ConnectivityProvider(ref));
class ConnectivityProvider extends StateNotifier<ConnectivityStatus>{

  ConnectivityStatus? connectivityStatus;

  StateNotifierProviderRef ref;
  ConnectivityProvider(this.ref) : super(ConnectivityStatus.CHECK) {
    connectivityStatus = ConnectivityStatus.CHECK;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      print(result);
      if (result == ConnectivityResult.none) {
        state = ConnectivityStatus.OFF;
      } else {
        await _updateConnectionStatus().then((ConnectivityStatus isConnected) {
          state = isConnected;
        });
      }

    });
  }

  Future<ConnectivityStatus> _updateConnectionStatus() async {
    ConnectivityStatus connectivityStatus;
    try {
      final List<InternetAddress> result =
      await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectivityStatus = ConnectivityStatus.ON;
      }else{
        connectivityStatus =  ConnectivityStatus.OFF;
      }
    } on SocketException catch (_) {
      connectivityStatus =  ConnectivityStatus.OFF;
    }
    return connectivityStatus;
  }
}



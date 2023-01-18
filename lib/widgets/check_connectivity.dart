import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChechConnectivity extends StatefulWidget {
  final Widget child;
  const ChechConnectivity({super.key, required this.child});

  @override
  State<ChechConnectivity> createState() => _ChechConnectivityState();
}

class _ChechConnectivityState extends State<ChechConnectivity> {
  late Timer timer;
  bool connectivity = false;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => checkConnectivity());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (connectivity == true) {
      return widget.child;
    } else {
      return const Scaffold(
        body: Center(
          child: Text('data'),
        ),
      );
    }
  }

  Future<void> checkConnectivity() async {
    if (!kIsWeb) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          if (connectivity == false) {
            setState(() {
              connectivity = true;
            });
          }
        }
      } on SocketException catch (_) {
        if (connectivity == true) {
          setState(() {
            connectivity = false;
          });
        }
      }
    }
  }
}

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
        const Duration(seconds: 2), (Timer t) => checkConnectivity());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          widget.child,
          Visibility(
            visible: connectivity ? false : true,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.withOpacity(0.6),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.signal_wifi_connected_no_internet_4_rounded,
                        size: 60,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'لا يوجد إتصال بالانترنت، ... \n الرجاء الاتصال بالانترنت لتشغيل التطبيق',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

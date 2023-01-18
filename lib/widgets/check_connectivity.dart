import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChechConnectivity extends StatefulWidget {
  const ChechConnectivity({super.key});

  @override
  State<ChechConnectivity> createState() => _ChechConnectivityState();
}

class _ChechConnectivityState extends State<ChechConnectivity> {
  Future<void> check() async {
    if (kIsWeb) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

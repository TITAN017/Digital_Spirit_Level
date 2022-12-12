import 'package:flutter_blue/flutter_blue.dart';
//ignore_for_file:avoid_print
//ignore_for_file:prefer_const_constructors

class BT {
  static FlutterBlue bt = FlutterBlue.instance;

  Stream<List<ScanResult>> get btdevices {
    return bt.scanResults;
  }

  static void scan() {
    print('starting scan');
    // Start scanning
    bt.startScan(timeout: Duration(seconds: 4));

    print('started scan');

    print('stopping scan');

// Stop scanning
    bt.stopScan();
  }
}

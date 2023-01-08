import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BTModel {
  BluetoothState state;
  String? addr;
  String? name;
  List btdevice;
  BTModel({
    required this.state,
    required this.addr,
    required this.name,
    required this.btdevice,
  });
}

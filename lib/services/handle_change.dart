import 'package:digital_spirit_level/DiscoveryPage.dart';
import 'package:digital_spirit_level/screens/initial_screen.dart';
import 'package:digital_spirit_level/screens/pages/page_1.dart';
import 'package:digital_spirit_level/services/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

bool handleChange(WidgetRef ref, BuildContext context, int index) {
  if (index == 1) {
    if (ref.read(deviceProvider.notifier).state == null) {
      showSnack(context, 'Device Error!');
      print(ref.read(pageProvider.notifier).state);
      return true;
    }
    if (!ref.read(btProvider.notifier).state!.state.isEnabled) {
      showSnack(context, 'Please Enable Bluetooth!');
      return true;
    }
  }
  ref.read(pageProvider.notifier).update((state) => index);
  print(ref.read(pageProvider.notifier).state);
  return false;
}

import 'package:digital_spirit_level/DiscoveryPage.dart';
import 'package:digital_spirit_level/screens/initial_screen.dart';
import 'package:digital_spirit_level/screens/pages/page_1.dart';
import 'package:digital_spirit_level/services/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void handleChange(WidgetRef ref, BuildContext context, int index) {
  int oldIndex = ref.read(pageProvider.notifier).state;
  if (index == 1) {
    if (ref.read(deviceProvider.notifier).state == null) {
      showSnack(context, 'Device Error!');
      ref.read(pageProvider.notifier).update((state) => 0);
      print(ref.read(pageProvider.notifier).state);
      return;
    }
  }
  ref.read(pageProvider.notifier).update((state) => index);
}
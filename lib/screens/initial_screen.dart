import 'package:digital_spirit_level/Theme/icon_theme.dart';
import 'package:digital_spirit_level/model/btmodel.dart';
import 'package:digital_spirit_level/screens/pages/page_0.dart';
import 'package:digital_spirit_level/screens/pages/page_1.dart';
import 'package:digital_spirit_level/screens/pages/page_3.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../services/handle_change.dart';

final themeProvider = StateProvider<int>((ref) => 0);

final pageProvider = StateProvider<int>((ref) => 0);

final btProvider = StateProvider<BTModel?>((ref) => BTModel(
    state: BluetoothState.UNKNOWN, addr: "...", name: "...", btdevice: []));

class PrimaryPage extends ConsumerStatefulWidget {
  const PrimaryPage({Key? key}) : super(key: key);

  @override
  PrimaryPageState createState() => PrimaryPageState();
}

class PrimaryPageState extends ConsumerState<PrimaryPage> {
  BluetoothState btstate = BluetoothState.UNKNOWN;
  late Object obj;
  String? _address = "...";
  String? _name = "...";
  List<BluetoothDevice> btdevice = [];
  @override
  void initState() {
    super.initState();

    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> l) {
      btdevice = l;
      for (var r in btdevice) {
        print(r.name);
      }
      setState(() {});
    });

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        btstate = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled

      if (await FlutterBluetoothSerial.instance.isEnabled != null) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        ref.read(btProvider.notifier).update((old) {
          old!.addr = address;
          return old;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      ref.read(btProvider.notifier).update((old) {
        old!.name = name;
        return old;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      ref.read(btProvider.notifier).update((old) {
        old!.state = state;
        print('inside the initsate : $state');
        return old;
      });
    });

    ref.read(btProvider.notifier).update((state) => BTModel(
        state: btstate, addr: _address, name: _name, btdevice: btdevice));

    print(
        'inside the class : ${ref.read(btProvider.notifier).state!.state.isEnabled}');
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Key navBarKey = const Key('NavBar');
    int index = ref.watch(pageProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: const Icon(
          IconData(0xe185, fontFamily: 'MaterialIcons'),
        ),
        title: Text(
          'Digital Spirit Level',
          style: GoogleFonts.acme(letterSpacing: 1),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              print(ref.read(themeProvider.notifier).state);
              ref.read(themeProvider.notifier).update((state) {
                if (state == 0) {
                  return 1;
                } else {
                  return 0;
                }
              });
            },
            icon: CustomIcons.icons[ref.watch(themeProvider)]!,
          ),
        ],
      ),
      body: selectPage(index),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black26,
        ),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(15),
        child: GNav(
          key: navBarKey,
          rippleColor: Colors.black,
          selectedIndex: index,
          tabBorderRadius: 20,
          iconSize: 26,
          tabBackgroundColor: Colors.black26,
          gap: 5,
          padding: EdgeInsets.all(15),
          onTabChange: (i) {
            var check = handleChange(ref, context, i);
            print(check);
          },
          tabs: [
            GButton(
              icon: Icons.settings_outlined,
              text: 'Settings',
              textStyle: GoogleFonts.acme(),
            ),
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
              textStyle: GoogleFonts.acme(),
            ),
            GButton(
              icon: Icons.credit_card_outlined,
              text: 'Credits',
              textStyle: GoogleFonts.acme(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget selectPage(int index) {
  switch (index) {
    case 0:
      return Page0();

    case 1:
      return Page1();
    case 2:
      return Page2();
    default:
      return Container();
  }
}

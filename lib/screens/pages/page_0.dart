import 'package:digital_spirit_level/screens/initial_screen.dart';
import 'package:digital_spirit_level/services/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../ChatPage.dart';
import '../../DiscoveryPage.dart';
import '../../Theme/color_theme.dart';

class Page0 extends ConsumerStatefulWidget {
  const Page0({Key? key}) : super(key: key);

  @override
  _Page0State createState() => _Page0State();
}

class _Page0State extends ConsumerState<Page0> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SwitchListTile(
                    activeColor: Color(0xff3ac7c4),
                    title: Text(
                      'Enable Bluetooth',
                      style: GoogleFonts.acme(
                          color: CustomTheme.textColor[
                              ref.read(themeProvider.notifier).state],
                          fontSize: 16),
                    ),
                    value:
                        ref.watch(btProvider.notifier).state!.state.isEnabled,
                    onChanged: (bool value) {
                      // Do the request and update with the true value then
                      future() async {
                        // async lambda seems to not working
                        if (value) {
                          await FlutterBluetoothSerial.instance.requestEnable();
                          print(value);
                        } else
                          await FlutterBluetoothSerial.instance
                              .requestDisable();
                      }

                      future().then((_) {
                        setState(() {});
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text('Bluetooth status',
                        style: GoogleFonts.acme(
                            color: CustomTheme.textColor[
                                ref.read(themeProvider.notifier).state],
                            fontSize: 16)),
                    subtitle: Text(
                        ref
                            .watch(btProvider.notifier)
                            .state!
                            .state
                            .toString()
                            .split('.')[1],
                        style: GoogleFonts.acme(
                            color: CustomTheme.textColor[
                                ref.read(themeProvider.notifier).state],
                            fontSize: 16)),
                    trailing: ElevatedButton(
                      child: const Icon(Icons.bluetooth_outlined),
                      onPressed: () {
                        FlutterBluetoothSerial.instance.openSettings();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      'Local adapter address',
                      style: GoogleFonts.acme(
                          color: CustomTheme.textColor[
                              ref.read(themeProvider.notifier).state],
                          fontSize: 16),
                    ),
                    subtitle: Text(ref.watch(btProvider.notifier).state!.addr!),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text('Local adapter name',
                        style: GoogleFonts.acme(
                            color: CustomTheme.textColor[
                                ref.read(themeProvider.notifier).state],
                            fontSize: 16)),
                    subtitle: Text(ref.watch(btProvider.notifier).state!.name!),
                    onLongPress: null,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 1.3),
              child: ListTile(
                title: TextButton(
                    child: Text('Connect to Digital Spirit Level',
                        style: GoogleFonts.acme(
                            color: CustomTheme.textColor[
                                ref.read(themeProvider.notifier).state],
                            fontSize: 18)),
                    onPressed: () async {
                      if (!ref
                          .read(btProvider.notifier)
                          .state!
                          .state
                          .isEnabled) {
                        showSnack(context, "Please Enable Bluetooth!");
                        return;
                      }
                      final BluetoothDevice selectedDevice =
                          await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return DiscoveryPage();
                          },
                        ),
                      );

                      if (selectedDevice != null) {
                        print(
                            'Discovery -> selected ' + selectedDevice.address);
                      } else {
                        print('Discovery -> no device selected');
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ChatPage(server: server);
        },
      ),
    );
  }
}

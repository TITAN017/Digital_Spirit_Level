import 'dart:convert';
import 'dart:typed_data';

import 'package:digital_spirit_level/DiscoveryPage.dart';
import 'package:digital_spirit_level/model/xyval.dart';
import 'package:digital_spirit_level/screens/initial_screen.dart';
import 'package:digital_spirit_level/services/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../../model/msg.dart';

final connectionProvider = StateProvider<BluetoothConnection?>((ref) => null);

final valProvider = StateProvider<XYVal>((ref) => XYVal(x: '0.00', y: '0.00'));

class Page1 extends ConsumerStatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends ConsumerState<Page1> {
  static final clientID = 0;
  var connection; //BluetoothConnection

  List<Message> messages = [Message(1, "Y-Axis:-0.00\nX-Axis:-0.00")];
  String _messageBuffer = '';

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool isDisconnecting = false;

  String getXAxis() {
    if (messages.isNotEmpty) {
      var text = messages[0].text.trim().split('\n');
      //print('x - $text');
      if (text.length != 1) {
        return text[1].split(':')[1];
      } else {
        return 'N/A';
      }
    } else {
      return 'N/A';
    }
  }

  String getYAxis() {
    if (messages.isNotEmpty) {
      var text = messages[0].text.trim().split('\n')[0].split(':');
      //print('y -$text');
      if (text.length != 1) {
        return text[1];
      } else {
        return 'N/A';
      }
    } else {
      return 'N/A';
    }
  }

  @override
  void initState() {
    super.initState();
    ref
        .read(valProvider.notifier)
        .update((state) => XYVal(x: getXAxis(), y: getYAxis()));
    final BluetoothDevice? dev = ref.read(deviceProvider.notifier).state;
    if (ref.read(deviceProvider.notifier).state == null) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        ref.read(pageProvider.notifier).update((state) => 0);
        showSnack(context, 'Device Error');
        print('log');
      });
      print('log');
    } else {
      print('log');
      print('success!');
      BluetoothConnection.toAddress(
              ref.read(deviceProvider.notifier).state!.address)
          .then((_connection) {
        print('Connected to the device');
        connection = _connection;
        ref.read(connectionProvider.notifier).update((state) => _connection);
        print('prov value : ${ref.read(connectionProvider.notifier).state}');
        setState(() {
          isConnecting = false;
          isDisconnecting = false;
        });
        print('log');
        connection.input.listen(_onDataReceived).onDone(() {
          if (isDisconnecting) {
            print('Disconnecting locally!');
          } else {
            print('Disconnected remotely!');
          }
          if (this.mounted) {
            setState(() {});
          }
        });
      }).catchError((error) {
        print('Cannot connect, exception occured');
        print(error);
      });
      print('log');
    }
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected()) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double x =
        double.parse(ref.watch(valProvider.notifier).state.x) / 180 * 3.14;
    double y =
        double.parse(ref.watch(valProvider.notifier).state.y) / 180 * 3.14;
    return Container(
      decoration: BoxDecoration(),
      width: MediaQuery.of(context).size.width,
      /*constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height),*/
      child: Column(),
    );
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      if (mounted) {
        setState(() {
          //print('length: ${messages.length}');
          messages = [];
          messages.add(
            Message(
              1,
              backspacesCounter > 0
                  ? _messageBuffer.substring(
                      0, _messageBuffer.length - backspacesCounter)
                  : _messageBuffer + dataString.substring(0, index),
            ),
          );
          _messageBuffer = dataString.substring(index);
        });
      }
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void _sendMessage(String text) async {
    text = text.trim();

    if (text.length > 0) {
      try {
        connection.output.add(utf8.encode(text));
        await connection.output.allSent;

        setState(() {
          messages.add(Message(clientID, text));
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }

  bool isConnected() {
    return connection != null && connection.isConnected;
  }
}

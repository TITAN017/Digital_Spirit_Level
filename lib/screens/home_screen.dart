import 'package:digital_spirit_level/services/bt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BT bt = BT();
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<Object>(
        stream: bt.btdevices,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            for (ScanResult r in snapshot.data as List<ScanResult>) {
              print(r);
            }
            return Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('hasdata'),
                  ElevatedButton(
                    onPressed: () {
                      BT.scan();
                    },
                    child: Text('Scan'),
                  ),
                ],
              ),
            );
          } else {
            return Text('has no data');
          }
        },
      ),
    );
  }
}

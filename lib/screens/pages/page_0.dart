import 'package:flutter/material.dart';

class Page0 extends StatefulWidget {
  const Page0({Key? key}) : super(key: key);

  @override
  State<Page0> createState() => _Page0State();
}

class _Page0State extends State<Page0> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 190,
              color: Colors.white24,
              child: Column(children: [Text('X'), Text('Y')]),
            )
          ],
        ),
      ),
    );
  }
}

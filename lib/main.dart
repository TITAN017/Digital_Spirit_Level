/////////////////////////////////////////////////////////////////
/*
  ESP32 | BLUETOOTH CLASSIC | FLUTTER - Let's build BT Serial based on the examples. (Ft. Chat App)
  Video Tutorial: https://youtu.be/WUw-_X66dLE
  Created by Eric N. (ThatProject)
*/

// Updated 06-21-2021
// Due to Flutter's update, many parts have changed from the tutorial video.
// You need to keep @dart=2.9 before starting main to avoid null safety in Flutter 2
/////////////////////////////////////////////////////////////////

// @dart=2.9
import 'package:digital_spirit_level/Theme/color_theme.dart';
import 'package:digital_spirit_level/screens/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(
      ProviderScope(
        child: ExampleApplication(),
      ),
    );

class ExampleApplication extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.themes[ref.watch(themeProvider)],
      home: PrimaryPage(),
    );
  }
}

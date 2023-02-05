import 'package:digital_spirit_level/Theme/color_theme.dart';
import 'package:digital_spirit_level/screens/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(
      ProviderScope(
        child: MainApplication(),
      ),
    );

class MainApplication extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.themes[ref.watch(themeProvider)],
      home: PrimaryPage(),
    );
  }
}

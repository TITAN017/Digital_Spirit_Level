import 'package:digital_spirit_level/Theme/icon_theme.dart';
import 'package:digital_spirit_level/screens/pages/page_0.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider<int>((ref) => 0);

final pageProvider = StateProvider<int>((ref) => 0);

class PrimaryPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              print(1);
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
      body: ref.watch(pageProvider) == 0
          ? Page0()
          : Container(child: Text('Page 1')),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white24,
            ),
            child: Container()),
      ),
    );
  }
}

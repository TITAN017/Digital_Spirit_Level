import 'package:digital_spirit_level/Theme/color_theme.dart';
import 'package:digital_spirit_level/screens/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_gradient/animate_gradient.dart';

class Page2 extends ConsumerStatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends ConsumerState<Page2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(Icons.favorite),
              Text(
                'CREDITS',
                style: GoogleFonts.acme(
                  fontSize: 30,
                  color: CustomTheme
                      .textColor[ref.read(themeProvider.notifier).state],
                  letterSpacing: 2,
                ),
              ),
              const Icon(Icons.favorite),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 7,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text(
                  'Rohan Revankar',
                  style: GoogleFonts.acme(
                      fontSize: 40,
                      foreground: Paint()
                        ..shader = CustomTheme.creditTheme[
                            ref.watch(themeProvider.notifier).state]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Text(
                  'Suraj Ponnanna',
                  style: GoogleFonts.acme(
                      fontSize: 40,
                      foreground: Paint()
                        ..shader = CustomTheme.creditTheme[
                            ref.watch(themeProvider.notifier).state]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

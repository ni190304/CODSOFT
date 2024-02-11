import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as html;
import 'package:quote/animatedboxes/neubox2.dart';
import 'package:quote/animatedboxes/neubox3.dart';
import 'package:quote/animatedboxes/neubox4.dart';
import 'package:quote/ran_quote.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Random random = Random();
  late int _currentIndex;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentIndex = random.nextInt(formattedquotes.length);
    _timer = Timer.periodic(Duration(days: 1), (timer) {
      setState(() {
        _currentIndex = Random().nextInt(formattedquotes.length);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void share() {}

  @override
  Widget build(BuildContext context) {
    TextStyle message() {
      return GoogleFonts.ebGaramond(
          fontSize: 26,
          color: Theme.of(context).colorScheme.onSecondaryContainer);
    }

    TextStyle author() {
      return GoogleFonts.caveat(fontSize: 23, color: Colors.black);
    }

    TextStyle title() {
      return GoogleFonts.redHatDisplay(fontSize: 28, color: Colors.black);
    }

    return Scaffold(
      body: Center(
        child: Neubox4(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Wisdom Nuggets',
                    style:
                        title().copyWith(decoration: TextDecoration.underline),
                  )),
              const SizedBox(
                height: 120,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(formattedquotes[_currentIndex].message,
                    textAlign: TextAlign.center, style: message()),
              ),
              const SizedBox(height: 35),
              Align(
                alignment: Alignment.bottomRight,
                child: Text('- ${formattedquotes[_currentIndex].author}',
                    textAlign: TextAlign.center, style: author()),
              ),
              const SizedBox(
                height: 65,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Neubox3(
                    ss: share,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            tooltip: 'Share',
                            onPressed: () {},
                            icon: const Icon(
                              Icons.share_sharp,
                              color: Colors.green,
                            )),
                        Text(
                          'Share',
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.favorite_border,
                    size: 32,
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

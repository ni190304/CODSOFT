import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quote/animatedboxes/neubox3.dart';
import 'package:quote/animatedboxes/neubox4.dart';
import 'package:quote/info/ran_quote.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

int _fav = 0;
late int _bookmark;

final email = FirebaseAuth.instance.currentUser!.email;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class FavIndexNotifier extends ChangeNotifier {
  int get fav => _fav;

  Future<void> increment() async {
    _fav++;
    notifyListeners();
    await _saveFavIndexToPrefs();
  }

  // Load index from shared preferences during initialization
  Future<void> loadFavIndexFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _fav = prefs.getInt('${email}FavIndex') ?? 1;
    notifyListeners();
  }

  // Save index to shared preferences
  Future<void> _saveFavIndexToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${email}FavIndex', _fav);
  }
}

void showdismsnack2(BuildContext context) => {
      Flushbar(
        shouldIconPulse: false,
        icon: const Icon(
          Icons.image,
          color: Colors.black,
        ),
        message: 'Saved to Gallery successfully',
        messageSize: 16,
        messageColor: Colors.white,
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        duration: const Duration(milliseconds: 1500),
        padding: const EdgeInsets.all(24),
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        borderRadius: BorderRadius.circular(20),
        barBlur: 15,
        backgroundColor: Colors.black.withOpacity(0.5),
        backgroundGradient: LinearGradient(colors: [
          Colors.black,
          Theme.of(context).colorScheme.primary,
          const Color.fromARGB(255, 64, 64, 64),
        ]),
      )..show(context)
    };

void showdismsnack(BuildContext context) => {
      Flushbar(
        shouldIconPulse: false,
        icon: const Icon(
          Icons.image,
          color: Colors.black,
        ),
        message: 'Saved to Favorites successfully',
        messageSize: 15,
        messageColor: Colors.white,
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
        duration: const Duration(milliseconds: 1500),
        padding: const EdgeInsets.all(24),
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        borderRadius: BorderRadius.circular(20),
        barBlur: 15,
        backgroundColor: Colors.black.withOpacity(0.5),
        backgroundGradient: LinearGradient(colors: [
          Colors.black,
          Theme.of(context).colorScheme.primary,
          const Color.fromARGB(255, 64, 64, 64),
        ]),
      )..show(context)
    };

class _HomeState extends State<Home> {
  final Random random = Random();
  late int _currentIndex;
  late Timer _timer;
  final controller = ScreenshotController();
  String? email;
  bool isFav = false;
  bool isbm = false;

  @override
  void initState() {
    final email = FirebaseAuth.instance.currentUser!.email;
    super.initState();
    _currentIndex = random.nextInt(formattedquotes.length);
    _timer = Timer.periodic(Duration(days: 1), (timer) {
      setState(() {
        _currentIndex = random.nextInt(formattedquotes.length);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> saveAndShare(Uint8List bytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imageFile = File('${directory.path}/flutter.png');
      await imageFile.writeAsBytes(bytes);

      final xFile = XFile(imageFile.path);

      await Share.shareXFiles([xFile]);
    } catch (e) {
      print('Error sharing: $e');
    }
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'screenshot_$time';

    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'];
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
        body: Center(
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 500));
              setState(() {
                _currentIndex = random.nextInt(formattedquotes.length);
              });
            },
            color: Theme.of(context).colorScheme.onSecondaryContainer,
            child: Center(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Stack(
                    children: [
                      buildImage(),
                      Positioned(
                        bottom: 0,
                        right:24,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: IconButton(
                            color: Colors.red,
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              size: 34,
                            ),
                            onPressed: () async {
                              final favIndexNotifier =
                                  Provider.of<FavIndexNotifier>(context,
                                      listen: false);
            
                              setState(() {
                                isFav = !isFav;
                              });
            
                              final email =
                                  FirebaseAuth.instance.currentUser!.email;
            
                              await FirebaseFirestore.instance
                                  .collection('Favorites')
                                  .doc(email)
                                  .collection("Quotes")
                                  .doc("Quote${favIndexNotifier.fav}")
                                  .set({
                                "message": formattedquotes[_currentIndex].message,
                                "author": formattedquotes[_currentIndex].author,
                                "isFav": isFav
                              });
            
                              favIndexNotifier.increment();
            
                              showdismsnack(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Neubox3(
                        ss: () async {
                          final image =
                              await controller.captureFromWidget(buildImage());
            
                          if (image == null) return;
            
                          await saveAndShare(image);
                        },
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
                            const Text(
                              'Share',
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Neubox3(
                        ss: () async {
                          final image =
                              await controller.captureFromWidget(buildImage());
            
                          if (image == null) return;
            
                          await saveImage(image);
            
                          showdismsnack2(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                tooltip: 'Capture',
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                )),
                            const Text(
                              'Capture',
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    TextStyle message() {
      return GoogleFonts.ebGaramond(
          fontSize: 27,
          color: Theme.of(context).colorScheme.onSecondaryContainer, fontWeight: FontWeight.w100);
    }

    TextStyle author() {
      return GoogleFonts.caveat(fontSize: 24, color: Colors.black);
    }

    TextStyle title() {
      return GoogleFonts.redHatDisplay(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500);
    }

    return Center(
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
                style: title(),
              ),
            ),
            const SizedBox(
              height: 90,
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
          ],
        ),
      ),
    );
  }
}

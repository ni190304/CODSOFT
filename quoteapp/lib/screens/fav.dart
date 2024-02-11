import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../animatedboxes/neubox4.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  String? email;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser?.email;
  }

  TextStyle namestyle1() {
    return GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Color.fromARGB(255, 37, 26, 22),
        fontSize: 28,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Stream<QuerySnapshot> getFavQuotesStream(String useremail) {
    return FirebaseFirestore.instance
        .collection("Favorites")
        .doc(useremail)
        .collection("Quotes")
        .where('isFav', isEqualTo: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle messagestyle() {
      return GoogleFonts.ebGaramond(
          fontSize: 27,
          color: Theme.of(context).colorScheme.onSecondaryContainer);
    }

    TextStyle authorstyle() {
      return GoogleFonts.caveat(fontSize: 24, color: Colors.black);
    }

    TextStyle titlestyle() {
      return GoogleFonts.redHatDisplay(fontSize: 28, color: Colors.black);
    }

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: getFavQuotesStream(email!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error : ${snapshot.error}"),
                    );
                  } else if (snapshot.data == null ||
                      snapshot.data!.docs.isEmpty) {
                    return Center(
                        child: SizedBox(
                      height: 500,
                      width: 500,
                      child: Lottie.asset('lib/animations/todo4.json'),
                    ));
                  } else {
                    List<Map<String, dynamic>> quotesList = snapshot.data!.docs
                        .map((doc) => doc.data() as Map<String, dynamic>)
                        .toList();

                    var lengt = quotesList.length;

                    return Expanded(
                      child: ListView.builder(
                        itemCount: lengt,
                        itemBuilder: (context, index) {
                          var quote = quotesList[index];

                          var message = quote['message'];
                          var author = quote['author'];

                          var favStatus = quote['isFav'];

                          return Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Neubox4(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Amongst Your Favorites',
                                                style: titlestyle().copyWith(
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 120,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(message,
                                                  textAlign: TextAlign.center,
                                                  style: messagestyle()),
                                            ),
                                            const SizedBox(height: 35),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text('- $author',
                                                  textAlign: TextAlign.center,
                                                  style: authorstyle()),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: IconButton(
                                            color: Colors.red,
                                            icon: Icon(
                                              favStatus
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              size: 34,
                                            ),
                                            onPressed: () async {
                                              setState(() {
                                                favStatus = !favStatus;
                                              });

                                              await FirebaseFirestore.instance
                                                  .collection('Favorites')
                                                  .doc(email)
                                                  .collection("Quotes")
                                                  .doc(snapshot
                                                      .data!.docs[index].id)
                                                  .update({"isFav": favStatus});

                                              ScaffoldMessenger.of(context)
                                                  .clearSnackBars();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                    content: Text(
                                                        'Removed from favorites successfully')),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

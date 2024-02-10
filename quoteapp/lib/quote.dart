import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'animatedboxes/neubox2.dart';
import 'screens/fav.dart';
import 'screens/home.dart';
import 'screens/profile.dart';

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class Quote extends StatefulWidget {
  const Quote({Key? key}) : super(key: key);

  @override
  State<Quote> createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  String? email;

  int index = 0;
  final _pageController = PageController();

  final _screens = [
    ScrollConfiguration(behavior: NoGlowBehavior(), child: const Home()),
    ScrollConfiguration(behavior: NoGlowBehavior(), child: const Favorites()),
    ScrollConfiguration(behavior: NoGlowBehavior(), child: const Profile()),
  ];

  Future<String?>? user_dp_future;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser?.email;
    getUserImg();
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

  TextStyle signout() {
    return GoogleFonts.lora(
      textStyle: const TextStyle(
        color: Color.fromARGB(255, 130, 11, 4),
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  TextStyle other() {
    return GoogleFonts.lora(
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Future<String?> fetchusernames(String eemail) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Usernames')
          .doc(eemail)
          .get();
      final userName = snapshot['username'] as String?;
      return userName;
    } catch (e) {
      print('Error fetching username: $e');
      return null;
    }
  }

  // ignore: non_constant_identifier_names

  Future<String?> getUserImg() async {
    String imgpath = '$email/profile/$email.jpg';

    try {
      String userDpUrl =
          await FirebaseStorage.instance.ref().child(imgpath).getDownloadURL();
      setState(() {
        user_dp_future = Future.value(userDpUrl);
      });
      return userDpUrl;
    } catch (e) {
      // Handle any errors, such as the image not being available
      print('Error loading profile image: $e');
      setState(() {
        user_dp_future =
            Future.value(null); // Update the Future with null value
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: Builder(
              builder: (BuildContext context) {
                return Align(
                  alignment:
                      Alignment.centerLeft, // Set the alignment to center-left
                  child: IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 7.0, top: 7.0),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black,
                        child: FutureBuilder<String?>(
                          future: user_dp_future, // Use the Future here
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ),
                              ); // Show a loading indicator while fetching the image URL
                            } else if (snapshot.hasData &&
                                snapshot.data != null) {
                              return ClipOval(
                                child: Image.network(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                  height: 49,
                                  width: 49,
                                ),
                              ); // Display the image if available
                            } else {
                              return const Text(
                                  '!'); // Display a message if the image is not available
                            }
                          },
                        ),
                      ),
                    ),
                    iconSize: 28,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                );
              },
            ),
          ),
          drawer: FractionallySizedBox(
            widthFactor: 0.9,
            child: Drawer(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: ListTile(
                              leading: const Neubox2(
                                child: Icon(
                                  Icons.clear_outlined,
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.black,
                            child: FutureBuilder<String?>(
                              future: user_dp_future,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ),
                                  ); // Show a loading indicator while fetching the image URL
                                } else if (snapshot.hasData &&
                                    snapshot.data != null) {
                                  return ClipOval(
                                    child: Image.network(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                      height: 119,
                                      width: 119,
                                    ),
                                  ); // Display the image if available
                                } else {
                                  return const Text(
                                      '!'); // Display a message if the image is not available
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const Home())));
                      },
                      title: Text(
                        'Home',
                        style: other(),
                      ),
                      leading: const Icon(
                        Icons.home,
                        size: 26,
                        color: Colors.orange,
                      ),
                      trailing:
                          const Icon(Icons.arrow_forward_ios_sharp, size: 26),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const Favorites())));
                      },
                      title: Text(
                        'Favorites',
                        style: other(),
                      ),
                      leading: const Icon(
                        Icons.star,
                        size: 26,
                        color: Color.fromARGB(255, 224, 134, 164),
                      ),
                      trailing:
                          const Icon(Icons.arrow_forward_ios_sharp, size: 26),
                    ),
                    const SizedBox(
                      height: 280,
                    ),
                    ListTile(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                      title: Text(
                        'Sign Out',
                        style: signout(),
                      ),
                      leading: const Icon(
                        Icons.logout_outlined,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: PageView(
            onPageChanged: (value) {
              setState(() {
                index = value;
              });
            },
            controller: _pageController,
            children: _screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                index = value;
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut);
              });
            },
            currentIndex: index,
            selectedItemColor: const Color.fromARGB(255, 93, 27, 3),
            unselectedItemColor: Colors.black,
            selectedFontSize: 14,
            unselectedFontSize: 15,
            iconSize: 28,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  index == 0 ? Icons.home : Icons.home_outlined,
                  size: index == 0 ? 32 : 28,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                label: index == 0 ? 'Home' : '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  index == 1 ? Icons.star : Icons.star_border_outlined,
                  size: index == 1 ? 32 : 28,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                label: index == 1 ? 'Favorites' : '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  index == 2
                      ? Icons.account_circle
                      : Icons.account_circle_outlined,
                  size: index == 2 ? 32 : 28,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                label: index == 2 ? 'Profile' : '',
              ),
            ],
          )),
    );
  }
}

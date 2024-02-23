import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/screens/analysis.dart';
import 'package:quiz/screens/home.dart';
import 'package:quiz/screens/profile.dart';

import '../../animatedboxes/neubox2.dart';

TextStyle namestyle1() {
  return GoogleFonts.arya(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 3, 40),
      fontSize: 22,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 3, 40),
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle2() {
  return GoogleFonts.passionsConflict(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 65,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle3() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 3, 40),
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle username() {
  return GoogleFonts.alice(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 23,
      fontWeight: FontWeight.normal,
    ),
  );
}

class Quiz_Screen extends StatefulWidget {
  const Quiz_Screen({Key? key}) : super(key: key);

  @override
  State<Quiz_Screen> createState() => _Quiz_ScreenState();
}

class _Quiz_ScreenState extends State<Quiz_Screen> {
  late PageController _pageController;
  int currentIndex = 0;
  String? email;
  Future<String>? user_dp_future;

  @override
  void initState() {
    email = FirebaseAuth.instance.currentUser!.email;
    super.initState();
  }

  List<Widget> screens = [Home(), Analysis(), Profile()];

  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  Future<String?> getUsername(String email) async {
    final data =
        await FirebaseFirestore.instance.collection('User').doc(email).get();
    return data['username'];
  }

  Future<String?> getUserImg() async {
    String imgpath = '$email/profile/$email.jpg';

    try {
      String user_dp_url =
          await FirebaseStorage.instance.ref().child(imgpath).getDownloadURL();
      setState(() {
        user_dp_future = Future.value(user_dp_url);
      });
      return user_dp_url;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                icon: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black,
                  child: FutureBuilder<String?>(
                    future: user_dp_future, // Use the Future here
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ); // Show a loading indicator while fetching the image URL
                      } else if (snapshot.hasData && snapshot.data != null) {
                        return ClipOval(
                          child: Image.network(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            height: 39,
                            width: 39,
                          ),
                        ); // Display the image if available
                      } else {
                        return const Text(
                            '!'); // Display a message if the image is not available
                      }
                    },
                  ),
                ),
                iconSize: 28,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            );
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'option1':
                  FirebaseAuth.instance.signOut();
                  break;
                default:
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(
                  value: 'option1',
                  child: Theme(
                    data: ThemeData(
                      highlightColor:
                          Colors.blue, // Set your desired background color here
                    ),
                    child: Text(
                      'Logout',
                      style: namestyle3(),
                    ),
                  ),
                ),
              ];
            },
          )
        ],
      ),
      drawer: Drawer(
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 10,
                      width: 10,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ); // Show a loading indicator while fetching the image URL
                  } else if (snapshot.hasData && snapshot.data != null) {
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
            FutureBuilder<String?>(
              future: getUsername(email!),
              builder: (context, profileUserName) {
                if (profileUserName.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (profileUserName.hasError) {
                  return Text(
                      'Error fetching profile picture: ${profileUserName.error}');
                } else if (profileUserName.hasData) {
                  final tt = profileUserName.data;
                  if (tt != null) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        tt,
                        style: username(),
                      ),
                    );
                  } else {
                    return const Text('No profile picture available');
                  }
                } else {
                  return const Text('No profile picture available');
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Profile(),
              )),
              contentPadding: EdgeInsets.all(20),
              title: Text(
                'View Profile',
                style: namestyle1(),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(
            color: Color.fromARGB(255, 227, 223, 223),
            thickness: 0.9,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SafeArea(
                child: PageView(
                  controller: _pageController,
                  children: screens,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 25,
            ),
            label: '',
            activeIcon: Icon(
              Icons.home,
              size: 33,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bar_chart_outlined,
              size: 25,
            ),
            label: '',
            activeIcon: Icon(
              Icons.bar_chart,
              size: 33,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              size: 25,
            ),
            label: '',
            activeIcon: Icon(
              Icons.account_circle,
              size: 33,
            ),
          ),
        ],
      ),
    );
  }
}

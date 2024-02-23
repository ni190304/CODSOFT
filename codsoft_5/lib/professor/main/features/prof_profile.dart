import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Prof_Profile extends StatefulWidget {
  const Prof_Profile({super.key});

  @override
  State<Prof_Profile> createState() => _Prof_ProfileState();
}

class _Prof_ProfileState extends State<Prof_Profile> {
  String? email;

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
        fontSize: 30,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Future<String?> getUsername(String email) async {
    final data =
        await FirebaseFirestore.instance.collection('User').doc(email).get();
    return data['username'];
  }

  Future<String?> getUserImg() async {
    String imgpath = 'Professor/$email/profile/$email.jpg';

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
        body: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                          'Error fetching profile username: ${profileUserName.error}');
                    } else if (profileUserName.hasData) {
                      final tt = profileUserName.data;
                      if (tt != null) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            tt,
                            style: namestyle1(),
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
                  height: 16,
                ),
                Text(email!, style: const TextStyle(fontSize: 19),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

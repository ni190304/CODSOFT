import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import '../animatedboxes/neubox4.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
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

TextStyle _getTextStyle2() {
  return GoogleFonts.katibeh(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 30,
    ),
  );
}

class _IntroState extends State<Intro> {
  String? user_email;
  Future<String?>? user_dp_future;
  var button_pressed = false;

  TextStyle namestyle4() {
    return GoogleFonts.arapey(
      textStyle: const TextStyle(
        color: Color.fromARGB(255, 37, 26, 22),
        fontSize: 24,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    user_email = FirebaseAuth.instance.currentUser!.email;
    getUserImg();
  }

  Future<String?> getUserImg() async {
    String imgpath = '$user_email/profile/$user_email.jpg';

    try {
      String user_dp_url =
          await FirebaseStorage.instance.ref().child(imgpath).getDownloadURL();
      setState(() {
        user_dp_future = Future.value(user_dp_url);
      });
      return user_dp_url;
    } catch (e) {
      print('Error loading profile image: $e');
      setState(() {
        user_dp_future = Future.value(null);
      });
      return null;
    }
  }

  Future<String?> fetchusernames(String eemail) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('UserInfo')
        .doc(eemail)
        .get();

    try {
      final user_name = await snapshot['username'];

      return user_name;
    } catch (e) {
      print('Error fetching username: $e');
      return null;
    }
  }

  File? user_image_file;

  void showdismsnack(BuildContext context) => {
        Flushbar(
          shouldIconPulse: false,
          icon: const Icon(
            Icons.image,
            color: Colors.black,
          ),
          message: 'Profile Image updated successfully',
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

  void pickImagecam() async {
    final userImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 150, imageQuality: 80);

    if (userImage == null) {
      return;
    }

    setState(() {
      user_image_file = File(userImage.path);
    });

    final user_images = FirebaseStorage.instance
        .ref()
        .child(user_email!)
        .child('profile')
        .child('$user_email.jpg');

    final upload_task = user_images.putFile(user_image_file!);

    await upload_task.whenComplete(() async {
      final user_img_url = await user_images.getDownloadURL();
      setState(() {
        user_dp_future = Future.value(user_img_url);
      });
      showdismsnack(context);
    });
  }

  void pickImagegall() async {
    final userImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 150, imageQuality: 80);

    if (userImage == null) {
      return;
    }

    setState(() {
      user_image_file = File(userImage.path);
    });

    final user_images = FirebaseStorage.instance
        .ref()
        .child(user_email!)
        .child('profile')
        .child('$user_email.jpg');

    final upload_task = user_images.putFile(user_image_file!);

    await upload_task.whenComplete(() async {
      final user_img_url = await user_images.getDownloadURL();
      setState(() {
        user_dp_future = Future.value(user_img_url);
      });
      showdismsnack(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 400,
                width: 375,
                child: Lottie.asset('lib/animations/todo1.json'),
              ),
              Neubox4(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.black,
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Color.fromARGB(255, 241, 241,
                                  241), // Adjust the color to control intensity
                              BlendMode
                                  .saturation, // You can try different BlendModes
                            ),
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
                                  );
                                } else if (snapshot.hasData &&
                                    snapshot.data != null) {
                                  return ClipOval(
                                    child: Image.network(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                      height: 80,
                                      width: 80,
                                    ),
                                  );
                                } else {
                                  return const Text('!');
                                }
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: GestureDetector(
                            onTap: pickImagecam,
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.camera_alt,
                                size: 18.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: pickImagegall,
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.photo_size_select_actual_outlined,
                                size: 18.5,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 75,
                      width: 1,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder<String?>(
                          future: fetchusernames(user_email!),
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
                                    style: username(),
                                  ),
                                );
                              } else {
                                return const Text(
                                    'No profile username available');
                              }
                            } else {
                              return const Text(
                                  'No profile username available');
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          user_email!,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 71, 70, 70)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              if (!button_pressed)
                OutlinedButton.icon(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('User')
                        .doc(user_email)
                        .set({'email': user_email});
                  },
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      side: BorderSide(
                        width: 1.0,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                      backgroundColor: const Color.fromARGB(255, 29, 3, 3)),
                  icon: const Icon(Icons.arrow_forward_ios_sharp),
                  label: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, right: 10.0, left: 10.0),
                    child: Text(
                      'Get Started',
                      textAlign: TextAlign.center,
                      style: _getTextStyle2(),
                    ),
                  ),
                ),
              if (button_pressed) const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../animatedboxes/neubox3.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

TextStyle namestyle1() {
  return GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 17, 3, 40),
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle2() {
  return GoogleFonts.alice(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 13, 1, 98),
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle4() {
  return GoogleFonts.alice(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.normal,
    ),
  );
}

TextStyle namestyle5() {
  return GoogleFonts.playfairDisplay(
    textStyle: const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
  );
}

class _AuthScreenState extends State<AuthScreen> {
  TextStyle namestyle3() {
    return GoogleFonts.gowunBatang(
      textStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 55,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  File? user_image_file;
  String? userProfilePic;
  // ignore: non_constant_identifier_names
  String? user_email;

  Color color = Colors.white;

  void pickImagecam() async {
    final userImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 150, imageQuality: 80);

    if (userImage == null) {
      return;
    }

    setState(() {
      user_image_file = File(userImage.path);
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
  }

  var _isLogin = true;

  // ignore: prefer_typing_uninitialized_variables
  var validity;

  // ignore: non_constant_identifier_names
  var is_img_sel = false;

  var _isAuthenticating = false;

  // ignore: non_constant_identifier_names
  var entered_email = '';
  // ignore: non_constant_identifier_names
  var entered_user = '';
  // ignore: non_constant_identifier_names
  var entered_pass = '';

  // ignore: non_constant_identifier_names
  bool visibility_off = true;

  final _emailnode = FocusNode();

  // ignore: non_constant_identifier_names
  final _email_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final _username_controller = TextEditingController();
  // ignore: non_constant_identifier_names
  final _password_controller = TextEditingController();

  @override
  void dispose() {
    _email_controller.dispose();
    _username_controller.dispose();
    _password_controller.dispose();
    _emailnode.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();

  void showdismsnack(BuildContext context) => {
        Flushbar(
          shouldIconPulse: false,
          icon: const Icon(
            Icons.image,
            color: Colors.black,
          ),
          message: 'Invalid credentials',
          messageSize: 16,
          messageColor: Colors.white,
          flushbarPosition: FlushbarPosition.TOP,
          margin: const EdgeInsets.fromLTRB(8, kToolbarHeight, 8, 0),
          duration: const Duration(milliseconds: 800),
          padding: const EdgeInsets.all(24),
          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
          borderRadius: BorderRadius.circular(20),
          barBlur: 15,
          backgroundColor: Colors.red.withOpacity(0.5),
          backgroundGradient: LinearGradient(colors: [
            Colors.red,
            Theme.of(context).colorScheme.primary,
            const Color.fromARGB(255, 237, 155, 155),
          ]),
        )..show(context)
      };

  void submitDetails() async {
    // final email = FirebaseAuth.instance.currentUser!.email;
    final isvalid = _formkey.currentState!.validate();

    if (!isvalid) {
      return;
    }

    setState(() {
      validity = isvalid;
    });

    if (user_image_file == null && !_isLogin) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image to proceed')),
      );

      return;
    }

    _formkey.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        // ignore: unused_local_variable
        final UserCredential userCred =
            await _firebase.signInWithEmailAndPassword(
          email: entered_email,
          password: entered_pass,
        );
        // print(userCred);
      } else {
        // ignore: unused_local_variable
        final UserCredential userCred =
            await _firebase.createUserWithEmailAndPassword(
          email: entered_email,
          password: entered_pass,
        );
        // print(userCred);

        final email = FirebaseAuth.instance.currentUser!.email;

        final userImages = FirebaseStorage.instance
            .ref()
            .child(email!)
            .child('profile')
            .child('$email.jpg');

        await FirebaseFirestore.instance
            .collection('UserInfo')
            .doc(email)
            .set({'email': email, 'username': entered_user});

        final uploadTask = userImages.putFile(user_image_file!);

        await uploadTask.whenComplete(() async {
          // ignore: unused_local_variable
          final userImgUrl = await userImages.getDownloadURL();
        });
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      showdismsnack(context);

      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  void focusEmailfield() {
    if (!_emailnode.hasFocus) {
      FocusScope.of(context).requestFocus(_emailnode);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle signinnamestyle() {
      return GoogleFonts.alice(
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.normal,
        ),
      );
    }

    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_isLogin)
                Column(
                  children: [
                    SizedBox(
                      height: isSmallScreen ? 10 : 20,
                    ),
                    CircleAvatar(
                      radius: isSmallScreen ? 60 : 80,
                      backgroundColor: Colors.black,
                      child: user_image_file != null
                          ? ClipOval(
                              child: Image.file(
                              user_image_file!,
                              fit: BoxFit.cover,
                              height: isSmallScreen ? 120 : 170,
                              width: isSmallScreen ? 120 : 170,
                            ))
                          : Lottie.asset('lib/animations/image.json',
                              width: isSmallScreen ? 60 : 120,
                              height: isSmallScreen ? 60 : 120),
                    ),
                    SizedBox(
                      height: isSmallScreen ? 8 : 16,
                    ),
                    ElevatedButton.icon(
                        onPressed: pickImagecam,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.primaryContainer),
                          elevation: MaterialStateProperty.all<double>(3),
                        ),
                        icon: SizedBox(
                            height: 40,
                            width: 40,
                            child: Lottie.asset('lib/animations/cam.json')),
                        label: Text(
                          'Use Camera',
                          style: namestyle1(),
                        )),
                    SizedBox(
                      height: isSmallScreen ? 2 : 4,
                    ),
                    ElevatedButton.icon(
                        onPressed: pickImagegall,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.primaryContainer),
                          splashFactory: NoSplash.splashFactory,
                          elevation: MaterialStateProperty.all<double>(3),
                        ),
                        icon: SizedBox(
                            height: 40,
                            width: 40,
                            child: Lottie.asset('lib/animations/gall.json')),
                        label: Text(
                          'Pick from gallery',
                          style: namestyle1(),
                        )),
                  ],
                ),
              if (_isLogin)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: isSmallScreen ? 12.0 : 25.0,
                  ),
                  child: Text(
                    'QuoteQuest',
                    style: namestyle3(),
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              Card(
                margin: EdgeInsets.all(isSmallScreen ? 10 : 15),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 20.0 : 40.0),
                    child: Column(
                      children: [
                        Form(
                          key: _formkey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                focusNode: _emailnode,
                                controller: _email_controller,
                                style: namestyle4(),
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: namestyle5(),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'Invalid email';
                                  }
                                  if (RegExp(r'[A-Z]').hasMatch(value)) {
                                    return "Email can't have uppercase letters";
                                  }
                                  if (value.contains(' ')) {
                                    return 'Invalid credentials';
                                  }

                                  return null;
                                },
                                autocorrect: true,
                                textCapitalization: TextCapitalization.none,
                                keyboardType: TextInputType.emailAddress,
                                keyboardAppearance: Brightness.dark,
                                onSaved: (newValue) {
                                  entered_email = newValue!;
                                },
                              ),
                              SizedBox(
                                height: isSmallScreen ? 3 : 5,
                              ),
                              if (!_isLogin)
                                TextFormField(
                                  controller: _username_controller,
                                  style: namestyle4(),
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    labelStyle: namestyle5(),
                                  ),
                                  validator: (value) {
                                    if (!RegExp(r'\d').hasMatch(value!)) {
                                      return 'Username must contain a digit';
                                    }
                                    if (value.trim().length < 4) {
                                      return 'Username must contain at least 4 characters';
                                    }

                                    if (value.trim().length > 8) {
                                      return "Username shouldn't exceed 8 characters";
                                    }

                                    if (RegExp(r'[A-Z]').hasMatch(value)) {
                                      return "Username can't have uppercase letters";
                                    }

                                    if (value.contains(' ') ||
                                        value.contains('@')) {
                                      return 'Invalid credentials';
                                    }

                                    return null;
                                  },
                                  autocorrect: true,
                                  textCapitalization: TextCapitalization.none,
                                  keyboardType: TextInputType.name,
                                  onSaved: (newValue) {
                                    entered_user = newValue!;
                                  },
                                ),
                              SizedBox(
                                height: isSmallScreen ? 3 : 5,
                              ),
                              TextFormField(
                                controller: _password_controller,
                                style: namestyle4(),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: namestyle5(),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        visibility_off = !visibility_off;
                                      });
                                    },
                                    child: Icon(visibility_off
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.trim().length < 6) {
                                    return 'Password must contain at least 6 characters';
                                  }

                                  if (value.contains(' ')) {
                                    return 'Invalid credentials';
                                  }

                                  return null;
                                },
                                autocorrect: false,
                                textCapitalization: TextCapitalization.none,
                                obscureText: visibility_off,
                                onSaved: (newValue) {
                                  entered_pass = newValue!;
                                },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: isSmallScreen ? 10 : 25,
                        ),
                        if (_isAuthenticating && validity)
                          const CircularProgressIndicator(),
                        if (!_isAuthenticating)
                          ElevatedButton.icon(
                            onPressed: submitDetails,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.only(
                                  top: 12,
                                  bottom: 12,
                                  left: isSmallScreen ? 10 : 15,
                                  right: isSmallScreen ? 10 : 15),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            icon: Icon(
                              _isLogin
                                  ? Icons.login_rounded
                                  : Icons.account_circle,
                              color: Colors.white,
                            ),
                            label: Text(
                              _isLogin ? 'Login' : 'Signup',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        if (!_isAuthenticating && !_isLogin)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                                _email_controller.clear();
                                _username_controller.clear();
                                _password_controller.clear();
                                focusEmailfield();
                                visibility_off = true;
                              });
                            },
                            style: ButtonStyle(
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent)),
                            child: const Text(
                                'I already have an account. Log in instead'),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: isSmallScreen ? 90 : 110,
              ),
              if (!_isAuthenticating && _isLogin)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                      _email_controller.clear();
                      _username_controller.clear();
                      _password_controller.clear();
                      focusEmailfield();
                      visibility_off = true;
                    });
                  },
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  child: const Text('I am a new member. Create an account'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle _getTextStyle2() {
  return GoogleFonts.katibeh(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 90, 34, 14),
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle _getTextStyle1() {
  return GoogleFonts.cardo(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 27, 17, 1),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

class Stud_Display extends StatefulWidget {
  Stud_Display({Key? key, required this.classes}) : super(key: key);

  final String classes;

  @override
  _Stud_DisplayState createState() => _Stud_DisplayState();
}

class _Stud_DisplayState extends State<Stud_Display> {
  Future<String?> getUsername(String email) async {
    final data =
        await FirebaseFirestore.instance.collection('User').doc(email).get();
    return data['username'];
  }

  Future<List<String>> getStudentEmails() async {
    List<String> studentEmails = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("Student").get();

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        if (data.containsKey("year") && data.containsKey("branch")) {
          String _class = data["class"];

          if (_class == widget.classes) {
            String email = doc.id;
            studentEmails.add(email);
          }
        }
      });
    } catch (e) {
      print("Error fetching student emails: $e");
    }
    return studentEmails;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Enrolled students', style: _getTextStyle1()),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<String>>(
                  future: getStudentEmails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    } else {
                      List<String>? studentEmails = snapshot.data;
                      if (studentEmails != null && studentEmails.isNotEmpty) {
                        return ListView.builder(
                          itemCount: studentEmails.length,
                          itemBuilder: (context, index) {
                            final currentEmail = studentEmails[index];
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 243, 208, 131),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 0.65,
                                    color: Colors.black,
                                  ),
                                ),
                                child: ListTile(
                                  leading: FutureBuilder(
                                    future: getUserImg(currentEmail),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text(
                                          'Error: ${snapshot.error}',
                                          style: _getTextStyle2(),
                                        );
                                      } else {
                                        final imageUrl = snapshot.data;
                                        return CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(imageUrl!),
                                          radius: 20,
                                        );
                                      }
                                    },
                                  ),
                                  title: FutureBuilder(
                                    future: getUsername(currentEmail),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text(
                                          'Error: ${snapshot.error}',
                                          style: _getTextStyle2(),
                                        );
                                      } else {
                                        final username = snapshot.data;
                                        return Text(
                                          username!,
                                          style: _getTextStyle1(),
                                        );
                                      }
                                    },
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      currentEmail,
                                      style: _getTextStyle2(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text("No students found"),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> getUserImg(String email) async {
    String imgpath = 'Student/$email/profile/$email.jpg';

    try {
      String userDpUrl =
          await FirebaseStorage.instance.ref().child(imgpath).getDownloadURL();
      return userDpUrl;
    } catch (e) {
      print('Error loading profile image: $e');
      return null;
    }
  }
}

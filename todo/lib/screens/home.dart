import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:async/async.dart';
import 'package:todo/screens/update_todo.dart';

final email = FirebaseAuth.instance.currentUser!.email;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  // ignore: non_constant_identifier_names
  void update_Todo(Map<String, dynamic> task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Update_Todo(task: task),
    );
  }

  Stream<QuerySnapshot> getTasksStream(String useremail) {
    DateTime currentDateTime = DateTime.now();

    Stream<QuerySnapshot> pendingTasksStream = FirebaseFirestore.instance
        .collection("Tasks")
        .doc(useremail)
        .collection("`Pending%20Tasks`")
        .where('due', isGreaterThanOrEqualTo: currentDateTime)
        .snapshots();

    Stream<QuerySnapshot> completedTasksStream = FirebaseFirestore.instance
        .collection("Tasks")
        .doc(useremail)
        .collection("`Pending%20Tasks`")
        .where('isComp', isEqualTo: false)
        .snapshots();

    return StreamGroup.merge([pendingTasksStream, completedTasksStream]);
  }

  Future<String?> fetchusernames(String eemail) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('UserInfo')
          .doc(eemail)
          .get();
      final userName = snapshot['username'] as String?;
      return userName;
    } catch (e) {
      print('Error fetching username: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String?>(
              future: fetchusernames(email!),
              builder: (context, profileUserName) {
                if (profileUserName.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (profileUserName.hasError) {
                  return Text(
                      'Error fetching profile username: ${profileUserName.error}');
                } else if (profileUserName.hasData) {
                  final username = profileUserName.data;
                  if (username != null) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Hello, $username",
                        style: namestyle1(),
                      ),
                    );
                  } else {
                    return const Text('No profile username available');
                  }
                } else {
                  return const Text('No profile username available');
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: getTasksStream(email!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error : ${snapshot.error}"),
                  );
                } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Center(
                      child: SizedBox(
                    height: 500,
                    width: 500,
                    child: Lottie.asset('lib/animations/todo2.json'),
                  ));
                } else {
                  List<Map<String, dynamic>> tasksList = snapshot.data!.docs
                      .map((doc) => doc.data() as Map<String, dynamic>)
                      .toList();
    
                  var lengt = tasksList.length;
    
                  return Expanded(
                    child: ListView.builder(
                      itemCount: lengt,
                      itemBuilder: (context, index) {
                        var task = tasksList[index];
    
                        var favStatus = task['isFav'];
                        var compStatus = task['isComp'];
    
                        Timestamp dueTimestamp = task['due'];
                        Timestamp creationTimestamp = task['due'];
    
    
                        DateTime dueDate = dueTimestamp.toDate();
                        DateTime creationDate = creationTimestamp.toDate();
    
                        String formattedDueDate =
                            DateFormat('dd MMM yyyy').format(dueDate);
                        String formattedCreationDate =
                            DateFormat('dd MMM yyyy').format(creationDate);
    
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 0.35, color: Colors.black),
                            ),
                            child: Dismissible(
                              key: Key(snapshot.data!.docs[index].id),
                              direction: DismissDirection.startToEnd,
                              background: Container(
                                color: Theme.of(context).colorScheme.error,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(left: 16.0),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(right: 16.0),
                                        child: Text(
                                          'Remove task',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ],
                                ),
                              ),
                              onDismissed: (direction) async {
                                await FirebaseFirestore.instance
                                    .collection('Tasks')
                                    .doc(email)
                                    .collection("`Pending%20Tasks`")
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              },
                              child: ListTile(
                                onTap: () => update_Todo(task),
                                leading: IconButton(
                                  onPressed: () async {
                                    compStatus = !compStatus;
    
                                    await FirebaseFirestore.instance
                                        .collection('Tasks')
                                        .doc(email)
                                        .collection("`Pending%20Tasks`")
                                        .doc(snapshot.data!.docs[index].id)
                                        .update({"isComp": compStatus});
                                  },
                                  icon: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    child: compStatus
                                        ? const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 30,
                                          )
                                        : const Icon(
                                            Icons.circle_outlined,
                                            size: 30,
                                          ),
                                  ),
                                ),
                                title: Text(task['title']),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(task['description']),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(formattedDueDate),
                                    ],
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: favStatus
                                      ? const Icon(
                                          Icons.star,
                                          size: 30,
                                          color: Colors.black,
                                        )
                                      : const Icon(
                                          Icons.star_border_outlined,
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                  onPressed: () async {
                                    favStatus = !favStatus;
    
                                    await FirebaseFirestore.instance
                                        .collection('Tasks')
                                        .doc(email)
                                        .collection("`Pending%20Tasks`")
                                        .doc(snapshot.data!.docs[index].id)
                                        .update({"isFav": favStatus});
                                  },
                                ),
                              ),
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
    );
  }
}

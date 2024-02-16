import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_crud/MongoDBModel..dart';
import 'package:mongo_crud/dbhelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({super.key});

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
            child: Column(
          children: [
            const Text(
              'Insert Data',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: fnameController,
              decoration: const InputDecoration(labelText: "First Name"),
            ),
            TextField(
              controller: lnameController,
              decoration: const InputDecoration(labelText: "Last Name"),
            ),
            TextField(
              minLines: 3,
              maxLines: 5,
              controller: addressController,
              decoration: const InputDecoration(labelText: "Address"),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                OutlinedButton(
                    onPressed: () {
                      fakeData();
                    },
                    child: const Text('Generate Data')),
                ElevatedButton(
                    onPressed: () {
                      insertData(fnameController.text, lnameController.text,
                          addressController.text);
                    },
                    child: const Text('Insert Data'))
              ],
            )
          ],
        )),
      ),
    );
  }

  Future<void> insertData(String fname, String lname, String address) async {
    var id = M.ObjectId();
    final data = MongoDbModel(
        id: id, firstName: fname, lastName: lname, address: address);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Inserted ID " + id.$oid)));
    _clearAll();
  }

  void _clearAll() {
    setState(() {
      fnameController.text = '';
      lnameController.text = '';
      addressController.text = '';
    });
  }

  void fakeData() {
    setState(() {
      fnameController.text = faker.person.firstName();
      lnameController.text = faker.person.lastName();
      addressController.text =
          faker.address.streetName() + "\n" + faker.address.streetAddress();
    });
  }
}

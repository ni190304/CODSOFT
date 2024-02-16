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

  var checkinsertupdate = "Insert";

  @override
  Widget build(BuildContext context) {
    MongoDbModel data =
        ModalRoute.of(context)!.settings.arguments as MongoDbModel;

    if (data != null) {
      fnameController.text = data.firstName;
      lnameController.text = data.lastName;
      addressController.text = data.address;
      checkinsertupdate = "Update";
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
            child: Column(
          children: [
            Text(
              checkinsertupdate,
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
                      if (checkinsertupdate == 'Update') {
                        _updateData(data.id, fnameController.text,
                            lnameController.text, addressController.text);
                      } else {
                        _insertData(fnameController.text, lnameController.text,
                            addressController.text);
                      }
                    },
                    child: Text(checkinsertupdate))
              ],
            )
          ],
        )),
      ),
    );
  }

  Future<void> _updateData(
      var id, String fName, String lName, String address) async {
        // print(object)
    final updateData = MongoDbModel(
        id: id, firstName: fName, lastName: lName, address: address);
    await MongoDatabase.updateData(updateData)
        .whenComplete(() => Navigator.pop(context));
  }

  Future<void> _insertData(String fname, String lname, String address) async {
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

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mongo_crud/MongoDBModel..dart';
import 'package:mongo_crud/dbhelper/mongodb.dart';
import 'package:mongo_crud/insert.dart';

class MongoDbUpdate extends StatefulWidget {
  const MongoDbUpdate({Key? key}) : super(key: key);

  @override
  State<MongoDbUpdate> createState() => _MongoDbUpdateState();
}

class _MongoDbUpdateState extends State<MongoDbUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: MongoDatabase.getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: const CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return displayCard(
                        MongoDbModel.fromJson(snapshot.data[index]));
                  });
            } else {
              return Center(
                child: Text("No data found"),
              );
            }
          }
        },
      )),
    );
  }

  Widget displayCard(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text("${data.id}"),
                const SizedBox(
                  height: 5,
                ),
                Text(data.firstName),
                const SizedBox(
                  height: 5,
                ),
                Text(data.lastName),
                const SizedBox(
                  height: 5,
                ),
                Text(data.address),
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return MongoDbInsert();
                          },
                          settings: RouteSettings(arguments: data)));
                },
                icon: const Icon(Icons.edit))
          ],
        ),
      ),
    );
  }
}

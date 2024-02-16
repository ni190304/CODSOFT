import 'package:flutter/material.dart';
import 'package:mongo_crud/dbhelper/mongodb.dart';

import 'MongoDBModel..dart';

class MongoDbDisplay extends StatefulWidget {
  const MongoDbDisplay({Key? key}) : super(key: key);

  @override
  State<MongoDbDisplay> createState() => _MongoDbDisplayState();
}

class _MongoDbDisplayState extends State<MongoDbDisplay> {
  late Future<Stream<List<Map<String, dynamic>>>> dataStreamFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the data stream future
    dataStreamFuture = MongoDatabase.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Stream<List<Map<String, dynamic>>>>(
          future: dataStreamFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              final dataStream = snapshot.data;
              if (dataStream != null) {
                return StreamBuilder<List<Map<String, dynamic>>>(
                  stream: dataStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    } else {
                      final data = snapshot.data;
                      if (data != null && data.isNotEmpty) {
                        var totalData = data.length;
                        print("Total data: ${totalData.toString()}");
                        return ListView.builder(
                          itemCount: totalData,
                          itemBuilder: (context, index) {
                            final item = data[index];
                            final model = MongoDbModel.fromJson(item);
                            return displayCard(model);
                          },
                        );
                      } else {
                        return Center(
                          child: Text("No data available"),
                        );
                      }
                    }
                  },
                );
              } else {
                return Center(
                  child: Text("No data stream available"),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget displayCard(MongoDbModel data) {
    return Card(
      child: Column(
        children: [
          Text("${data.id}"),
          const SizedBox(height: 5,),
          Text(data.firstName),
          const SizedBox(height: 5,),
          Text(data.lastName),
          const SizedBox(height: 5,),
          Text(data.address),
        ],
      ),
    );
  }
}

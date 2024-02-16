import 'dart:developer';
import 'package:mongo_crud/MongoDBModel..dart';
import 'package:mongo_crud/dbhelper/constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future<void> updateData(MongoDbModel data)async{
    var result = await userCollection.findOne({"_id": data.id});
    result['firstName'] = data.firstName;
    result['lastName'] = data.lastName;
    result['address'] = data.address;
    await userCollection.save(result);

  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data inserted";
      } else {
        return "Something wrong";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}

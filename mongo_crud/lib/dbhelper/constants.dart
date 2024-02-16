import 'dart:convert';

const password = 'Nihaal@2004';
final encodedPassword = Uri.encodeComponent(password);
const username = 'nayak1934';
const host = 'flutteruniversity.pkzj4ab.mongodb.net';
const database = 'university';

// ignore: non_constant_identifier_names
final MONGO_CONN_URL = 'mongodb+srv://$username:$encodedPassword@$host/$database?retryWrites=true&w=majority';
// ignore: constant_identifier_names
const USER_COLLECTION = 'agent';

import 'package:firebase_database/firebase_database.dart';

class QueryResult {
  int length;
  DataSnapshot data;
  QueryResult({
    required this.length,
    required this.data,
  });
}

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: unnecessary_overrides
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:ma5terabsensi/app/data/database_type.dart';

class DatabaseController extends GetxController {
  final mDatabase = FirebaseDatabase.instance;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<QueryResult?> Get(String ref) async {
    try {
      // mDatabase.ref(ref).update(value)
      DataSnapshot query = await mDatabase.ref(ref).get();
      return QueryResult(length: query.exists ? query.children.length : 0, data: query);
    } catch (e) {
      return null;
    }
  }

  Future<bool> Update(String ref, Map<String, Object?> value) async {
    try {
      await mDatabase.ref(ref).update(value);
      return true;
    } catch (e) {
      return false;
    }

  }
}

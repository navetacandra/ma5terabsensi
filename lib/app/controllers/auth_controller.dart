// ignore_for_file: unnecessary_overrides
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ma5terabsensi/app/controllers/database_controller.dart';
import 'package:ma5terabsensi/app/data/database_type.dart';
import 'package:ma5terabsensi/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final mAuth = FirebaseAuth.instance;
  final mDb = Get.put<DatabaseController>(DatabaseController());

  Stream<User?> get streamCredential => mAuth.authStateChanges();

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

  Future<UserCredential?> signUp(
      String email, String password, String? name) async {
    try {
      UserCredential user = await mAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ignore: unnecessary_null_comparison
      if (user != null) {
        await mAuth.currentUser?.updateDisplayName(name);
        setUserDefaultData(
          uid: user.user!.uid,
          email: email,
          name: name ?? "",
        );
        Get.offAllNamed(Routes.HOME);
        return user;
      } else {
        showErrorSnackBar(message: "Pendaftaran Gagal!");
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        showErrorSnackBar(message: "Email Sudah Terdaftar!");
      }
      if (e.code == "too-many-requests") {
        showErrorSnackBar(message: "Terjadi Kesalahan, Coba Lagi Nanti!");
      }
      return null;
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final user = await mAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // ignore: unnecessary_null_comparison
      if (user != null) {
        setUserDefaultData(
          uid: user.user!.uid,
          email: email,
          name: mAuth.currentUser?.displayName ?? "",
        );
        Get.offAllNamed(Routes.HOME);
        return user;
      } else {
        showErrorSnackBar(message: "Login Gagal!");
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        showErrorSnackBar(message: "Email Belum Terdaftar!");
      }
      if (e.code == "wrong-password") {
        showErrorSnackBar(message: "Password Salah!");
      }
      if (e.code == "too-many-requests") {
        showErrorSnackBar(message: "Terjadi Kesalahan, Coba Lagi Nanti!");
      }
      return null;
    }
  }

  void signOut() async {
    await mAuth.signOut();
    await Get.offAllNamed(Routes.LOGIN);
  }

  void setUserDefaultData({
    required String uid,
    required String email,
    required String name,
  }) async {
    QueryResult? dataQuery = await mDb.Get("users/$uid");
    if (dataQuery == null) {
      showErrorSnackBar(message: "Terjadi Kesalahan Sistem.");
    } else {
      if (dataQuery.length == 0) {
        mDb.Update("users/$uid", {
          "uid": uid,
          "email": email,
          "name": name,
          "role": 3,
        });
      }
    }
  }

  SnackbarController showErrorSnackBar({required String message}) {
    return Get.showSnackbar(
      GetSnackBar(
        backgroundColor: const Color.fromRGBO(255, 0, 0, .8),
        duration: const Duration(milliseconds: 1500),
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        messageText: Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: Get.width * .05,
            fontWeight: FontWeight.w400,
          ),
        ),
        borderRadius: Get.width * .025,
      ),
    );
  }
}

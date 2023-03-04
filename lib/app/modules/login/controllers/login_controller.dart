// ignore_for_file: unnecessary_overrides
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ma5terabsensi/app/controllers/auth_controller.dart';

class LoginController extends GetxController {
  final authC = Get.put<AuthController>(AuthController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RegExp mailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

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

  void login() async {
    String emailText = emailController.text;
    String passwordText = passwordController.text;
    bool emailChecked = false;
    bool passwordChecked = false;

    if (!emailChecked && emailText.isEmpty) {
      showErrorSnackBar(message: "Email Wajib Di-isi!");
      emailChecked = true;
    }
    if (!emailChecked &&
        emailText.isNotEmpty &&
        !mailRegex.hasMatch(emailText)) {
      showErrorSnackBar(message: "Email Tidak Valid!");
      emailChecked = true;
    }
    if (!emailChecked &&
        emailText.isNotEmpty &&
        mailRegex.hasMatch(emailText) &&
        emailText.split("@")[1] != "gmail.com") {
      showErrorSnackBar(message: "Alamat Email Wajib gmail.com!");
      emailChecked = true;
    }

    if (!passwordChecked && passwordText.isEmpty) {
      showErrorSnackBar(message: "Password Wajib Di-isi!");
      passwordChecked = true;
    }
    if (!passwordChecked &&
        passwordText.isNotEmpty &&
        passwordText.length < 8) {
      showErrorSnackBar(message: "Password Minimal Berisi 8 Karakter!");
      passwordChecked = true;
    }

    if (emailText.isNotEmpty &&
        mailRegex.hasMatch(emailText) &&
        emailText.split("@")[1] == "gmail.com" &&
        passwordText.isNotEmpty &&
        passwordText.length >= 8) {
      await authC.signIn(emailText, passwordText);
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

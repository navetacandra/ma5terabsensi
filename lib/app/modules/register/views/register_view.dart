import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ma5terabsensi/app/controllers/auth_controller.dart';
import 'package:ma5terabsensi/app/routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);
  final authC = Get.put<AuthController>(AuthController());
  final selfC = Get.put<RegisterController>(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            width: Get.width,
            height: Get.height,
            child: Center(
              child: Card(
                elevation: 8,
                child: SizedBox(
                  width: Get.width - Get.width * .125,
                  height: Get.height - Get.height * .07,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: Get.width * .05,
                      ),
                      Image.asset(
                        "assets/img/avicena-icon.png",
                        width: Get.width - Get.width * .6,
                        height: Get.width - Get.width * .6,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: Get.width * .05,
                          bottom: Get.width * .1,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "REGISTER",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: Get.width * .075,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      inputText(
                        labelText: "Nama",
                        placeholder: "Masukan Nama",
                        inputType: TextInputType.text,
                        controller: selfC.nameController,
                      ),
                      inputText(
                        labelText: "Email",
                        placeholder: "Masukan Email",
                        inputType: TextInputType.emailAddress,
                        controller: selfC.emailController,
                      ),
                      inputText(
                        labelText: "Password",
                        placeholder: "Masukan Password",
                        inputType: TextInputType.text,
                        secure: true,
                        controller: selfC.passwordController,
                      ),
                      SizedBox(
                        height: Get.height * .025,
                      ),
                      GestureDetector(
                        child: Text(
                          "Sudah ada akun? Masuk disini.",
                          style: GoogleFonts.roboto(
                            color: const Color.fromRGBO(48, 7, 228, 1),
                          ),
                        ),
                        onTap: () => Get.offAllNamed(Routes.LOGIN),
                      ),
                      SizedBox(
                        height: Get.height * .025,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: Get.width * .1,
                        ),
                        child: ElevatedButton(
                          onPressed: () => selfC.register(),
                          child: Center(
                            child: Text(
                              "REGISTER",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: Get.width * .05,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column inputText({
    required String labelText,
    String placeholder = "",
    bool secure = false,
    int maxLines = 1,
    TextInputType inputType = TextInputType.text,
    TextEditingController? controller,
  }) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: Get.width * .04,
            vertical: Get.height * .015,
          ),
          width: Get.width,
          height: Get.width * .05,
          child: Text(
            labelText,
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: Get.width * .05,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: Get.width * .05,
            vertical: Get.height * .0125,
          ),
          width: Get.width,
          height: Get.width * .125,
          child: TextField(
            controller: controller,
            obscureText: secure,
            cursorColor: Colors.black,
            keyboardType: inputType,
            autocorrect: false,
            maxLines: maxLines,
            textAlignVertical: TextAlignVertical.top,
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: Get.width * .05,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: Get.width * .04),
              hintText: placeholder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Get.width * .1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ma5terabsensi/app/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final authC = Get.put<AuthController>(AuthController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: Future.delayed(const Duration(seconds: 5)),
      future: Future.delayed(Duration.zero),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<User?>(
            stream: authC.streamCredential,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "Ma5ter Absensi",
                  initialRoute:
                      snapshot.data != null ? Routes.HOME : Routes.REGISTER,
                  getPages: AppPages.routes,
                );
              }
              return Container();
            },
          );
        } else {
          return MaterialApp(
            title: "Ma5ter Absensi",
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Stack(
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      "assets/img/splash-icon.png",
                      height: Get.width * .75,
                      width: Get.width * .75,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: Get.height * .025,
                      ),
                      child: Text(
                        "DOA TEAMS",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: Get.width * .07,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

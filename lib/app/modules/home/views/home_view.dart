import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ma5terabsensi/app/controllers/auth_controller.dart';
import 'package:ma5terabsensi/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final authC = Get.put<AuthController>(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: Get.height / 2.5,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(Get.width * .075),
                    bottomLeft: Radius.circular(Get.width * .075),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * .05,
                  vertical: Get.width * .025,
                ),
                width: Get.width,
                height: 50,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Hai, ",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: Get.width * .065,
                      ),
                    ),
                    StreamBuilder(
                      stream: authC.streamCredential,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.data != null) {
                            return SizedBox(
                              width: Get.width / 2.5,
                              child: Text(
                                snapshot.data?.displayName ?? "...",
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                maxLines: 1,
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: Get.width * .065,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }
                          return Text(
                            "...",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: Get.width * .065,
                            ),
                          );
                        }
                        return Text(
                          "...",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: Get.width * .065,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: (Get.height / 2.25) - (Get.height / 2.5),
                left: (Get.width - (Get.width - Get.width * .1)) / 2,
                child: Card(
                  color: Colors.white,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Get.width * .05),
                  ),
                  child: SizedBox(
                    width: Get.width - Get.width * .1,
                    height: Get.width / 2.75,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.height / 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              menuItem(
                navigate: Routes.LOGIN,
                img: "assets/img/calendar.png",
                text: "Schedule",
              ),
              menuItem(
                navigate: Routes.LOGIN,
                img: "assets/img/calendar.png",
                text: "Schedule",
              ),
              menuItem(
                navigate: Routes.LOGIN,
                img: "assets/img/calendar.png",
                text: "Schedule",
              ),
              menuItem(
                navigate: Routes.LOGIN,
                img: "assets/img/calendar.png",
                text: "Schedule cerita",
              ),
            ],
          ),
          SizedBox(
            height: Get.height / 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              menuItem(
                navigate: Routes.LOGIN,
                img: "assets/img/calendar.png",
                text: "Schedule",
              ),
              menuItem(
                navigate: Routes.LOGIN,
                img: "assets/img/calendar.png",
                text: "Schedule",
              ),
              menuItem(
                navigate: Routes.LOGIN,
                img: "assets/img/calendar.png",
                text: "Schedule",
              ),
              menuItem(
                navigate: Routes.LOGIN,
                img: "assets/img/calendar.png",
                text: "Schedule cerita",
              ),
            ],
          ),
          SizedBox(
            height: Get.height / 15,
          ),
          ElevatedButton(
            onPressed: () => authC.signOut(),
            child: const Text("Log Out"),
          ),
        ],
      ),
    );
  }

  GestureDetector menuItem({
    required String navigate,
    required String img,
    required String text,
  }) {
    return GestureDetector(
      onTap: () => Get.toNamed(navigate),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            img,
            width: Get.width / 6.5,
            height: Get.width / 6.5,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: Get.width / 4,
            child: Text(
              text,
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontSize: Get.width * .05,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Login.dart';

class StartPage extends StatelessWidget {
  StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final Width = MediaQuery.of(context).size.width;

    // Delayed navigation to the login page after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(Login());
    });
    
    return Scaffold(
        // backgroundColor: Colors.lightBlue,
        body: SingleChildScrollView(
      child: Container(
          height: Height,
          width: Width,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.task_rounded,
                size: 100,
                color: HexColor("#30a6d6"),
              ),
              const SizedBox(height: 20,),
              Text(
                'Welcome to the',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: HexColor('#4d4d4d')),
              ),
              // const SizedBox(height: 20,),
              Text(
                'OfficeAPP',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                    color: HexColor('#4d4d4d')),
              )
            ],
          )),
    ));
  }
}

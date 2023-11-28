import 'package:agile_tech/utils/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashController(),
      builder: (_) {
        return const Scaffold(
          backgroundColor: Color(0xFFFF5454),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 90),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Agile',
                        style: TextStyle(
                          fontFamily: FontFamilyToken.montserrat,
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Tech',
                        style: TextStyle(
                          fontFamily: FontFamilyToken.montserrat,
                          fontSize: 35,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF670F0F),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  LinearProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Color(0xFF670F0F),
                  )
                ],
              )
            ),
          ),
        );
      }
    );
  }
}
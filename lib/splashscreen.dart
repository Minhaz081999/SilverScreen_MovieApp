import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import 'home_screen.dart';
import 'main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset('assets/moviesplashscreen.json'),

      splashIconSize: 250,
      backgroundColor: Colors.black,
      pageTransitionType: PageTransitionType.rightToLeftWithFade,
      nextScreen: HomeScreen(),

      
    );
  }
}
//assets/moviesplashscreen.json  https://assets7.lottiefiles.com/packages/lf20_khzniaya.json
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:harvest_driver/splash_screen.dart';
import 'package:harvest_driver/widgets/animated_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/colors.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language') == null) {
      prefs.setString('language', 'en');
    }
    var _duration = new Duration(seconds: 2);
    return Timer(_duration, setLandingPage);
  }

  setLandingPage() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String token = prefs.getString('userToken');

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SplashScreen(),
        ));
  }

  @override
  void initState() {
    // ApiServices().getSettings();
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CColors.lightOrange,
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: AnimatedSplash(),
          ),
        ),
      ),
    );
  }
}

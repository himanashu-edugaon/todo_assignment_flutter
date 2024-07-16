import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignments/views/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
  Timer(Duration(seconds: 3),() {
    Get.offAll(()=>HomeScreen());
  },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f3f3),
      body: Center(
        child: Hero(
          tag: "app_logo",
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 100,
            child: Icon(
              Icons.task,
              color: Colors.blueAccent,
              size: 150,
            ),
          ),
        ),
      ),
    );
  }
}

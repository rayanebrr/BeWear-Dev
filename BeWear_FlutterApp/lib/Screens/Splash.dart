import 'dart:async';

import 'package:clothewardrobe/Screens/Login.dart';
import 'package:clothewardrobe/Screens/Profile.dart';
import 'package:clothewardrobe/Screens/Swipe.dart';
import 'package:clothewardrobe/Screens/WardrobeSelector.dart';
import 'package:flutter/material.dart';

import 'AI.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
      =>
      Login(),
      ));
    });
  }


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ClotheWardrobe',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffD0D0DF),
        body: Center(
          child: Image(
            image: AssetImage("images/logo.png"),
            height: 251,
            width: 412,
          ),
        ),
      ),
    );
  }
}

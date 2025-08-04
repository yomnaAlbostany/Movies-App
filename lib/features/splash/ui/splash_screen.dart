import 'package:flutter/material.dart';
import 'package:movies_app/core/router/routes.dart';
import 'package:movies_app/core/style/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 6)).then((value){
      Navigator.pushNamedAndRemoveUntil(context,Routes.onBording,(_)=>false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(child: Image.asset('assets/images/splash.png')),
    );
  }
}

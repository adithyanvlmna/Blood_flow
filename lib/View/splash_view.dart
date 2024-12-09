import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blood_donation_app/View/home_view.dart';
import 'package:blood_donation_app/View/login_view.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String? keyy;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKey().then((key) {
      setState(() {
        keyy = key;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset("assets/images/blood_icon.png"),
      nextScreen:keyy!=null? const HomeView():const LoginView(),
      duration: 4000, backgroundColor: Colors.white,
      pageTransitionType: PageTransitionType.fade,
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 200,
    );
  }
}

Future<String?> getKey() async {
  final pref = await SharedPreferences.getInstance();
  String? key = pref.getString("Phone");
  return key;
}

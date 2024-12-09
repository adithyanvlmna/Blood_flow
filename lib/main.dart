import 'package:blood_donation_app/Utilities/routes.dart';
import 'package:blood_donation_app/View/home_view.dart';
import 'package:blood_donation_app/View/login_view.dart';
import 'package:blood_donation_app/View/sign_up_view.dart';
import 'package:blood_donation_app/View/splash_view.dart';
import 'package:blood_donation_app/ViewModel/donor_provider.dart';
import 'package:blood_donation_app/ViewModel/logined_user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (contex) => DonorProvider()),
    ChangeNotifierProvider(create: (context) => LoginedUserProvider()),
  ], child: const Root()));
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashview,
      routes: {
        Routes.splashview: (context) => const SplashView(),
        Routes.homeview: (context) => const HomeView(),
        Routes.loginview: (context) => const LoginView(),
        Routes.signupview: (context) => const SignUpView(),
      },
    );
  }
}

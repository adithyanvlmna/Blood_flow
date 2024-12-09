import 'package:blood_donation_app/Utilities/Enums/login_enum.dart';
import 'package:blood_donation_app/Utilities/Enums/signup_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  static Future<SignupEnum> signupError(
      String emailAddress, String password) async {
    SignupEnum error = SignupEnum.noEroor;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print(e.code);
        error = SignupEnum.weakPassword;
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print(e.code);
        error = SignupEnum.alreadyInUse;
        print('The account already exists for that email.');
      }
    } catch (e) {
      error = SignupEnum.other;
      print(e);
    }
    return error;
  }

  static Future<LoginEnum> loginError(
      String emailAddress, String password) async {
    LoginEnum error = LoginEnum.noError;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(".............................");
      if (e.code == 'invalid-credential') {
        error = LoginEnum.userNotFound;
        print('No user found for that email.');
      } 
    }
    return error;
  }
}

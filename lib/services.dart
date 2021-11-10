import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
// import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:todoey_flutter/modals/UserModel.dart';

class Auth with ChangeNotifier {
  bool _isSignedIn = false;
  UserModel? userModel;
  Future<bool> signIn(String email, String password) async {
    try {
      final res = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );

      _isSignedIn = res.isSignedIn;
      if (_isSignedIn) {
        userModel = UserModel(email: email, password: password);
        notifyListeners();
        print("SignedIn successfully");
        return true;
      } else {
        print('Not signed in');
        return false;
      }
    } on AuthException catch (e) {
      if (e.message.contains('already a user which is signed in')) {
        await Amplify.Auth.signOut();
        print('Problem logging in. Please try again.');
        return false;
      }
      print('${e.message} - ${e.recoverySuggestion}');
      return false;
    }
  }

  // Future<String> _onRecoverPassword(BuildContext context, String email) async {
  //   try {
  //     final res = await Amplify.Auth.resetPassword(username: email);
  //
  //     if (res.nextStep.updateStep == 'CONFIRM_RESET_PASSWORD_WITH_CODE') {
  //       Navigator.of(context).pushReplacementNamed(
  //         '/confirm-reset',
  //         arguments: LoginData(name: email, password: ''),
  //       );
  //     }
  //   } on AuthException catch (e) {
  //     return '${e.message} - ${e.recoverySuggestion}';
  //   }
  // }

  Future<bool> signup(String email, String password) async {
    try {
      await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(userAttributes: {
          'email': email,
        }),
      );
      notifyListeners();
      print('Signed up successfully check your email');
      return true;
    } on AuthException catch (e) {
      print('${e.message} - ${e.recoverySuggestion}');
      print('Failed to sign up');
      return false;
    }
  }

  Future<bool> confirmSignUp(String email, String otp) async {
    try {
      await Amplify.Auth.confirmSignUp(username: email, confirmationCode: otp);
      return true;
    } on Exception {
      print('Something Wrong');
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await Amplify.Auth.signOut();
      print('user signed out successfully');
      return true;
    } on AmplifyException catch (e) {
      print(e.message);
      return false;
    }
  }
}

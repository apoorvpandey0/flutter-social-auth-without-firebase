import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_user_auth_without_firebase/google.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  void googleSignIn() async {
    print("gauth: start");
    final user = await GoogleSignInApi.login();
    print("gauth: $user");
    await user!.authentication.then((googleKey) {
      print("gauth: ${googleKey.accessToken}");
      print("gauth: ${googleKey.idToken}");
    });
  }

  void facebookSignIn() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      print("fauth:$accessToken");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlutterLogo(
            size: 250,
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: googleSignIn,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Google sign In",
                  style: TextStyle(fontSize: 30),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: facebookSignIn,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Facebook sign In",
                  style: TextStyle(fontSize: 30),
                ),
              ))
        ],
      ),
    )));
  }
}

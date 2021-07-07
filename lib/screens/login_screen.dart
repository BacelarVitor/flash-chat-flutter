import 'package:flash_chat/components/RoudedButton.dart';
import 'package:flash_chat/components/inputField.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: kTagLogo,
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            InputField(
              onChanged: (value) => email = value,
              hintText: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 8.0,
            ),
            InputField(
              onChanged: (value) => password = value,
              hintText: 'Enter your password',
              obscureText: true,
            ),
            SizedBox(
              height: 24.0,
            ),
            Hero(
              tag: kTagLoginBtn,
              child: RoundedButton(
                label: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

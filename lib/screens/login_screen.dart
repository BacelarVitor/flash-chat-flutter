import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/RoudedButton.dart';
import 'package:flash_chat/components/inputField.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool _showSpinner = false;

  void changeShowSpinner() {
    setState(() {
      _showSpinner = !_showSpinner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
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
                  onPressed: () async {
                    changeShowSpinner();

                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(email);
                    bool passwordValid =
                        password != null || password.length >= 8;
                    if (emailValid && passwordValid) {
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        print(user);
                        if (user != null) {
                          email = null;
                          password = null;
                          changeShowSpinner();
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                      } catch (e) {
                        changeShowSpinner();
                        print(e);
                      }

                      changeShowSpinner();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/components/RoudedButton.dart';
import 'package:flash_chat/components/inputField.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                tag: kTagRegisterBtn,
                child: RoundedButton(
                  label: 'Register',
                  color: Colors.blueAccent,
                  onPressed: () async {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(email);
                    bool passwordValid =
                        password != null || password.length >= 8;
                    if (emailValid && passwordValid) {
                      changeShowSpinner();
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          password = null;
                          email = null;
                          changeShowSpinner();
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                      } catch (e) {
                        changeShowSpinner();
                        print(e);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        inAsyncCall: _showSpinner,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_new_mytube_app/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_new_mytube_app/tabBarControll/tabBarControll.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ログイン',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amberAccent,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if (input.isEmpty) {
                  return 'Emailを入力してください';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              validator: (input) {
                if (input.length < 6) {
                  return 'パスワードを入力してください';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: 'password',
              ),
              obscureText: true,
            ),
            RaisedButton(
              child: Text('ログイン！'),
              onPressed: signIn,
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //TODO login to firebase
      try {
        await Firebase.initializeApp();
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TabBarControll()));
      } catch (error) {
        print(error.message);
      }
    }
  }
}

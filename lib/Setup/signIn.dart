import 'dart:ffi';

import 'package:fire/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      // App bar
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      // body
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: ( input ){
                if(input.isEmpty){
                  return 'Please type an email';
                }
              },
              onSaved: ( input ) => _email = input,
              decoration: InputDecoration(
                labelText: 'Email'
              ),
            ),
            TextFormField(
              validator: ( input ){
                if(input.length < 6){
                  return 'Your password needs to be atleast 6 characters';
                }
              },
              onSaved: ( input ) => _password = input,
              decoration: InputDecoration(
                labelText: 'Password'
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: signIn,
              child: Text('Sign in'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async{
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user,)));
      }catch(e){
        print(e.message);
      }
      
    }

  }
}
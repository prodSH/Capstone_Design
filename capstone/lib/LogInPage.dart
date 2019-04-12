import 'package:flutter/material.dart';
import 'package:capstone/bloc_codes/BlocProvider.dart';
import 'package:capstone/fire_base_codes/FireAuth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LogIn')),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
                child: Text('Sign In with Google'),
                onPressed: (){
                  FireAuthProvider().authenticate() ;
                }
            ),
            RaisedButton(
                child: Text('Sign out with Google'),
                onPressed: (){
                  FireAuthProvider().signOut() ;
                }
            )
          ],
        )
      )
    ) ;
  }
}
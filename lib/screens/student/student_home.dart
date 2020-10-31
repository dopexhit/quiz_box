import 'package:flutter/material.dart';
import 'package:quiz_box/services/auth.dart';
import '../login_signup.dart';

class StudentHome extends StatefulWidget {
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    print(uid);
    return Scaffold(
      body: FlatButton(
          color: Colors.orange,
          onPressed: (){
            AuthService().signOutGoogle().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){return LoginSignup();})));}),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:quiz_box/model/custom_user.dart';
import 'package:quiz_box/screens/login_signup.dart';
import 'package:quiz_box/screens/student/student_home.dart';
import 'package:quiz_box/screens/teacher/choose_teacher_subject.dart';
import 'package:quiz_box/services/shared_pref.dart';
import 'auth.dart';
import 'package:quiz_box/screens/teacher/teacher_home.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    //if signed in then home else Login Signup
    print(user.toString());
    if(user == null) return LoginSignup();
    else {
      uid = user.uid;
      getState(context);
      return Container();
    }
  }
}

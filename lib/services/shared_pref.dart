import 'package:flutter/material.dart';
import 'package:quiz_box/screens/student/student_home.dart';
import 'package:quiz_box/screens/teacher/teacher_bottom_navi.dart';
import 'package:quiz_box/screens/teacher/teacher_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

//class SharedPref{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    makeTeacher() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('is teacher', 1);
    }
    makeStudent() async {
      final SharedPreferences prefs = await _prefs;
      prefs.setInt('is teacher', 0);
    }
    getState(BuildContext context) async{
      final SharedPreferences prefs = await _prefs;
      int state=prefs.getInt('is teacher');
      if(state==1) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
        return BottomNaviHome();
      }));
      else if(state==0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
        return StudentHome();
      }));
    }
//}
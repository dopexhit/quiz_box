import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quiz_box/screens/teacher/create_quiz.dart';
import 'package:quiz_box/screens/teacher/teacher_home.dart';
import 'package:quiz_box/screens/teacher/teacher_profile.dart';
import 'package:quiz_box/services/auth.dart';

import 'choose_teacher_subject.dart';


class BottomNaviHome extends StatefulWidget {
  @override
  _BottomNaviHomeState createState() => _BottomNaviHomeState();
}

class _BottomNaviHomeState extends State<BottomNaviHome> {


  int pageIndex = 0;
  final TeacherProfile _teacherProfile = TeacherProfile();
  final TeacherQuiz _teacherQuiz = TeacherQuiz();
  final CreateQuiz _createQuiz = CreateQuiz();


  Widget _showPage =  new TeacherProfile();

  Widget _pageChooser(int page)
  {
    switch (page)
    {
      case 0:
        return _teacherProfile;
        break;

      case 1:
        return _teacherQuiz;
        break;

      default:
        return _createQuiz;
        break;

    }
  }

  @override
  void initState() {
    Firestore.instance.collection('Teacher').doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists && quizSubject=='') {
        quizSubject=documentSnapshot.data()['subject'].toString();
        print(quizSubject);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white70,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.decelerate,
        animationDuration: Duration(
          milliseconds: 390,
        ),
        height: 50,
        items: [
          Icon(Icons.person,size: 20,),
          Icon(Icons.home,size: 20,),
          Icon(Icons.add_to_photos,size: 20,),
        ],
        onTap: (index){
          setState(() {
            _showPage = _pageChooser(index);
          });
        },
      ),
      body: Center(
        child: _showPage,
      ),
    );
  }
}
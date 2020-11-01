import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:quiz_box/screens/student/chose_current_quiz.dart';
import 'package:quiz_box/screens/student/student_profile.dart';
import 'package:quiz_box/screens/teacher/choose_teacher_subject.dart';
import 'package:quiz_box/screens/teacher/create_quiz.dart';
import 'package:quiz_box/screens/teacher/teacher_home.dart';
import 'package:quiz_box/screens/teacher/teacher_profile.dart';
import 'package:quiz_box/services/auth.dart';



class StuBottomNaviHome extends StatefulWidget {
  @override
  _StuBottomNaviHomeState createState() => _StuBottomNaviHomeState();
}

class _StuBottomNaviHomeState extends State<StuBottomNaviHome> {


  int pageIndex = 0;
  final StudentProfile _studentProfile = StudentProfile();
  final MinionStu _studentChoice = MinionStu();


  Widget _showPage =  new StudentProfile();

  Widget _pageChooser(int page)
  {
    switch (page)
    {
      case 0:
        return _studentProfile;
        break;

      default:
        return _studentChoice;
        break;

    }
  }

  @override
  void initState() {
    // Firestore.instance.collection('Teacher').doc(uid)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists && quizSubject=='') {
    //     quizSubject=documentSnapshot.data()['subject'].toString();
    //     print(quizSubject);
    //   }
    // });
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
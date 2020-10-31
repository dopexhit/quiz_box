import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_box/animations/fade_animation.dart';
import 'package:quiz_box/screens/student/student_home.dart';
import 'package:quiz_box/screens/teacher/choose_teacher_subject.dart';
import 'package:quiz_box/screens/teacher/teacher_bottom_navi.dart';
import 'package:quiz_box/screens/teacher/teacher_home.dart';
import 'package:quiz_box/services/auth.dart';
import 'package:quiz_box/services/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

String teacher_subject='';
List<dynamic> student_topics=new List();

class LoginSignup extends StatefulWidget {
  @override
  _LoginSignupState createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  @override

  void initState() {

    // FirebaseFirestore.instance
    //     .collection('Teacher')
    //     .doc(uid)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     setState(() {
    //       teacher_subject=documentSnapshot.data()['teacher_subject'].toString();
    //     });
    //   }
    // });
    // FirebaseFirestore.instance
    //     .collection('Student')
    //     .doc(uid)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     setState(() {
    //       student_topics=documentSnapshot.data()['toi'];
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: 300,
            width: 300,
            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: FadeAnimation(1.2,Text(
                'QuizBox',
                style: TextStyle(
                  letterSpacing: 7,
                  fontFamily: 'Montserrat',
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.indigo,
                ),
              ),
            ),
          ),
          SizedBox(
              height: 120,
              width: 500,
              child: Divider(
                color: Colors.black,
              )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 280, 0, 0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FadeAnimation(1.2,Text("I'm using QuizBox...",
                  style: GoogleFonts.montserrat(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    letterSpacing: 2,
                  ),),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 330, 20, 0),
            child: GestureDetector(
              onTap: (){
                makeTeacher();
                AuthService().signInWithGoogle().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                  /*if(teacher_subject!='') return TeacherHome();
                  else*/ return Minion();
                })));
              },
              child: FadeAnimation(1.3,Container(
                margin: EdgeInsets.symmetric(),
                height: 70,
                child: Card(
                  color: Colors.indigo,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: ListTile(
                      title: Text(
                        '   As a Teacher',
                        style: GoogleFonts.montserrat(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      leading:Container(
                        child: ClipRect(
                            child: Image(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/teacher.png'),
                            )
                        ),
                      )
                  ),
                ),
              ),)
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 410, 20, 0),
            child: GestureDetector(
              onTap: (){
                makeStudent();
                AuthService().signInWithGoogle().whenComplete(() =>
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                      return StudentHome();
                    })));
              },
              child: FadeAnimation(1.3,Container(
                height: 70,
                child: Card(
                  color: Colors.orangeAccent,
                  shadowColor: Colors.black,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: ListTile(
                      title: Text(
                        '       As Student',
                        style: GoogleFonts.montserrat(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      leading:Container(
                        height: 50,
                        width: 50,
                        child: ClipRect(
                          child: Image.asset('assets/images/student.png',fit: BoxFit.fill,),
                        ),
                      )
                  ),
                ),
              ),)
            ),
          ),
        ],
      ),
    );
  }
}

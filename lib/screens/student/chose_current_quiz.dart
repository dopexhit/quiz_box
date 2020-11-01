import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:quiz_box/animations/minion_controller.dart';
import 'package:quiz_box/screens/student/student_home.dart';
import 'package:quiz_box/screens/teacher/choose_teacher_subject.dart';
import 'package:quiz_box/screens/teacher/teacher_bottom_navi.dart';
import 'package:quiz_box/services/auth.dart';
import 'package:quiz_box/services/database.dart';
import 'package:quiz_box/shared/constants.dart';

import '../login_signup.dart';

//String stuSubject='';
List<dynamic> dynamic_topic=new List();

class MinionStu extends StatefulWidget {
  @override
  _MinionStuState createState() => _MinionStuState();
}

class _MinionStuState extends State<MinionStu> {
  MinionController minionController;
  bool _isLoading=false;
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('Student')
        .doc(uid+'??')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          dynamic_topic=documentSnapshot.data()['toi'];
        });
      }
    });
    super.initState();
    minionController = MinionController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          'View Quizzes',
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 6,
        actions: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(700.0),
            ),
            color: Colors.grey[300],
            child: PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(700.0),
              ),
              icon: Icon(Icons.list,color: Colors.black45,size: 28,),
              onSelected: choiceAction,
              offset: Offset(0, 100),
              itemBuilder: (BuildContext context){
                return Constants.choices.map((String choice){
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Row(
                      children: [
                        Icon(Icons.call_missed_outgoing,color: Colors.black45,),
                        SizedBox(width: 15,),
                        Text(choice,
                          style: GoogleFonts.montserrat(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ),
          SizedBox(width: 10,)
        ],
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset("assets/images/main_top.png"),
              width: size.width * 0.5,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset("assets/images/login_bottom.png"),
              width: size.width * 0.6,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50,),
                Text("Choose Quiz Subject",textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 35,
                    color: Colors.indigo,
                    fontWeight: FontWeight.w400,
                  )
                  ,),
                Container(
                  height: 480,
                  width: 500,
                  child: GestureDetector(
                    onTap: (){
                      minionController.jump();
                    },
                    child: FlareActor(
                      "assets/images/minion.flr",
                      controller: minionController,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  //height: size.width*0.25,
                  width: size.width*0.8,
                  child: DropdownButtonFormField(
                    items: dynamic_topic.map((sub){
                      return DropdownMenuItem(
                        value: sub,
                        child: Text(sub.toString()),
                      );
                    }).toList(),
                    hint: Text(' Subjects',style: GoogleFonts.montserrat(),),
                    onChanged: (val) =>setState((){
                      quizSubject = val;
                      //DatabaseService().addTeacherSubject(quizSubject);
                      minionController.dance();
                    }),
                  ),
                ),
                SizedBox(height: 25,),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        backgroundColor: Colors.indigo,
        onPressed: (){
          if(quizSubject.isEmpty){
            Flushbar(
              padding: EdgeInsets.all(10.0),
              borderRadius: 8,
              backgroundGradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.grey],
                stops: [0.5, 1],
              ),
              boxShadows: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(3, 3),
                  blurRadius: 3,
                ),
              ],
              dismissDirection: FlushbarDismissDirection.HORIZONTAL,
              forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
              title: 'Something Missing!!',
              message: 'You have not selected anything atleast choose one option',
              duration: Duration(seconds: 3),
            )..show(context);
          }else{
            try{
              minionController.jump();
              Navigator.push(context, MaterialPageRoute(builder: (_){
                return StudentQuiz();
              }));
              //Navigator.pop(context);
            }catch(e){
              print(e);
            }

          }
        },
        elevation: 0.7,
      ),
    );

  }
  void choiceAction(String choice){
    if(choice == Constants.SignOut)
    {
      AuthService().signOutGoogle().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
        return LoginSignup();
      })));
    }
  }
}
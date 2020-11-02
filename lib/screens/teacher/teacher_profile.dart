import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_box/screens/login_signup.dart';
import 'package:quiz_box/screens/student/show_details.dart';
import 'package:quiz_box/screens/student/update_info.dart';
import 'package:quiz_box/screens/teacher/show_teacher_details.dart';
import 'package:quiz_box/screens/teacher/update_teach_info.dart';
import 'package:quiz_box/services/auth.dart';
import 'package:quiz_box/shared/constants.dart';

class TeacherProfile extends StatefulWidget {

  String uid;
  TeacherProfile({this.uid});

  @override
  _TeacherProfileState createState() => _TeacherProfileState(uid: uid);
}

class _TeacherProfileState extends State<TeacherProfile> {

  String uid;
  _TeacherProfileState({this.uid});

  // updating info where details are given in bottom sheet after clicking edit floating button
  void _updateInfo(context, uid){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return SingleChildScrollView(
            child: Container(
              height: 1000,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: UpdateTeachInfo(),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          'Profile',
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
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Stack(
          children:[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset("assets/images/main_top.png"),
              width: size.width * 0.5,
            ),

            Column(

            children: <Widget>[
              //ImagesInput(),
              SizedBox(height: 15.0,),
              ShowTeachDetails(),
              SizedBox(height: 24.0,),

              // registering for quizzes todo
            ],
          ),
      ],
        ),
      ),

      // edit button for updating info
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(Icons.mode_edit),
        onPressed: () => _updateInfo(context,uid),
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

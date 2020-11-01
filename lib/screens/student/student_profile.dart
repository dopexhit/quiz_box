
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_box/screens/login_signup.dart';
import 'package:quiz_box/screens/student/show_details.dart';
import 'package:quiz_box/screens/student/topics.dart';
import 'package:quiz_box/screens/student/update_info.dart';
import 'package:quiz_box/services/auth.dart';
import 'package:quiz_box/shared/constants.dart';

class StudentProfile extends StatefulWidget {

  String uid;
  StudentProfile({this.uid});

  @override
  _StudentProfileState createState() => _StudentProfileState(uid: uid);
}

class _StudentProfileState extends State<StudentProfile> {

  String uid;
  _StudentProfileState({this.uid});

  // updating info where details are given in bottom sheet after clicking edit floating button
  void _updateInfo(context, uid){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return SingleChildScrollView(
            child: Container(
              height: 1000,
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: UpdateInfo(),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //ImagesInput(),
            SizedBox(height: 15.0,),
            ShowDetails(),
            SizedBox(height: 24.0,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_){
                  return TopicRoute();
                }));
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 48,
                child: Text(
                  "Chose your curriculum subjects",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // edit button for updating info
      floatingActionButton: FloatingActionButton(
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

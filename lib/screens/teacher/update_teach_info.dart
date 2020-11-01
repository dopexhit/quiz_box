

import 'package:flutter/material.dart';
import 'package:quiz_box/model/custom_user.dart';
import 'package:quiz_box/screens/teacher/choose_teacher_subject.dart';
import 'package:quiz_box/services/database.dart';
import 'package:google_fonts/google_fonts.dart';
class UpdateTeachInfo extends StatefulWidget {

  @override
  _UpdateTeachInfoState createState() => _UpdateTeachInfoState();
}

class _UpdateTeachInfoState extends State<UpdateTeachInfo> {



  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentPhone;
  String _currentPhoto;
  String _currentGender;
  String _currentSubject;

  @override
  Widget build(BuildContext context) {

    // data is fetched in the list from fireStore
    return StreamBuilder<TeacherData>(
      stream: DatabaseService().teacherData,
      builder: (context,snapshot){
        // if snapshot has some data then is condition will work else it will show an error which is in the else part
        if(snapshot.hasData){
          TeacherData userData = snapshot.data;
          // updating your info
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Update Info",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 25.0,),
                SizedBox(height: 15.0,),
                TextFormField(
                  initialValue: userData.name,
                  decoration: InputDecoration(hasFloatingPlaceholder: true, hintText: "Enter Your Username"),
                  validator: (input){
                    if(input.isEmpty){
                      return "Enter Name";
                    }
                  },
                  onChanged: (val){
                    setState(() {
                      _currentName = val;
                    });
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  initialValue: userData.phoneNo,
                  decoration: InputDecoration(hasFloatingPlaceholder: true, hintText: "Enter phone number"),
                  validator: (input) {
                    if (input.isEmpty) {
                      return 'Enter Phone Nuumber';
                    }
                  },
                  onChanged: (val) {
                    setState(() => _currentPhone = val);
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  initialValue: userData.gender,
                  decoration: InputDecoration(hasFloatingPlaceholder: true, hintText: "Enter your gender"),
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Enter gender";
                    }
                  },
                  onChanged: (val) {
                    setState(() => _currentGender = val);
                  },
                ),
                SizedBox(height: 15,),
                FlatButton(
                  shape: StadiumBorder(),
                  color: Colors.indigo,
                  child: Text("Choose the subject you teach"),
                  textColor: Colors.white,
                  padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>Minion()));
                    setState(() {
                      _currentSubject=quizSubject;
                    });
                  },
                ),
                SizedBox(height: 15),
                // Information is stored to fireStore firebase
                FlatButton(
                  child: Text("Update"),
                  shape: StadiumBorder(),
                  color: Colors.indigo,
                  textColor: Colors.white,
                  padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      await DatabaseService().updateTeacherData(
                        _currentName ?? userData.name,
                        _currentPhone ?? userData.phoneNo,
                        _currentPhoto ?? userData.photoUrl,
                        _currentSubject ?? userData.subject,
                        _currentGender ?? userData.gender,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        }
        // if snapshot doesn't contain any data then error message is displayed
        else{
          return Container(
            child: Text("You got an error"),
          );
        }
      },
    );
  }
}

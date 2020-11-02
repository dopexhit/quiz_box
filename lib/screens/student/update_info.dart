

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_box/model/custom_user.dart';
import 'package:quiz_box/services/database.dart';
import 'package:google_fonts/google_fonts.dart';
class UpdateInfo extends StatefulWidget {

  @override
  _UpdateInfoState createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {

  _UpdateInfoState();

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentPhone;
  String _currentPhoto;
  String _currentReg;
  String _currentGender;
  String _currentBranch;
  List<String> _topic=new List();

  @override
  Widget build(BuildContext context) {

    // data is fetched in the list from fireStore
    return StreamBuilder<UserData>(
      stream: DatabaseService().userData,
      builder: (context,snapshot){
        // if snapshot has some data then is condition will work else it will show an error which is in the else part
        if(snapshot.hasData){
          UserData userData = snapshot.data;
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
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
                  initialValue: userData.branch,
                  decoration: InputDecoration(hasFloatingPlaceholder: true, hintText: "Enter Your Branch"),
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Enter Branch";
                    }
                  },
                  onChanged: (val) {
                    setState(() => _currentBranch = val);
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  initialValue: userData.regNo,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hasFloatingPlaceholder: true, hintText: "Enter your registration number"),
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Enter Registration Number";
                    }
                  },
                  onChanged: (val) {
                    setState(() => _currentReg = val);
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
                // Information is stored to fireStore firebase
                FlatButton(
                  child: Text("Update"),
                  shape: StadiumBorder(),
                  color: Colors.indigo,
                  textColor: Colors.white,
                  padding: EdgeInsets.only(left: 38, right: 38, top: 15, bottom: 15),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      await DatabaseService().updateUserData(
                        _currentName ?? userData.name,
                        _currentPhone ?? userData.phoneNo,
                        _currentPhoto ?? userData.photoUrl,
                        _currentReg ?? userData.gender,
                        _currentBranch ?? userData.branch,
                        _currentGender ?? userData.gender,
                        //topic;
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

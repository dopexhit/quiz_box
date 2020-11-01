
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:quiz_box/screens/login_signup.dart';
import 'package:quiz_box/services/auth.dart';
import 'package:quiz_box/services/database.dart';
import 'package:quiz_box/shared/constants.dart';

import 'package:random_string/random_string.dart';
List<String> topic=new List();

class TopicRoute extends StatefulWidget {
  @override
  _TopicRouteState createState() => _TopicRouteState();
}

class _TopicRouteState extends State<TopicRoute> {
  String id='';
  DatabaseService databaseService = new DatabaseService();

  @override
  void initState() {
    super.initState();
    topic.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          'Curriculum',
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
      body: ListView(
        children: <Widget>[
          new Padding(padding: EdgeInsets.all(20.0)),
          CheckboxGroup(
              orientation: GroupedButtonsOrientation.VERTICAL,
              margin: const EdgeInsets.only(left: 12.0),
              labels: <String>[
                'Physics', 'Maths', 'Chemistry', 'English', 'Biology', 'Computer Science'
              ],
              onSelected: (List<String> checked){
                setState(() {
                  topic=checked;
                });
              }
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
          Text(
            "  Click clear if you want to clear list or Submit to  Save your interests",
            style: GoogleFonts.montserrat(
              fontSize: 17,
            ),
          ),
    SizedBox(height: 10,),
    FlatButton(
    shape: StadiumBorder(),
    color: Colors.indigo,
    child: Text("CLEAR",
    style: GoogleFonts.aBeeZee(
    letterSpacing: 3,
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    ),
    ),
    onPressed: (){
      topic.clear();
    },
    ),
          FlatButton(
            shape: StadiumBorder(),
            color: Colors.indigo,
            child: Text("SUBMIT",
              style: GoogleFonts.aBeeZee(
                letterSpacing: 3,
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: (){
              handleSubmit(context);
            },
          ),
        ],
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

  handleSubmit(BuildContext context) async {
    if(topic.length==0)
    {
      Flushbar(
        padding: EdgeInsets.all(10.0),
        borderRadius: 8,
        backgroundGradient: LinearGradient(
          colors: [Colors.red.shade500, Colors.orange.shade500],
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
        title: 'Something Missing!!!',
        message: 'You have not selected anything atleast choose one option',
        duration: Duration(seconds: 3),
      )..show(context);

    }
    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(StaticState.user.email.toString(), 1);
    String s=StaticState.user.email;
    s=s.substring(0,s.indexOf("@"));*/

    /*databaseReference.child(name).child("topicsofinterest").set({"toi":topic});
    databaseReference.*/
    //Map<String,List> lt = {'toi':topic};

    id=uid+'??';

    Map<String,dynamic>quizMap = {
      'toi':topic,
    };

    await databaseService.addUserTopics(quizMap, id).then((value) => Navigator.pop(context));



    //await databaseService.addUserTopics({"toi":topic});
    /*Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => NewsMain()));*/

  }
}
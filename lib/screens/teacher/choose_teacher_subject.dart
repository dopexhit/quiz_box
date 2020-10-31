import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:quiz_box/animations/minion_controller.dart';
import 'package:quiz_box/screens/teacher/teacher_bottom_navi.dart';
import 'package:quiz_box/services/database.dart';

String quizSubject='';

class Minion extends StatefulWidget {
  @override
  _MinionState createState() => _MinionState();
}

class _MinionState extends State<Minion> {
  MinionController minionController;
  final List<String> subjects= ['Physics', 'Maths', 'Chemistry', 'English', 'Biology', 'Computer Science'];
  bool _isLoading=false;
  @override
  void initState() {
    super.initState();
    minionController = MinionController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                Text("Choose Subject",textAlign: TextAlign.center,
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
                    items: subjects.map((sub){
                      return DropdownMenuItem(
                        value: sub,
                        child: Text(sub),
                      );
                    }).toList(),
                    hint: Text(' Subjects',style: GoogleFonts.montserrat(),),
                    onChanged: (val) =>setState((){
                      quizSubject = val;
                      DatabaseService().addTeacherSubject(quizSubject);
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                return BottomNaviHome();
                //initally TeacherQuiz
              }));
            }catch(e){
              print(e);
            }

          }
        },
        elevation: 0.7,
      ),
    );

  }
}
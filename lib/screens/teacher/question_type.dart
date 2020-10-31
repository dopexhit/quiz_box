import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_box/screens/teacher/add_question.dart';
import 'package:transparent_image/transparent_image.dart';

import 'add_question_tf.dart';

class QuestionType extends StatefulWidget {
  final String quizId;
  QuestionType({this.quizId});
  @override
  _QuestionTypeState createState() => _QuestionTypeState();
}

class _QuestionTypeState extends State<QuestionType> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Center(
              child: Text(
                'Question Type',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 9.0,
                ),
              ],
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
            //alignment: Alignment.center,
            height: size.height,
            width: size.width,
            child: SafeArea(
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Spacer(),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddQuestion(
                                quizId: widget.quizId,)));
                    },
                    child: Container(
                      height: size.height*0.25,
                      width: size.width*0.5,
                      child: Card(
                        color: Colors.blue,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Icon(
                                Icons.radio_button_checked,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, left: 120),
                              child: Text('Single Correct',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddQuestionTF(
                                quizId: widget.quizId,)));
                    },
                    child: Container(
                      height: size.height*0.25,
                      width: size.width*0.5,
                      child: Card(
                        color: Colors.orange,
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Icon(
                                Icons.done_outline,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, left: 120),
                              child: Text('True/False',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

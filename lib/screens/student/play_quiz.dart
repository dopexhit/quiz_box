import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_box/model/question_model.dart';
import 'package:quiz_box/screens/student/results.dart';
import 'package:quiz_box/services/database.dart';
import 'package:quiz_box/shared/constants.dart';


class PlayQuizStu extends StatefulWidget {
  final String quizId;
  PlayQuizStu({this.quizId});

  @override
  _PlayQuizStuState createState() => _PlayQuizStuState();
}

int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
int total = 0;

/// Stream
Stream infoStream;

class _PlayQuizStuState extends State<PlayQuizStu> {
  QuerySnapshot questionSnaphot;
  DatabaseService databaseService = new DatabaseService();
  bool isLoading = true;

  @override
  void initState() {
    databaseService.getQuizData(widget.quizId).then((value) {
      questionSnaphot = value;
      _notAttempted = questionSnaphot.documents.length;
      _correct = 0;
      _incorrect = 0;
      isLoading = false;
      total = questionSnaphot.documents.length;
      setState(() {});
      print("init don $total ${widget.quizId} ");

    });

    if(infoStream == null){
      infoStream = Stream<List<int>>.periodic(
          Duration(milliseconds: 100), (x){
        //print("this is x $x");
        return [_correct, _incorrect] ;
      });
    }
    super.initState();
  }


  QuestionModal getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModal questionModel = new QuestionModal();

    questionModel.question = questionSnapshot.data()["question"];

    /// shuffling the options
    List<String> options = [
      questionSnapshot.data()["option1"],
      questionSnapshot.data()["option2"],
      questionSnapshot.data()["option3"],
      questionSnapshot.data()["option4"]
    ];

    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data()["option1"];
    questionModel.answered = false;

    print(questionModel.correctOption.toLowerCase());
    return questionModel;
  }


  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return showDialog(
            context: context,
            builder: (context)=>AlertDialog(
              title: Text(
                'QuizBox',
              ),
              content: Text(
                  "You Can't Go Back At This Stage."
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Ok",
                  ),
                )
              ],
            )
        );
      },
      child: Scaffold(
        appBar:
        AppBar(
          backgroundColor: Colors.white70,
          title:  Text(
            'Quiz',
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            Icon(Icons.timer,color: Colors.indigo,),
            SizedBox(width: 5,),
            Center(child: TweenAnimationBuilder<Duration>(
                duration: Duration(minutes: 1),
                tween: Tween(begin: Duration(minutes: 1), end: Duration.zero),
                onEnd: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return Results(
                      correct: _correct,
                      incorrect: _incorrect,
                      total: total,
                    );
                  }));
                },
                builder: (BuildContext context, Duration value, Widget child) {
                  final minutes = value.inMinutes;
                  final seconds = value.inSeconds % 60;
                  return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text('$minutes:$seconds',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)));
                }),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              //child:
            ),
          ],
        ),
        body: isLoading
            ? Container(
          child: Center(child: CircularProgressIndicator()),
        )
            : SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                InfoHeader(
                  length: questionSnaphot.documents.length,
                ),
                SizedBox(
                  height: 10,
                ),
                questionSnaphot.documents == null
                    ? Container(
                  child: Center(child: Text("No Data"),),
                )
                    : ListView.builder(
                    itemCount: questionSnaphot.documents.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return QuizPlayTile(
                        questionModel: getQuestionModelFromDatasnapshot(
                            questionSnaphot.documents[index]),
                        index: index,
                      );
                    })
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigoAccent,
          child: Icon(Icons.check),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return Results(
                correct: _correct,
                incorrect: _incorrect,
                total: total,
              );
            }));
          },
        ),
      ),
    );
  }
}

class InfoHeader extends StatefulWidget {
  final int length;

  InfoHeader({@required this.length});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: infoStream,
        builder: (context, snapshot){
          return snapshot.hasData ? Container(
            height: 40,
            margin: EdgeInsets.only(left: 14),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                NoOfQuestionTile(
                  text: "Total",
                  number: widget.length,
                ),
                NoOfQuestionTile(
                  text: "Correct",
                  number: _correct,
                ),
                NoOfQuestionTile(
                  text: "Incorrect",
                  number: _incorrect,
                ),
                NoOfQuestionTile(
                  text: "NotAttempted",
                  number: _notAttempted,
                ),
              ],
            ),
          ) : Container();
        }
    );
  }
}


class QuizPlayTile extends StatefulWidget {
  final QuestionModal questionModel;
  final int index;

  QuizPlayTile({@required this.questionModel, @required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: 20
            ),
            child: Text(
              "Q${widget.index + 1}. ${widget.questionModel.question}",
              style:
              GoogleFonts.aBeeZee(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option1;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: widget.questionModel.option1 !=null ? OptionTile(
              option: " ",
              decription: "${widget.questionModel.option1}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ) : Container(),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option2 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option2;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: widget.questionModel.option2 !=null ? OptionTile(
              option: " ",
              decription: "${widget.questionModel.option2}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ): Container(),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option3 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option3;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: widget.questionModel.option3 != null ? OptionTile(
              option: " ",
              decription: "${widget.questionModel.option3}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ) : Container(),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option4 ==
                    widget.questionModel.correctOption) {
                  setState(() {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _correct = _correct + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                } else {
                  setState(() {
                    optionSelected = widget.questionModel.option4;
                    widget.questionModel.answered = true;
                    _incorrect = _incorrect + 1;
                    _notAttempted = _notAttempted - 1;
                  });
                }
              }
            },
            child: widget.questionModel.option4 != null ? OptionTile(
              option: " ",
              decription: "${widget.questionModel.option4}",
              correctAnswer: widget.questionModel.correctOption,
              optionSelected: optionSelected,
            ) : Container(),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

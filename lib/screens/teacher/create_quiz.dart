import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_box/screens/login_signup.dart';
import 'package:quiz_box/screens/teacher/question_type.dart';
import 'package:quiz_box/services/auth.dart';
import 'package:quiz_box/services/database.dart';
import 'package:quiz_box/shared/constants.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String quizId, quizTitle, quiImgUrl, quizTime, quizDescription, quizSubject;

  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;
  createQuizOnline() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      quizId = randomAlphaNumeric(16);

      await databaseService
          .addQuiz2(quizId, quiImgUrl, quizTime, quizTitle, quizDescription)
          .then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
            return QuestionType(
              quizId: quizId,
            );
          }));
          /*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddQuestion(
                        quizId: quizId,)));*/
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          'Create Quiz',
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
      body: _isLoading
          ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      )
          : Form(
        key: _formKey,
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 340,
                  width: 340,
                  child: Image.asset("assets/images/create.png"),
                )
                ,
                TextFormField(
                  validator: (val) =>
                  val.isEmpty ? 'Enter Image Url' : null,
                  decoration: kTextFieldDecoration.copyWith(
                    prefixIcon: Icon(Icons.title),
                    labelText: 'Image Url',
                  ),
                  onChanged: (val) {
                    quiImgUrl = val;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                  val.isEmpty ? 'Enter Quiz Time' : null,
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Quiz Time',
                    prefixIcon: Icon(Icons.access_time),

                  ),
                  onChanged: (val) {
                    quizTime = val;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                  val.isEmpty ? 'Enter Quiz Title' : null,
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Quiz Title',
                    prefixIcon: Icon(Icons.format_color_text),
                  ),
                  onChanged: (val) {
                    quizTitle = val;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (val) =>
                  val.isEmpty ? 'Enter Quiz Description' : null,
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Quiz Description',
                      prefixIcon: Icon(Icons.description)
                  ),
                  onChanged: (val) {
                    quizDescription = val;
                  },
                ),
                // Spacer(),
                SizedBox(
                  height: 35,
                ),
                GestureDetector(
                  onTap: (){
                    createQuizOnline();
                  },
                  child: Container(
                    width: size.width*0.75,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 9.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child:
                    Text('Create',  textAlign: TextAlign.center,style: GoogleFonts.gabriela(
                        fontSize: 22,
                        color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_box/screens/teacher/question_type.dart';
import 'package:quiz_box/screens/teacher/teacher_bottom_navi.dart';
import 'package:quiz_box/services/database.dart';
import 'package:quiz_box/shared/constants.dart';


class AddQuestion extends StatefulWidget {
  final String quizId;

  AddQuestion({this.quizId});
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {


  final _formKey = GlobalKey<FormState>();
  String question,option1,option2,option3,option4;
  bool _isLoading=false;

  DatabaseService databaseService = new DatabaseService();
  uploadQuestionData() async {
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading=true;
      });
      Map<String,String>questionMap ={
        'question': question,
        'option1':option1,
        'option2':option2,
        'option3':option3,
        'option4':option4,
      };
      await databaseService.addQuestionData(questionMap, widget.quizId).then((value){
        setState(() {
          _isLoading=false;
        });
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ):Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            height: size.height*1.1,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SizedBox(height: 15,),
                Container(
                  height: 270,
                  width: 270,
                  child: Image.asset("assets/images/single_correct.png"),
                ),
                SizedBox(height: 6,),
                TextFormField(
                  validator: (val)=>val.isEmpty ? 'Enter Question':null,
                  decoration: kTextFieldDecoration.copyWith(
                    prefixIcon: Icon(Icons.title),
                    labelText: 'Question',
                  ),
                  onChanged: (val){
                    question=val;
                  },
                ),
                SizedBox(height: 6,),

                TextFormField(
                  validator: (val)=>val.isEmpty ? 'Enter Option1':null,
                  decoration: kTextFieldDecoration.copyWith(
                    prefixIcon: Icon(Icons.adjust),
                    labelText: 'Option1 (Correct Answer)',
                  ),
                  onChanged: (val){
                    option1=val;
                  },
                ),
                SizedBox(height: 6,),

                TextFormField(
                  validator: (val)=>val.isEmpty ? 'Enter Option2':null,
                  decoration: kTextFieldDecoration.copyWith(
                    prefixIcon: Icon(Icons.adjust),
                    labelText: 'Option2',
                  ),
                  onChanged: (val){
                    option2=val;
                  },
                ),
                SizedBox(height: 6,),

                TextFormField(
                  validator: (val)=>val.isEmpty ? 'Enter Option3':null,
                  decoration: kTextFieldDecoration.copyWith(
                    prefixIcon: Icon(Icons.adjust),
                    labelText: 'Option3',
                  ),
                  onChanged: (val){
                    option3=val;
                  },
                ),

                SizedBox(height: 6,),

                TextFormField(
                  validator: (val)=>val.isEmpty ? 'Enter Option4':null,
                  decoration: kTextFieldDecoration.copyWith(
                    prefixIcon: Icon(Icons.adjust),
                    labelText: 'Option4',
                  ),
                  onChanged: (val){
                    option4=val;
                  },
                ),
                SizedBox(height: 15,),
                //Spacer(),
                Container(
                  //height: size.height*0.25,
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            uploadQuestionData();
                            if(option1!=null && option2!=null && option3!=null && option4!=null){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                                return BottomNaviHome();
                              }));
                            }
                          },
                          child: Container(
                            width: size.width*0.25,
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
                            Text('Submit',  textAlign: TextAlign.center,style: GoogleFonts.gabriela(
                                fontSize: 22,
                                color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        GestureDetector(
                          onTap: (){
                            uploadQuestionData();
                            if(option1!=null && option2!=null && option3!=null && option4!=null) {
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (_) {
                                return QuestionType(
                                  quizId: widget.quizId,
                                );
                              }));
                            }
                          },
                          child: Container(
                            width: size.width*0.45,
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
                            Text('Add Question',  textAlign: TextAlign.center,style: GoogleFonts.gabriela(
                                fontSize: 22,
                                color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //SizedBox(height: 50,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


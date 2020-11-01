import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:custom_navigator/custom_scaffold.dart';
import 'package:quiz_box/screens/student/student_bottom_navi.dart';
import 'package:quiz_box/services/auth.dart';

class Results extends StatefulWidget {
  final int correct,incorrect,total;

  Results({@required this.correct,@required this.incorrect,@required this.total});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title:  Text(
          'Result',
          style: GoogleFonts.aBeeZee(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 270,
                width: 270,
                child: Image.asset("assets/images/done.png"),
              ),
              SizedBox(height: 10,),
              Text("${widget.correct} / ${widget.total}\n",style: GoogleFonts.montserrat(
                fontSize: 30,
                color: Colors.blueAccent,
              ),),
              SizedBox(height: 5,),
              Text("You answered ${widget.correct} answers correctly \n and"
                  "\n${widget.incorrect} answers incorrectly",style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Colors.black,
              ),textAlign: TextAlign.center,),
              SizedBox(height: 17,),
              RaisedButton(
                onPressed: () {
                  //updateScore(widget.correct,widget.total);
                  Navigator.pop(context);
                },
                color: Colors.indigo,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Go to dashboard',
                    style: GoogleFonts.gabriela(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),

            ],
          ),
        ),
      ),
    );
  }
  // void updateScore(int correct, int total) async{
  //   int quiz_given=0,corrected,totaled;
  //   DocumentReference doc=FirebaseFirestore.instance.collection('Student').doc(uid+"score");
  //   print(doc);
  //
  //     doc.get().then((DocumentSnapshot documentSnapshot) {
  //       if (documentSnapshot.exists) {
  //         //setState(() {
  //           corrected=correct+documentSnapshot.data()['correct'];
  //           totaled=total+documentSnapshot.data()['total'];
  //           quiz_given=documentSnapshot.data()['quiz_given']+1;
  //         //});
  //       }
  //     });
  //     await doc.update({'correct': correct+corrected,'total': total+totaled, 'quiz_given': quiz_given});
  // }
}




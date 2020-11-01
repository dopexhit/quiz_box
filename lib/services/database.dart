import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_box/model/custom_user.dart';
import 'package:quiz_box/screens/teacher/choose_teacher_subject.dart';
import 'package:quiz_box/services/auth.dart';

class DatabaseService {
  Future<void> addUserTopics(Map quizData, String id) async {
    await Firestore.instance
        .collection('Student')
        .document(id)
        .setData(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuizData(Map quizData, String quizId) async {
    await Firestore.instance
        .collection('Quiz')
        .document(quizId)
        .setData(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future <void>addQuiz2(String quizId,String imgUrl ,String time, String title, String des) async
  {
    await Firestore.instance.collection(quizSubject)
        .doc(quizId)
        .setData({
      'imgUrl': imgUrl,
      'time': time,
      'uid': quizId,
      'description': des,
      'title': title })
        .catchError((e){print(e.toString());});
  }

  Future<void> addQuestionData(Map questionData, String quizId) async {
    await Firestore.instance
        .collection(quizSubject)
        .document(quizId)
        .collection('QNA')
        .add(questionData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getQuizzesData(String quizSubject) async {
    return await Firestore.instance.collection(quizSubject).snapshots();
  }

  addTeacherSubject(String quizSubject) async{
    await Firestore.instance.collection('Teacher').doc(uid).set({'subject': quizSubject})
        .catchError((e){print(e.toString());});
  }
  getQuizData(String quizId) async {
    return await Firestore.instance
        .collection(quizSubject)
        .document(quizId)
        .collection('QNA')
        .getDocuments();
  }

  //profile Added
  final CollectionReference userCollection = Firestore.instance.collection('Student');
  Future updateUserData(String name,String phoneNo,String photoUrl,String regNo,String branch,String gender) async{

    return await userCollection.document(uid).setData({
      'name': name,
      'phoneNo' : phoneNo,
      'photoUrl': photoUrl,
      'regNo': regNo,
      'branch': branch,
      'gender': gender,
    });
  }

  // student list from snapshot
  List<User_Data> _userDataDetailFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return User_Data(
        name: doc.data()['name'] ?? '0',
        phoneNo: doc.data()['phoneNo']??'0',
        photoUrl: doc.data()['photoUrl']??'0',
        regNo: doc.data()['regNo']??'0',
        branch: doc.data()['branch']??'0',
        gender: doc.data()['gender']??'0',
      );
    }).toList();
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return  UserData(
      uid:uid,
      name: snapshot.data()['name'],
      phoneNo: snapshot.data()['phoneNo'],
      photoUrl: snapshot.data()['photoUrl'],
      regNo: snapshot.data()['regNo'],
      branch: snapshot.data()['branch'],
      gender: snapshot.data()['gender'],
    );
  }

  Stream<List<User_Data>> get user_Data {
    return userCollection.snapshots().map(_userDataDetailFromSnapshot);
  }

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  //teacher profile
  final CollectionReference teacherCollection = Firestore.instance.collection('Teacher');
  Future updateTeacherData(String name,String phoneNo,String photoUrl,String subject,String gender) async{

    return await teacherCollection.document(uid).setData({
      'name': name,
      'phoneNo' : phoneNo,
      'photoUrl': photoUrl,
      'subject': subject,
      'gender': gender,
    });
  }

  // student list from snapshot
  List<Teacher_Data> _teacherDataDetailFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Teacher_Data(
        name: doc.data()['name'] ?? '0',
        phoneNo: doc.data()['phoneNo']??'0',
        photoUrl: doc.data()['photoUrl']??'0',
        subject: doc.data()['subject']??'0',
        gender: doc.data()['gender']??'0',
      );
    }).toList();
  }

  // user data from snapshot
  TeacherData _teacherDataFromSnapshot(DocumentSnapshot snapshot){
    return  TeacherData(
      uid:uid,
      name: snapshot.data()['name'],
      phoneNo: snapshot.data()['phoneNo'],
      photoUrl: snapshot.data()['photoUrl'],
      subject: snapshot.data()['subject'],
      gender: snapshot.data()['gender'],
    );
  }

  Stream<List<Teacher_Data>> get teacher_Data {
    return teacherCollection.snapshots().map(_teacherDataDetailFromSnapshot);
  }

  Stream<TeacherData> get teacherData {
    return teacherCollection.document(uid).snapshots().map(_teacherDataFromSnapshot);
  }

}

class CustomUser{
  final String uid;
  CustomUser({this.uid});
}

class UserData{
  final String uid;
  final String name;
  final String phoneNo;
  final String photoUrl;
  final String regNo;
  final String branch;
  final String gender;

  UserData({
    this.uid,
    this.name,
    this.phoneNo,
    this.photoUrl,
    this.regNo,
    this.branch,
    this.gender,
  });
}

class User_Data{

  final String name;
  final String phoneNo;
  final String photoUrl;
  final String regNo;
  final String branch;
  final String gender;

  User_Data({
    this.name,
    this.phoneNo,
    this.photoUrl,
    this.regNo,
    this.branch,
    this.gender,
  });
}

class TeacherData{
  final String uid;
  final String name;
  final String phoneNo;
  final String photoUrl;
  final String subject;
  final String gender;

  TeacherData({
    this.uid,
    this.name,
    this.phoneNo,
    this.photoUrl,
    this.subject,
    this.gender,
  });
}

class Teacher_Data{

  final String name;
  final String phoneNo;
  final String photoUrl;
  final String subject;
  final String gender;

  Teacher_Data({
    this.name,
    this.phoneNo,
    this.photoUrl,
    this.subject,
    this.gender,
  });
}

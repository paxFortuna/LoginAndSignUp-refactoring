class UserModel {
  final int? id;
  final String userId;
  final String userName;
  final String email;
  final String password;
  final String gender;
  final int age;
  final String repeated;
  final String selectDate;

  UserModel({
    this.id,
    required this.userId,
    required this.userName,
    required this.email,
    required this.password,
    required this.gender,
    required this.age,
    required this.repeated,
    required this.selectDate,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{
      '_id': id,
      'userId': userId,
      'userName': userName,
      'email': email,
      'password': password,
      'gender': gender,
      'age': age,
      'repeated': repeated,
      'selectDate': selectDate,
    };
    return map;
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as int,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      gender: map['gender'] as String,
      age: map['age'] as int,
      repeated: map['repeated'] as String,
      selectDate: map['selectDate'] as String,
    );
  }
}


import 'package:flutter/material.dart';
import 'package:login_signup_refactoring/data/db_helper.dart';
import 'package:login_signup_refactoring/presentaion/components/gen_signup_header.dart';
import 'package:login_signup_refactoring/presentaion/components/signup_form.dart';
import 'package:login_signup_refactoring/presentaion/user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAndSignupView extends StatefulWidget {
  const LoginAndSignupView({Key? key}) : super(key: key);

  @override
  State<LoginAndSignupView> createState() => _LoginAndSignupViewState();
}

class _LoginAndSignupViewState extends State<LoginAndSignupView> {
  final _userIdTextController = TextEditingController();
  final _userNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final Map<String, dynamic> _userDataMap = <String, dynamic>{};

  _updateMyTitle(List<dynamic> data) {
    setState(() {
      _userDataMap[data[0]] = data[1];
    });
  }

  _setIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', true);
  }

  final dbHelper = DbHelper();

  // final loginController = Get.put(LoginAndSignupController());

  @override
  void initState() {
    _query();
    _userDataMap['gender'] = '남성';
    _userDataMap['term'] = false;
    super.initState();
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    // print('query all rows:');
    for (var row in allRows) {
      print(row);
      print('row age is ${row[DbHelper.cAge]}');
      continue;
    }
  }

  @override
  void dispose() {
    _userIdTextController.dispose();
    _userNameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  // Save new data to the SQLite database
  void _insert() async {
    final newData = {
      DbHelper.cUserID: _userIdTextController.text,
      DbHelper.cUserName: _userNameTextController.text,
      DbHelper.cGender: _userDataMap['gender'],
      DbHelper.cEmail: _emailTextController.text,
      DbHelper.cPassword: _passwordTextController.text,
      DbHelper.cAge: _userDataMap['age'],
      DbHelper.cRepeated: _userDataMap['repeated'],
      DbHelper.cSelectDate: _userDataMap['selectDate'],
    };
    await dbHelper.insertUser(newData);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const GenLoginSignupHeader(
                  headerName: '개인정보입력',
                ),
                GenSignUpForm(
                  _userIdTextController,
                  _userNameTextController,
                  _emailTextController,
                  _passwordTextController,
                  _updateMyTitle,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            //_query();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '취소',
                                style: TextStyle(fontSize: 28),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_userIdTextController.text.isNotEmpty ||
                                _userNameTextController.text.isNotEmpty ||
                                _emailTextController.text.isNotEmpty ||
                                _passwordTextController.text.isNotEmpty) {
                              // print('last page');
                              _insert();
                              _setIsLogin();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserScreen()),
                              );
                            } else {
                              _showDialog(context);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '회원가입',
                                style: TextStyle(fontSize: 28),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('내용 확인'),
        content: const Text('모든 내용을 입력하세요'),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('회원가입 페이지')),
          // ElevatedButton(
          //     onPressed: () => Navigator.of(context).pop(),
          //     child: const Text('취소')),
        ],
      ),
    );
  }
}



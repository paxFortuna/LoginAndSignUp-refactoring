import 'package:flutter/material.dart';
import 'package:login_signup_refactoring/utils/theme.dart';
import 'input_field.dart';

class GenSignUpForm extends StatefulWidget {
  final TextEditingController userIdTextController;
  final TextEditingController userNameTextController;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final ValueChanged<List<dynamic>> parentAction;

  const GenSignUpForm(this.userIdTextController, this.userNameTextController,
      this.emailTextController, this.passwordTextController, this.parentAction,
      {super.key});

  @override
  State<GenSignUpForm> createState() => _GenSignUpFormState();
}

enum GenderEnum { man, woman }

class _GenSignUpFormState extends State<GenSignUpForm> {
  GenderEnum _userGender = GenderEnum.man;
  String _selectDateString = '출생 년월일 입력';

  bool _agreedToTerm = false;
  DateTime _selectedDate = DateTime.now();

  // drropdown button
  String _selectedRepeat = "야자시(11:30 ~ 12:00)";
  List<String> repeatList = [
    "야자시(23:30 ~ 24:00)",
    "조자시(24:00 ~ 01:30)",
    "축시(01:30 ~ 03:30)",
    "인시(03:30 ~ 05:30)",
    "묘시(05:30 ~ 07:30)",
    "진시(07:30 ~ 09:30)",
    "사시(09:30 ~ 11:30)",
    "오시(11:30 ~ 13:30)",
    "미시(13:30 ~ 15:30)",
    "신시(15:30 ~ 17:30)",
    "유시(17:30 ~ 19:30)",
    "술시(19:30 ~ 21:30)",
    "해시(21:30 ~ 23:30)",
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2026));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectDateString = "${_selectedDate.toLocal()}".split(' ')[0];
        _passDataToParent('age', calculateAge(picked));
        _passDataToParent('selectDate', _selectDateString);
      });
    }
    // print('your age is ${calculateAge(picked!)}');
  }

  void _passDataToParent(String key, dynamic value) {
    List<dynamic> addData = <dynamic>[];
    addData.add(key);
    addData.add(value);
    widget.parentAction(addData);
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  void _setAgreedToTerm(bool? newValue) {
    _passDataToParent('term', newValue);
    setState(() {
      _agreedToTerm = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // 다른 곳 클릭하면 키보드 사라지는 이벤트
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.account_circle),
                      labelText: 'ID',
                      hintText: 'ID'),
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return 'ID를 입력하세요';
                    } else {
                      return null;
                    }
                  },
                  controller: widget.userIdTextController,
                ),
                const Divider(),
                TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.account_circle),
                      labelText: '이름',
                      hintText: '이름'),
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return '이름을 입력하세요';
                    } else {
                      return null;
                    }
                  },
                  controller: widget.userNameTextController,
                ),
                const Divider(),
                SizedBox(
                  width: widthScreen,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.cake,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: SizedBox(
                          width: widthScreen * 0.7,
                          child: MaterialButton(
                            onPressed: () {
                              _selectDate(context);
                            },
                            color: Colors.lime,
                            child: Text(
                              _selectDateString,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.mail),
                    labelText: '이메일',
                    hintText: '이메일',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return '이메일을 입력하세요';
                    } else {
                      return null;
                    }
                  },
                  controller: widget.emailTextController,
                ),
                const Divider(),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.lock),
                      labelText: '비밀번호',
                      hintText: '비밀번호'),
                  validator: (String? value) {
                    if (value!.trim().isEmpty) {
                      return '비밀번호를 입력하세요';
                    } else {
                      return null;
                    }
                  },
                  controller: widget.passwordTextController,
                ),
                const Divider(),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.wc,
                      color: Colors.grey,
                    ),
                    Radio(
                      value: GenderEnum.man,
                      groupValue: _userGender,
                      onChanged: (GenderEnum? value) {
                        setState(() {
                          _passDataToParent('gender', '남성');
                          _userGender = value!;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _passDataToParent('gender', '남성');
                          _userGender = GenderEnum.man;
                        });
                      },
                      child: const Text('남성'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Radio(
                      value: GenderEnum.woman,
                      groupValue: _userGender,
                      onChanged: (GenderEnum? value) {
                        setState(() {
                          _passDataToParent('gender', '여성');
                          _userGender = value!;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _passDataToParent('gender', '여성');
                          _userGender = GenderEnum.woman;
                        });
                      },
                      child: const Text('여성'),
                    ),
                  ],
                ),
                const Divider(),
                MyInputField(
                  title: "출생시간",
                  hint: _selectedRepeat,
                  widget: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    underline: const SizedBox(height: 0),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    },
                    items: repeatList
                        .map<DropdownMenuItem<String>>((String? value) {
                      return DropdownMenuItem<String>(
                        onTap: () {
                          _passDataToParent('repeated', value);
                        },
                        value: value,
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Text(
                          value!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _agreedToTerm,
                        onChanged: _setAgreedToTerm,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _setAgreedToTerm(!_agreedToTerm),
                          child: const Text(
                            '본 서비스 이용약관과 개인정보정책에 동의합니다.',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// validateEmail(String email) {
//  final emailReg = RegExp(
//    // r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"
//      r"^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$"
//  );
//  return emailReg.hasMatch(email);
}

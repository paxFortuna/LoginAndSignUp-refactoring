import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:login_signup_refactoring/presentaion/login_and_sign_up_view.dart/login_and_signup_view.dart';
import 'package:login_signup_refactoring/presentaion/user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitPageView extends StatefulWidget {
  const InitPageView({Key? key}) : super(key: key);

  @override
  State<InitPageView> createState() => _InitPageViewState();
}

class _InitPageViewState extends State<InitPageView> {
  bool _isLogin = false;

  _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = (prefs.getBool('isLogin') ?? false);
    setState(() {
      _isLogin = isLogin;
    });
    debugPrint('prefs $isLogin');
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLogin ? _signInWidget() : const UserScreen();
  }

  Widget _signInWidget() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 14),
              padding: const EdgeInsets.all(8),
              decoration: _boxDecoration(),
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginAndSignupView()),
                  );
                  // Get.to(() => const LoginAndSignupView());
                },
                shape: const CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.redAccent,
                padding: const EdgeInsets.all(15.0),
                child: const Icon(
                  Icons.mail,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginAndSignupView()),
                );
                // Get.to(() => const LoginAndSignupView());
              },
              child: Container(
                margin: const EdgeInsets.only(left: 90, right: 90, top: 12),
                padding: const EdgeInsets.all(8),
                // neumorphism widget

                decoration: _boxDecoration(),
                alignment: Alignment.topCenter,
                child: const Text(
                  '사주정보 입력하기',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          spreadRadius: 3,
          color: Colors.grey.shade700,
          blurRadius: 10,
          offset: const Offset(5, 5),
        ),
        const BoxShadow(
          spreadRadius: 3,
          color: Colors.white,
          blurRadius: 12,
          offset: Offset(-5, -5),
        ),
      ],
    );
  }
}

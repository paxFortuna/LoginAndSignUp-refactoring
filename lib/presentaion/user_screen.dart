import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup_refactoring/data/db_helper.dart';
import 'package:login_signup_refactoring/init_page.dart';
import 'package:login_signup_refactoring/presentaion/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final dbHelper = DbHelper();

  Map<String, dynamic>? _useData;
  bool _fetchingData = true;

  @override
  void initState() {
    super.initState();
    _query();
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    setState(() {
      _useData = allRows[0];
      _fetchingData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('사용자 정보'),
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.grey.shade200,
          elevation: 0.5,
        ),
        body: _fetchingData
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(width: 16),
                        Image.asset(
                          'lib/assets/images/tarotWheel.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        Expanded(
                          child: titleSection(),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1),
                    // 개인정보 영역
                    contentSection(),
                    const Divider(thickness: 1),
                    // 삭제 버튼
                    _deleteUser(),
                    //
                    const Divider(thickness: 1),
                    _goHomePage(context),
                  ],
                ),
              ),
      ),
    );
  }

  Widget titleSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
              ),
              Text(
                _useData!['userName'],
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
              Text(
                _useData!['email'],
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.account_circle,
                  color: _useData!['gender'] == 'Man'
                      ? Colors.blue.shade700
                      : Colors.red.shade700,
                  size: 28,
                ),
                Text(_useData!['age'].toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget contentSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('I D         :'),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
                    decoration: _boxDecoration(),
                    child: _textWidget('userId'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Text('이름        :'),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
                    decoration: _boxDecoration(),
                    child: _textWidget('userName'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Text('이메일    :'),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
                    decoration: _boxDecoration(),
                    child: _textWidget('email'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Text('생년월일 :'),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
                    decoration: _boxDecoration(),
                    child: _textWidget('selectDate'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Text('출생시간 :'),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
                    decoration: _boxDecoration(),
                    child: _textWidget('repeated'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Text('나이        :'),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
                    decoration: _boxDecoration(),
                    child: Text(
                      _useData!['age'].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 0.5,
        style: BorderStyle.solid,
        color: Colors.black54,
      ),
      borderRadius: BorderRadius.circular(4),
    );
  }

  Text _textWidget(String text) {
    return Text(
      _useData![text],
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
    );
  }

  Widget _deleteUser() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: MaterialButton(
        color: Colors.yellow.shade200,
        minWidth: 300,
        onPressed: () {
          // print('delete user');
          _delete();
        },
        // SignUpScreen 으로 라우팅
        child: const Text('수정 / 삭제'),
      ),
    );
  }

  void _delete() async {
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id!);
    debugPrint('deleted $rowsDeleted row(s): row $id');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', false);    
    // navigator waring 제거 mounted! parameter
    if (!mounted) return;
    _navigator(context, const InitPageView());
  }

  Widget _goHomePage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: MaterialButton(
        color: Colors.yellow.shade200,
        minWidth: 300,
        onPressed: () async {
          if (!mounted) return;
          await _navigator(context, const HomeScreen());
        },
        child: const Text('확인'),
      ),
    );
  }

  Future _navigator(BuildContext context, Widget widget) async {
    return await Navigator.push(
        context, MaterialPageRoute(builder: (context) => widget));
  }
}

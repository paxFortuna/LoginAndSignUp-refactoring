import 'package:flutter_test/flutter_test.dart';
import 'package:login_signup_refactoring/data/db_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  test('db_helper Test', () async {
    sqfliteFfiInit();
    final dbHelper = DbHelper();

    final newData = {
      DbHelper.cUserID: 'test',
      DbHelper.cUserName: 'test',
      DbHelper.cGender: 'test',
      DbHelper.cEmail: 'test',
      DbHelper.cPassword: 'test',
      DbHelper.cAge: 10,
      DbHelper.cRepeated: 'repeated',
      DbHelper.cSelectDate: 'date',
    };

    // 처음에는 데이터가 없어야 한다.
    var allRows = await dbHelper.queryAllRows();
    expect(allRows.length, 0);

    // 1==========
    var insertedId = await dbHelper.insertUser(newData);

    allRows = await dbHelper.queryAllRows();
    expect(allRows.length, 1);

    var id = await dbHelper.queryRowCount();
    expect(insertedId, id!);

    var deletedRows = await dbHelper.delete(id!);
    expect(deletedRows, 1);

    allRows = await dbHelper.queryAllRows();
    expect(allRows.length, 0);

    // 2==========
    insertedId = await dbHelper.insertUser(newData);

    allRows = await dbHelper.queryAllRows();
    expect(allRows.length, 1);

    id = await dbHelper.queryRowCount();
    expect(insertedId, id!);

    deletedRows = await dbHelper.delete(id!);
    expect(deletedRows, 1);

    allRows = await dbHelper.queryAllRows();
    expect(allRows.length, 0);

    // 3==========
    insertedId = await dbHelper.insertUser(newData);

    allRows = await dbHelper.queryAllRows();
    expect(allRows.length, 1);

    id = await dbHelper.queryRowCount();
    expect(insertedId, id!);

    deletedRows = await dbHelper.delete(id!);
    expect(deletedRows, 1);


    allRows = await dbHelper.queryAllRows();
    expect(allRows.length, 0);
  });
}
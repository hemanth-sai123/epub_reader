import 'package:flutter/cupertino.dart';

import 'db_helper.dart';

class DBServices{

  final dbHelper = DatabaseHelper();

  DBServices(){

  }
  Future<DatabaseHelper> initState() async{
    await dbHelper.init();
    return dbHelper;
  }

  void insert(Map<String, dynamic> row) async {
    // row to insert

    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void query() async {
    final allRows = await dbHelper.queryAllRows();
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getDataById(String column,String id) async {
      return await dbHelper.getDataById(column,id);

  }

  void update() async {
    // row to update
    // Map<String, dynamic> row = {
    //   DatabaseHelper.columnId: 1,
    //   DatabaseHelper.columnName: 'Mary',
    //   DatabaseHelper.columnAge: 32
    // };
    // final rowsAffected = await dbHelper.update(row);
    // debugPrint('updated $rowsAffected row(s)');
  }

  void delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    debugPrint('deleted $rowsDeleted row(s): row $id');
  }
}
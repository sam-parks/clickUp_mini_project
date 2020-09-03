import 'package:sqflite/sqflite.dart';

class TaskDBProvider {
  final String taskTable = 'tasks';
  final String columnId = '_id';
  final String columnTitle = 'title';
  final String columnDone = 'done';

  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $taskTable ( 
  id integer primary key autoincrement, 
  $columnTitle text not null,
  $columnDone integer not null)
''');
    });
  }
}

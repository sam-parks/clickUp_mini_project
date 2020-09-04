import 'package:click_up_tasks/src/data/task.dart';
import 'package:sqflite/sqflite.dart';

class TaskDBProvider {
  final String taskTable = 'tasks';

  Database db;

  _onCreate(Database db, int version) async {
    await db.execute('''
create table $taskTable ( 
  id text primary key, 
  name text not null,
  status text not null,
  orderindex integer not null,
  date_created text not null,
  date_updated text not null,
  date_closed text)
''');
  }

  insertTasks(List<Task> tasks) async {
    for (Task task in tasks) {
      Map taskMap = task.toMapForDB();
      await db.insert(taskTable, taskMap);
    }
  }

  Future<List<Task>> retrieveTasks() async {
    List<Task> tasks = [];
    List<Map> taskMaps = await db.rawQuery('SELECT * FROM tasks');
    taskMaps.forEach((taskMap) {
      tasks.add(Task.fromDBMap(taskMap));
    });
    return tasks;
  }

  Future open(String path) async {
    db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }
}

final taskDBProvider = TaskDBProvider();

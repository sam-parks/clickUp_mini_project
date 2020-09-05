import 'package:click_up_tasks/src/data/task.dart';
import 'package:sqflite/sqflite.dart';

class TaskDBProvider {
  final String taskTable = 'tasks';

  Database db;

  _onCreate(Database db, int version) async {
    await db.execute('''
create table $taskTable ( 
  id text primary key,
  spaceID text not null, 
  folderID text not null, 
  clickUplistID text not null, 
  name text not null,
  status text not null,
  orderindex integer not null,
  date_created text not null,
  date_updated text not null,
  date_closed text)
''');
  }

  cleanDatabase() async {
    try {
      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete(taskTable);
        await batch.commit();
      });
    } catch (e) {
      throw Exception('DbBase.cleanDatabase: ' + e.toString());
    }
  }

  insertTasks(List<Task> tasks) async {
    for (Task task in tasks) {
      Map taskMap = task.toMapForDB();
      await db.insert(taskTable, taskMap);
    }
  }

  insertTask(Task task) async {
    await db.insert(taskTable, task.toMapForDB());
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

  deleteAllData() async {
    await deleteDatabase('clickUpTasks');
  }
}

final taskDBProvider = TaskDBProvider();

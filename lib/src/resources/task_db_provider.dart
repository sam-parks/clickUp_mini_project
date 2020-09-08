import 'package:click_up_tasks/src/data/clickup_list.dart';
import 'package:click_up_tasks/src/data/task.dart';
import 'package:sqflite/sqflite.dart';

class TaskDBProvider {
  final String taskTable = 'tasks';
  final String clickUpListTable = 'lists';
  final String folderTable = 'folders';

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

    await db.execute('''
create table $clickUpListTable ( 
  id text primary key,
  spaceID text not null,
  name text not null,
  orderindex integer not null)
''');

    await db.execute('''
create table $folderTable ( 
  id text primary key,
  spaceID text,
  name text not null)
''');
  }

  cleanDatabase() async {
    try {
      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete(taskTable);
        batch.delete(clickUpListTable);
        batch.delete(folderTable);
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

  insertClickUpLists(List<ClickupList> clickUpLists) async {
    for (ClickupList clickupList in clickUpLists) {
      Map clickupListMap = clickupList.toMapForDB();
      await db.insert(clickUpListTable, clickupListMap);
    }
  }

  insertFolders(List<Folder> folders) async {
    for (Folder folder in folders) {
      Map folderMap = folder.toMapForDB();
      await db.insert(folderTable, folderMap);
    }
  }

  insertTask(Task task) async {
    await db.insert(taskTable, task.toMapForDB());
  }

  deleteTask(String taskId) async {
    await db.delete(taskTable, where: 'id = ?', whereArgs: [taskId]);
  }

  Future<List<Task>> retrieveAllTasks() async {
    List<Task> tasks = [];
    List<Map> taskMaps = await db.rawQuery('SELECT * FROM tasks');
    taskMaps.forEach((taskMap) {
      tasks.add(Task.fromDBMap(taskMap));
    });
    return tasks;
  }

  Future<Map> retrieveItemsForSpace(String spaceID) async {
    List<Task> tasks = [];
    List<ClickupList> clickupLists = [];
    List<Folder> folders = [];
    List<Map> taskMaps =
        await db.rawQuery('SELECT * FROM tasks WHERE spaceID = $spaceID');
    taskMaps.forEach((taskMap) {
      tasks.add(Task.fromDBMap(taskMap));
    });

    List<Map> clickupListMaps =
        await db.rawQuery('SELECT * FROM lists WHERE spaceID = $spaceID');
    clickupListMaps.forEach((clickupListMap) {
      clickupLists.add(ClickupList.fromDBMap(clickupListMap));
    });

    List<Map> folderMaps =
        await db.rawQuery('SELECT * FROM folders WHERE spaceID = $spaceID');
    folderMaps.forEach((folderMap) {
      folders.add(Folder.fromJson(folderMap));
    });

    return {'folders': folders, 'clickUpLists': clickupLists, 'tasks': tasks};
  }

  Future open(String path) async {
    db = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  deleteAllData() async {
    await deleteDatabase('clickUpTasks');
  }
}

final taskDBProvider = TaskDBProvider();

import 'package:click_up_tasks/src/data/task.dart';
import 'package:dio/dio.dart';

class ClickUpService {
  ClickUpService(this._apiToken);

  String _apiToken;
  static const String _clickUpUrl = "https://api.clickup.com/api/v2";

  Future<Task> createTask(Task task, String listID) async {
    try {
      Response response = await Dio().post("$_clickUpUrl/list/$listID/task",
          data: task.toJson(),
          options: Options(
            headers: {
              'Authorization': _apiToken,
              'Content-Type': 'application/json',
            },
          ));

      return Task.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<ClickUpList> createClickupList(
      ClickUpList clickUpList, String folderID) async {
    try {
      Response response = await Dio().post("$_clickUpUrl/list/$folderID/task",
          data: clickUpList.toJson(),
          options: Options(
            headers: {
              'Authorization': _apiToken,
              'Content-Type': 'application/json',
            },
          ));

      return ClickUpList.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<List<Task>> getTasks(String listID) async {
    try {
      List<Task> tasks = [];
      Response response = await Dio().get("$_clickUpUrl/list/$listID/task",
          options: Options(
            headers: {
              'Authorization': _apiToken,
              'Content-Type': 'application/json',
            },
          ));

      List<Map<String, dynamic>> taskMaps = List.castFrom(response.data);

      taskMaps.forEach((taskMap) {
        tasks.add(Task.fromJson(taskMap));
      });

      return tasks;
    } catch (e) {
      throw e;
    }
  }

  Future<List<ClickUpList>> getLists(String folderID) async {
    try {
      List<ClickUpList> clickupLists = [];
      Response response = await Dio().get("$_clickUpUrl/list/$folderID/list",
          options: Options(
            headers: {
              'Authorization': _apiToken,
              'Content-Type': 'application/json',
            },
          ));

      List<Map<String, dynamic>> clickUpListMaps = List.castFrom(response.data);

      clickUpListMaps.forEach((clickUpListMap) {
        clickupLists.add(ClickUpList.fromJson(clickUpListMap));
      });

      return clickupLists;
    } catch (e) {
      throw e;
    }
  }
}

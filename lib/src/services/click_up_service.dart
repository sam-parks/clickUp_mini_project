import 'dart:convert';

import 'package:click_up_tasks/src/data/clickup_list.dart';
import 'package:click_up_tasks/src/data/models/teams_model.dart';
import 'package:click_up_tasks/src/data/space.dart';
import 'package:click_up_tasks/src/data/task.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ClickUpService {
  ClickUpService(this._apiToken) {
    dio = Dio();
    (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  }

  String _apiToken;
  Dio dio;
  static const String _clickUpUrl = "https://api.clickup.com/api/v2";

  Future<List<Task>> getAllTasksForTeam(String teamID) async {
    List<Space> teamSpaces = await getSpacesForTeam(teamID);
    List<Folder> teamFolders = [];
    List<ClickupList> teamClickupLists = [];
    List<Task> teamTasks = [];

    for (Space space in teamSpaces) {
      List<Folder> folders = await getFoldersForSpace(space.id);
      teamFolders.addAll(folders);
    }

    for (Folder folder in teamFolders) {
      List<ClickupList> clickupLists = await getListsForFolder(folder.id);
      teamClickupLists.addAll(clickupLists);
    }

    for (ClickupList clickupList in teamClickupLists) {
      List<Task> tasks = await getTasksForList(clickupList.id);
      teamTasks.addAll(tasks);
    }

    return teamTasks;
  }

  Future<Map> getAllItemsForSpace(String spaceID) async {
    List<Folder> spaceFolders = [];
    List<ClickupList> spaceClickupLists = [];
    List<Task> spaceTasks = [];

    spaceFolders = await getFoldersForSpace(spaceID);

    for (Folder folder in spaceFolders) {
      List<ClickupList> clickupLists = await getListsForFolder(folder.id);
      spaceClickupLists.addAll(clickupLists);
    }

    for (ClickupList clickupList in spaceClickupLists) {
      List<Task> tasks = await getTasksForList(clickupList.id);
      spaceTasks.addAll(tasks);
    }

    return {
      'folders': spaceFolders,
      'clickUpLists': spaceClickupLists,
      'tasks': spaceTasks
    };
  }

  Future<Task> createTask(Task task, String listID) async {
    try {
      Response response = await dio.post("$_clickUpUrl/list/$listID/task",
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

  Future<bool> deleteTask(String taskID) async {
    try {
      Response response = await dio.delete("$_clickUpUrl/task/$taskID",
          options: Options(
            headers: {
              'Authorization': _apiToken,
              'Content-Type': 'application/json',
            },
          ));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<ClickupList> createClickupList(
      ClickupList clickUpList, String folderID) async {
    try {
      Response response = await dio.post("$_clickUpUrl/list/$folderID/task",
          data: clickUpList.toJson(),
          options: Options(
            headers: {
              'Authorization': _apiToken,
              'Content-Type': 'application/json',
            },
          ));

      return ClickupList.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<List<Team>> getTeams() async {
    try {
      List<Team> teams = [];
      Response response = await dio.get("$_clickUpUrl/team",
          options: Options(
            headers: {
              'Authorization': _apiToken,
              'Content-Type': 'application/json',
            },
          ));

      List<Map<dynamic, dynamic>> teamMaps =
          List.castFrom(response.data['teams']);

      for (var teamMap in teamMaps) {
        teams.add(Team.fromJson(teamMap));
      }

      return teams;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<List<Space>> getSpacesForTeam(String teamID) async {
    try {
      List<Space> spaces = [];
      Response response = await dio.get("$_clickUpUrl/team/$teamID/space",
          options: Options(
            headers: {
              'Authorization': _apiToken,
              'Content-Type': 'application/json',
            },
          ));

      List<Map<String, dynamic>> spaceMaps =
          List.castFrom(response.data['spaces']);

      spaceMaps.forEach((spaceMap) {
        spaces.add(Space.fromJson(spaceMap));
      });

      return spaces;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Task>> getTasksForList(String listID) async {
    try {
      List<Task> tasks = [];
      Response response = await dio.get("$_clickUpUrl/list/$listID/task",
          options: Options(
            headers: {
              'Authorization': _apiToken,
              'Content-Type': 'application/json',
            },
          ));

      List<Map<String, dynamic>> taskMaps =
          List.castFrom(response.data['tasks']);

      taskMaps.forEach((taskMap) {
        tasks.add(Task.fromJson(taskMap));
      });

      return tasks;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Folder>> getFoldersForSpace(String spaceID) async {
    try {
      List<Folder> folders = [];
      Response response = await dio.get("$_clickUpUrl/space/$spaceID/folder",
          options: Options(
            headers: {
              'Authorization': _apiToken,
              'Content-Type': 'application/json',
            },
          ));

      List<Map<String, dynamic>> folderMaps =
          List.castFrom(response.data['folders']);

      folderMaps.forEach((folderMap) {
        folders.add(Folder.fromJson(folderMap));
      });

      return folders;
    } catch (e) {
      throw e;
    }
  }

  Future<List<ClickupList>> getListsForFolder(String folderID) async {
    try {
      List<ClickupList> clickupLists = [];
      Response response = await dio.get("$_clickUpUrl/folder/$folderID/list",
          options: Options(
            headers: {
              'Authorization': _apiToken,
              'Content-Type': 'application/json',
            },
          ));

      List<Map<String, dynamic>> clickUpListMaps =
          List.castFrom(response.data['lists']);

      clickUpListMaps.forEach((clickUpListMap) {
        clickupLists.add(ClickupList.fromJson(clickUpListMap));
      });
      return clickupLists;
    } catch (e) {
      throw e;
    }
  }
}

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

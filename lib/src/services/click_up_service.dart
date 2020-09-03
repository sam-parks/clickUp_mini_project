import 'package:click_up_tasks/src/data/task.dart';
import 'package:dio/dio.dart';

class ClickUpService {
  ClickUpService(this._apiKey);

  String _apiKey;
  static const String _clickUpUrl = "https://api.clickup.com/api/v2";

  Future<Task> createTask(Task task, String listID) async {
    try {
      Response response = await Dio().post("$_clickUpUrl/list/$listID/task",
          data: task.toJson(),
          options: Options(
            headers: {
              'Authorization': _apiKey,
              'Content-Type': 'application/json',
            },
          ));

      return Task.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}

import 'package:flutter/material.dart';

class TeamsModel extends ChangeNotifier {
  List<Team> _teams;

  List<Team> get teams => _teams;

  updateTeams(List<Team> teams) {
    _teams = teams;
    notifyListeners();
  }
}

class Team {
  String id;
  String name;
  String color;
  dynamic avatar;
  List<Members> members;

  Team({this.id, this.name, this.color, this.avatar, this.members});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    avatar = json['avatar'];
    if (json['members'] != null) {
      members = new List<Members>();
      json['members'].forEach((v) {
        members.add(new Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['avatar'] = this.avatar;
    if (this.members != null) {
      data['members'] = this.members.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  User user;

  Members({this.user});

  Members.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String username;
  String email;
  String color;
  String profilePicture;
  String initials;
  int role;

  User(
      {this.id,
      this.username,
      this.email,
      this.color,
      this.profilePicture,
      this.initials,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    color = json['color'];
    profilePicture = json['profilePicture'];
    initials = json['initials'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['color'] = this.color;
    data['profilePicture'] = this.profilePicture;
    data['initials'] = this.initials;
    data['role'] = this.role;
    return data;
  }
}

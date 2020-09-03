class Task {
  String id;
  String name;
  Status status;
  String orderindex;
  String dateCreated;
  String dateUpdated;
  dynamic dateClosed;
  Creator creator;
  List<dynamic> assignees;
  List<dynamic> checklists;
  List<dynamic> tags;
  dynamic parent;
  dynamic priority;
  dynamic dueDate;
  dynamic startDate;
  dynamic timeEstimate;
  dynamic timeSpent;
  ClickUpList clickUplist;
  Folder folder;
  Folder space;
  String url;

  Task(
      {this.id,
      this.name,
      this.status,
      this.orderindex,
      this.dateCreated,
      this.dateUpdated,
      this.dateClosed,
      this.creator,
      this.assignees,
      this.checklists,
      this.tags,
      this.parent,
      this.priority,
      this.dueDate,
      this.startDate,
      this.timeEstimate,
      this.timeSpent,
      this.clickUplist,
      this.folder,
      this.space,
      this.url});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    orderindex = json['orderindex'];
    dateCreated = json['date_created'];
    dateUpdated = json['date_updated'];
    dateClosed = json['date_closed'];
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    if (json['assignees'] != null) {
      assignees = new List<dynamic>();
      json['assignees'].forEach((v) {
        assignees.add(v);
      });
    }
    if (json['checklists'] != null) {
      checklists = new List<dynamic>();
      json['checklists'].forEach((v) {
        checklists.add(v);
      });
    }
    if (json['tags'] != null) {
      tags = new List();
      json['tags'].forEach((v) {
        tags.add(v);
      });
    }
    parent = json['parent'];
    priority = json['priority'];
    dueDate = json['due_date'];
    startDate = json['start_date'];
    timeEstimate = json['time_estimate'];
    timeSpent = json['time_spent'];
    clickUplist =
        json['list'] != null ? new ClickUpList.fromJson(json['list']) : null;
    folder =
        json['folder'] != null ? new Folder.fromJson(json['folder']) : null;
    space = json['space'] != null ? new Folder.fromJson(json['space']) : null;
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['orderindex'] = this.orderindex;
    data['date_created'] = this.dateCreated;
    data['date_updated'] = this.dateUpdated;
    data['date_closed'] = this.dateClosed;
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    if (this.assignees != null) {
      data['assignees'] = this.assignees.map((v) => v.toJson()).toList();
    }
    if (this.checklists != null) {
      data['checklists'] = this.checklists.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['parent'] = this.parent;
    data['priority'] = this.priority;
    data['due_date'] = this.dueDate;
    data['start_date'] = this.startDate;
    data['time_estimate'] = this.timeEstimate;
    data['time_spent'] = this.timeSpent;
    if (this.clickUplist != null) {
      data['list'] = this.clickUplist.toJson();
    }
    if (this.folder != null) {
      data['folder'] = this.folder.toJson();
    }
    if (this.space != null) {
      data['space'] = this.space.toJson();
    }
    data['url'] = this.url;
    return data;
  }
}

class Status {
  String status;
  String color;
  int orderindex;
  String type;

  Status({this.status, this.color, this.orderindex, this.type});

  Status.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    color = json['color'];
    orderindex = json['orderindex'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['color'] = this.color;
    data['orderindex'] = this.orderindex;
    data['type'] = this.type;
    return data;
  }
}

class Creator {
  int id;
  String username;
  String color;
  String profilePicture;

  Creator({this.id, this.username, this.color, this.profilePicture});

  Creator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    color = json['color'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['color'] = this.color;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}

class ClickUpList {
  String id;

  ClickUpList({this.id});

  ClickUpList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class Folder {
  String id;

  Folder({this.id});

  Folder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

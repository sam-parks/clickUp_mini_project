class ClickupList {
  String id;
  String name;
  int orderindex;
  String content;
  ListStatus status;
  Priority priority;
  dynamic assignee;
  dynamic taskCount;
  String dueDate;
  bool dueDateTime;
  dynamic startDate;
  dynamic startDateTime;
  Folder folder;
  ListSpace space;
  List<Statuses> statuses;
  String inboundAddress;

  ClickupList(
      {this.id,
      this.name,
      this.orderindex,
      this.content,
      this.status,
      this.priority,
      this.assignee,
      this.taskCount,
      this.dueDate,
      this.dueDateTime,
      this.startDate,
      this.startDateTime,
      this.folder,
      this.space,
      this.statuses,
      this.inboundAddress});

  ClickupList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    orderindex = json['orderindex'];
    content = json['content'];
    status =
        json['status'] != null ? new ListStatus.fromJson(json['status']) : null;
    priority = json['priority'] != null
        ? new Priority.fromJson(json['priority'])
        : null;
    assignee = json['assignee'];
    taskCount = json['task_count'];
    dueDate = json['due_date'];
    dueDateTime = json['due_date_time'];
    startDate = json['start_date'];
    startDateTime = json['start_date_time'];
    folder =
        json['folder'] != null ? new Folder.fromJson(json['folder']) : null;
    space = json['space'] != null ? new ListSpace.fromJson(json['space']) : null;
    if (json['statuses'] != null) {
      statuses = new List<Statuses>();
      json['statuses'].forEach((v) {
        statuses.add(new Statuses.fromJson(v));
      });
    }
    inboundAddress = json['inbound_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['orderindex'] = this.orderindex;
    data['content'] = this.content;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.priority != null) {
      data['priority'] = this.priority.toJson();
    }
    data['assignee'] = this.assignee;
    data['task_count'] = this.taskCount;
    data['due_date'] = this.dueDate;
    data['due_date_time'] = this.dueDateTime;
    data['start_date'] = this.startDate;
    data['start_date_time'] = this.startDateTime;
    if (this.folder != null) {
      data['folder'] = this.folder.toJson();
    }
    if (this.space != null) {
      data['space'] = this.space.toJson();
    }
    if (this.statuses != null) {
      data['statuses'] = this.statuses.map((v) => v.toJson()).toList();
    }
    data['inbound_address'] = this.inboundAddress;
    return data;
  }
}

class ListStatus {
  String status;
  String color;
  bool hideLabel;

  ListStatus({this.status, this.color, this.hideLabel});

  ListStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    color = json['color'];
    hideLabel = json['hide_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['color'] = this.color;
    data['hide_label'] = this.hideLabel;
    return data;
  }
}

class Priority {
  String priority;
  String color;

  Priority({this.priority, this.color});

  Priority.fromJson(Map<String, dynamic> json) {
    priority = json['priority'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['priority'] = this.priority;
    data['color'] = this.color;
    return data;
  }
}

class Folder {
  String id;
  String name;
  bool hidden;
  bool access;

  Folder({this.id, this.name, this.hidden, this.access});

  Folder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    hidden = json['hidden'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['hidden'] = this.hidden;
    data['access'] = this.access;
    return data;
  }
}

class ListSpace {
  String id;
  String name;
  bool access;

  ListSpace({this.id, this.name, this.access});

  ListSpace.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['access'] = this.access;
    return data;
  }
}

class Statuses {
  String status;
  int orderindex;
  String color;
  String type;

  Statuses({this.status, this.orderindex, this.color, this.type});

  Statuses.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    orderindex = json['orderindex'];
    color = json['color'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['orderindex'] = this.orderindex;
    data['color'] = this.color;
    data['type'] = this.type;
    return data;
  }
}

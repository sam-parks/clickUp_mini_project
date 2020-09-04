class Space {
  String id;
  String name;
  bool private;
  List<SpaceStatuses> statuses;
  bool multipleAssignees;
  Features features;

  Space(
      {this.id,
      this.name,
      this.private,
      this.statuses,
      this.multipleAssignees,
      this.features});

  Space.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    private = json['private'];
    if (json['statuses'] != null) {
      statuses = new List<SpaceStatuses>();
      json['statuses'].forEach((v) {
        statuses.add(new SpaceStatuses.fromJson(v));
      });
    }
    multipleAssignees = json['multiple_assignees'];
    features = json['features'] != null
        ? new Features.fromJson(json['features'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['private'] = this.private;
    if (this.statuses != null) {
      data['statuses'] = this.statuses.map((v) => v.toJson()).toList();
    }
    data['multiple_assignees'] = this.multipleAssignees;
    if (this.features != null) {
      data['features'] = this.features.toJson();
    }
    return data;
  }
}

class SpaceStatuses {
  String status;
  String type;
  int orderindex;
  String color;

  SpaceStatuses({this.status, this.type, this.orderindex, this.color});

  SpaceStatuses.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    orderindex = json['orderindex'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    data['orderindex'] = this.orderindex;
    data['color'] = this.color;
    return data;
  }
}

class Features {
  DueDates dueDates;
  TimeTracking timeTracking;
  TimeTracking tags;
  TimeTracking timeEstimates;
  TimeTracking checklists;
  TimeTracking customFields;
  TimeTracking remapDependencies;
  TimeTracking dependencyWarning;
  TimeTracking portfolios;

  Features(
      {this.dueDates,
      this.timeTracking,
      this.tags,
      this.timeEstimates,
      this.checklists,
      this.customFields,
      this.remapDependencies,
      this.dependencyWarning,
      this.portfolios});

  Features.fromJson(Map<String, dynamic> json) {
    dueDates = json['due_dates'] != null
        ? new DueDates.fromJson(json['due_dates'])
        : null;
    timeTracking = json['time_tracking'] != null
        ? new TimeTracking.fromJson(json['time_tracking'])
        : null;
    tags =
        json['tags'] != null ? new TimeTracking.fromJson(json['tags']) : null;
    timeEstimates = json['time_estimates'] != null
        ? new TimeTracking.fromJson(json['time_estimates'])
        : null;
    checklists = json['checklists'] != null
        ? new TimeTracking.fromJson(json['checklists'])
        : null;
    customFields = json['custom_fields'] != null
        ? new TimeTracking.fromJson(json['custom_fields'])
        : null;
    remapDependencies = json['remap_dependencies'] != null
        ? new TimeTracking.fromJson(json['remap_dependencies'])
        : null;
    dependencyWarning = json['dependency_warning'] != null
        ? new TimeTracking.fromJson(json['dependency_warning'])
        : null;
    portfolios = json['portfolios'] != null
        ? new TimeTracking.fromJson(json['portfolios'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dueDates != null) {
      data['due_dates'] = this.dueDates.toJson();
    }
    if (this.timeTracking != null) {
      data['time_tracking'] = this.timeTracking.toJson();
    }
    if (this.tags != null) {
      data['tags'] = this.tags.toJson();
    }
    if (this.timeEstimates != null) {
      data['time_estimates'] = this.timeEstimates.toJson();
    }
    if (this.checklists != null) {
      data['checklists'] = this.checklists.toJson();
    }
    if (this.customFields != null) {
      data['custom_fields'] = this.customFields.toJson();
    }
    if (this.remapDependencies != null) {
      data['remap_dependencies'] = this.remapDependencies.toJson();
    }
    if (this.dependencyWarning != null) {
      data['dependency_warning'] = this.dependencyWarning.toJson();
    }
    if (this.portfolios != null) {
      data['portfolios'] = this.portfolios.toJson();
    }
    return data;
  }
}

class DueDates {
  bool enabled;
  bool startDate;
  bool remapDueDates;
  bool remapClosedDueDate;

  DueDates(
      {this.enabled,
      this.startDate,
      this.remapDueDates,
      this.remapClosedDueDate});

  DueDates.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    startDate = json['start_date'];
    remapDueDates = json['remap_due_dates'];
    remapClosedDueDate = json['remap_closed_due_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this.enabled;
    data['start_date'] = this.startDate;
    data['remap_due_dates'] = this.remapDueDates;
    data['remap_closed_due_date'] = this.remapClosedDueDate;
    return data;
  }
}

class TimeTracking {
  bool enabled;

  TimeTracking({this.enabled});

  TimeTracking.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this.enabled;
    return data;
  }
}

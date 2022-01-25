import 'dart:convert';

AllFeedback allFeedBackFromJson(String str) => AllFeedback.fromJson(json.decode(str));
class AllFeedback {
  String? message;
  List<NotSolve>? notSolve;
  String? result;
  List<Solved>? solved;

  AllFeedback({this.message, this.notSolve, this.result, this.solved});

  AllFeedback.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['not_solve'] != null) {
      notSolve = <NotSolve>[];
      json['not_solve'].forEach((v) {
        notSolve!.add(new NotSolve.fromJson(v));
      });
    }
    result = json['result'];
    if (json['solved'] != null) {
      solved = <Solved>[];
      json['solved'].forEach((v) {
        solved!.add(new Solved.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.notSolve != null) {
      data['not_solve'] = this.notSolve!.map((v) => v.toJson()).toList();
    }
    data['result'] = this.result;
    if (this.solved != null) {
      data['solved'] = this.solved!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotSolve {
  String? sId;
  String? content;
  String? dateCreatedVn;
  String? email;
  bool? hasResponse;
  String? name;
  String? status;

  NotSolve(
      {this.sId,
        this.content,
        this.dateCreatedVn,
        this.email,
        this.hasResponse,
        this.name,
        this.status});

  NotSolve.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    dateCreatedVn = json['date_created_vn'];
    email = json['email'];
    hasResponse = json['has_response'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['content'] = this.content;
    data['date_created_vn'] = this.dateCreatedVn;
    data['email'] = this.email;
    data['has_response'] = this.hasResponse;
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}

class Solved {
  String? sId;
  String? content;
  String? dateCreatedVn;
  String? email;
  bool? hasResponse;
  String? name;
  String? response;
  String? status;

  Solved(
      {this.sId,
        this.content,
        this.dateCreatedVn,
        this.email,
        this.hasResponse,
        this.name,
        this.response,
        this.status});

  Solved.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    dateCreatedVn = json['date_created_vn'];
    email = json['email'];
    hasResponse = json['has_response'];
    name = json['name'];
    response = json['response'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['content'] = this.content;
    data['date_created_vn'] = this.dateCreatedVn;
    data['email'] = this.email;
    data['has_response'] = this.hasResponse;
    data['name'] = this.name;
    data['response'] = this.response;
    data['status'] = this.status;
    return data;
  }
}
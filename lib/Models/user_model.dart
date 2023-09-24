class UserModel {
  bool? status;
  String? message;
  Data? data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  String? token;

  Data({this.user, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? deviceKey;
  List<Roles>? roles;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deviceKey,
      this.roles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deviceKey = json['device_key'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['device_key'] = this.deviceKey;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  String? displayName;
  String? description;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Roles(
      {this.id,
      this.name,
      this.displayName,
      this.description,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  String? userId;
  String? roleId;
  String? userType;

  Pivot({this.userId, this.roleId, this.userType});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    data['user_type'] = this.userType;
    return data;
  }
}

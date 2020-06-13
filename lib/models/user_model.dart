import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  String phone;
  String profilePicUrl;
  String userId;
  String deviceId;
  bool isOnline;
  List<dynamic> blocked;
  bool isAdmin;
  final DocumentReference reference;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.profilePicUrl,
    this.userId,
    this.isOnline = false,
    this.isAdmin,
    this.deviceId,
    this.reference,
  });

  UserModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : userId = map['userId'],
        name = map['name'],
        phone = map['phone'],
        email = map['email'],
        isAdmin = map['isAdmin'],
        blocked = map['blocked'] ?? List(),
        isOnline = map['is_online'] ?? false,
        profilePicUrl = map['profilePicUrl'];

  UserModel.fromJson(Map<String, dynamic> json, {this.reference})
      : userId = json['userId'],
        name = json['name'],
        phone = json['phone'],
        isOnline = json['is_online'] ?? false,
        isAdmin = json['isAdmin'],
        email = json['email'],
        profilePicUrl = json['profilePicUrl'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['userId'] = this.userId;
    data['name'] = this.name;
    data['isAdmin'] = this.isAdmin;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['profilePicUrl'] = this.profilePicUrl;
    return data;
  }

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => '${this.runtimeType}(${this.toJson()})';
}

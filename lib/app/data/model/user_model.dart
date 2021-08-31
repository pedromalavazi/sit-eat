import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sit_eat/app/data/model/enum/login_status_enum.dart';
import 'package:sit_eat/app/data/model/enum/login_type_enum.dart';

class UserModel {
  String id;
  String name;
  String email;
  String phoneNumber;
  String tokenMessage;
  String restaurantId;
  LoginType type;
  LoginStatus status;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.tokenMessage,
    this.restaurantId,
    this.type,
    this.status,
  });

  UserModel.fromSnapshot(DocumentSnapshot currentUser)
      : id = currentUser.id,
        name = currentUser.data()["name"],
        email = currentUser.data()["email"],
        phoneNumber = currentUser.data()["phoneNumber"],
        tokenMessage = currentUser.data()["tokenMessage"],
        type = LoginType.values
            .where((type) => type.toUpper == currentUser.data()["type"])
            .first,
        status = LoginStatus.values
            .where((status) => status.toUpper == currentUser.data()["status"])
            .first;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "tokenMessage": tokenMessage,
      "restaurantId": restaurantId,
      "type": type,
      "status": status
    };
  }
}

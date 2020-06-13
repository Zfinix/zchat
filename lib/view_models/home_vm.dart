import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zchat/models/user_model.dart';
import 'package:zchat/utils/base_auth.dart';

class HomeViewModel extends ChangeNotifier {
  BaseAuth auth = Auth();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel senderModel;

  UserModel _receiverModel;
  UserModel get receiverModel => _receiverModel;

  set receiverModel(UserModel val) {
    _receiverModel = val;
    notifyListeners();
  }

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Stream<QuerySnapshot> chatUsersFeed() =>
      Firestore.instance.collection('users').snapshots();

  String getChatId() {
    var t = BigInt.parse(senderModel.userId.runes.join(''));
    var t2 = BigInt.parse(_receiverModel.userId.runes.join(''));

    var chatId = t < t2
        ? "${senderModel.userId}${_receiverModel.userId}"
        : "${_receiverModel.userId}${senderModel.userId}";
    print(chatId);
    return chatId;
  }
}

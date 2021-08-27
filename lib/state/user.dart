import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:huofu/model/sksign.dart';
import 'package:huofu/model/userinfo.dart';
import 'package:huofu/model/zichan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserState extends ChangeNotifier {
  UserInfoModel? _userInfoModel;
  SharedPreferences? prefs;
  SKSignModel? skSignModel;

  UserState() {
    SharedPreferences.getInstance().then((value) async {
      try {
        prefs = value;
        String token = (prefs?.get('token') ?? "").toString();
        this.userInfo = UserInfoModel.fromJson(
            JsonDecoder().convert((prefs?.get('userInfo') ?? "").toString()));
        notifyListeners();
      } catch (error) {
        print(error);
      }
    });
  }

  bool get isLogin {
    return this.userInfo != null;
  }

  UserInfoModel? get userInfo {
    return this._userInfoModel;
  }

  set userInfo(UserInfoModel? userInfo) {
    this._userInfoModel = userInfo;
  }

  set skSign(SKSignModel model) {
    skSignModel = model;
    notifyListeners();
  }

  void save() async {
    await prefs?.setString(
        'userInfo', JsonEncoder().convert(userInfo?.toJson()));
  }

  void login(UserInfoModel userInfo) {
    this.userInfo = userInfo;
    save();
    notifyListeners();
  }

  void logout() {
    this.userInfo = null;
    save();
    notifyListeners();
  }
}

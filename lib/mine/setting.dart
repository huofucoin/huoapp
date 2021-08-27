import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/mine/emailVerify.dart';
import 'package:huofu/mine/paymentPassword.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/mine/mobileVerify.dart';
import 'package:huofu/mine/passwordReset.dart';
import 'package:huofu/state/user.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  @override
  SettingState createState() => SettingState();
}

class SettingState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('安全设置'),
        leading: IBackIcon(left: 16),
      ),
      body: Consumer<UserState>(
        builder: (_, userInfo, __) {
          return Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 8,
                            spreadRadius: 0,
                            color: Color(0x21C7C3D0))
                      ]),
                  child: Column(
                    children: [
                      settingItem('登录密码', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return PasswordReset();
                        }));
                      }),
                      Container(
                        height: 1,
                        color: Color(0xFFF6F6F6),
                      ),
                      settingItem('资金密码', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return PaymentPassword();
                        }));
                      }),
                    ],
                  ),
                ),
                Container(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 8,
                            spreadRadius: 0,
                            color: Color(0x21C7C3D0))
                      ]),
                  child: Column(
                    children: [
                      settingItem('手机验证', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return MobileVerify();
                        }));
                      }, subTitle: userInfo.userInfo?.mobile ?? ''),
                      settingItem('邮箱验证', () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return EmailVerify();
                        }));
                      }, subTitle: userInfo.userInfo?.emails ?? '')
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

settingItem(String title, GestureTapCallback onTap, {String subTitle = ''}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 54,
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: TextStyle(
              color: Color(0xFF313333),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          )),
          subTitle.length == 0
              ? Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFFD2D2D2),
                )
              : Text(subTitle.split('').asMap().keys.map((e) {
                  List<String> arr = subTitle.split('');
                  int at = arr.indexOf('@');
                  if (e > 2 && e < (at >= 0 ? at : 7)) {
                    return '*';
                  } else {
                    return arr[e];
                  }
                }).join(''))
        ],
      ),
    ),
  );
}

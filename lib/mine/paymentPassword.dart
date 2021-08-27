import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/ITextField.dart';
import 'package:huofu/api/getcode.dart';
import 'package:huofu/api/zjpasswordis.dart';
import 'package:huofu/api/zjpasswordset.dart';
import 'package:huofu/api/zjpasswordupdate.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/state/user.dart';
import 'package:provider/provider.dart';

class PaymentPassword extends StatefulWidget {
  @override
  PaymentPasswordState createState() => PaymentPasswordState();
}

class PaymentPasswordState extends State<PaymentPassword> {
  bool send = false;
  int time = 60;

  String vcode = '';
  String password = '';
  String passwordVerify = '';

  bool iszjpassword = false;
  @override
  void initState() {
    super.initState();
    zjpasswordis().then((value) {
      setState(() {
        iszjpassword = value.zjpassword == 'y';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(iszjpassword ? '修改资金密码' : '设置资金密码'),
        leading: IBackIcon(left: 16),
      ),
      body: Consumer<UserState>(
        builder: (_, userInfo, __) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(32, 20, 32, 20),
            child: Column(
              children: [
                ITextFiled(
                  labelText: iszjpassword ? '请输入新资金密码' : '请输入资金密码',
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  fieldCallBack: (context) {
                    setState(() {
                      password = context;
                    });
                  },
                ),
                Container(
                  height: 16,
                ),
                ITextFiled(
                  labelText: '请确认资金密码',
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  fieldCallBack: (context) {
                    setState(() {
                      passwordVerify = context;
                    });
                  },
                ),
                Container(
                  height: 16,
                ),
                ITextFiled(
                  labelText: '请输入验证码',
                  fieldCallBack: (context) {
                    vcode = context;
                  },
                  suffix: GestureDetector(
                    onTap: () async {
                      if (!send || (send && time == 0)) {
                        try {
                          loading();
                          var body = await getcode(
                              userInfo.userInfo?.mobile ??
                                  userInfo.userInfo?.emails ??
                                  "",
                              iszjpassword ? '5' : '4',
                              userInfo.userInfo?.mobile != null);
                          ToastManager().dismissAll(showAnim: true);
                          if (body['code'] == 0) {
                            setState(() {
                              send = true;
                              time = 60;
                            });
                            Timer.periodic(Duration(seconds: 1), (timer) {
                              if (mounted) {
                                setState(() {
                                  time -= 1;
                                  if (time == 0) {
                                    timer.cancel();
                                  }
                                });
                              } else {
                                timer.cancel();
                              }
                            });
                          } else {
                            setState(() {
                              send = true;
                              time = 0;
                            });
                            toast(body['msg']);
                          }
                        } catch (error) {
                          setState(() {
                            time = 0;
                          });
                          toast(error.toString());
                        }
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 1,
                          height: 26,
                          color: Color(0xFFDDDDDD),
                        ),
                        Container(
                          width: 100,
                          child: Center(
                            child: Text(
                              send && time > 0
                                  ? '(' + time.toString() + 's)'
                                  : '发送验证码',
                              style: TextStyle(
                                color: Color(0xFF602FDA),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                IButton2(
                  labelText: '提交',
                  enable: password.length > 0 &&
                      passwordVerify.length > 0 &&
                      vcode.length > 0,
                  fieldCallBack: () async {
                    try {
                      loading();
                      var data;
                      if (iszjpassword) {
                        data = await updatezjpassword(
                            password, vcode, userInfo.userInfo?.mobile != null);
                      } else {
                        data = await setzjpassword(
                            password, vcode, userInfo.userInfo?.mobile != null);
                      }
                      print(data);
                      toast(data['msg']);
                      if (data['code'] == 0) {
                        print('提交成功');
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      toast(e.toString());
                    }
                  },
                ),
                Container(
                  height: 16,
                ),
                Center(
                  child: Text(
                    '资金密码用于法币交易时的验证',
                    style: TextStyle(
                      color: Color(0xFF9C9EA6),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

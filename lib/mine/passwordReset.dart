import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/ITextField.dart';
import 'package:huofu/api/getcode.dart';
import 'package:huofu/api/updatepassword.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/state/user.dart';
import 'package:provider/provider.dart';

class PasswordReset extends StatefulWidget {
  @override
  PasswordResetState createState() => PasswordResetState();
}

class PasswordResetState extends State {
  int type = 1;

  bool send = false;
  int time = 60;

  String oldpassword = '';
  String vcode = '';
  String password = '';
  String passwordVerify = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('修改登录密码'),
        leading: IBackIcon(left: 16),
      ),
      body: Consumer<UserState>(builder: (_, userInfo, __) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.white,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 90),
                child: Column(
                  children: [
                    ITextFiled(
                      labelText: '请输入原密码',
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      fieldCallBack: (context) {
                        setState(() {
                          oldpassword = context;
                        });
                      },
                    ),
                    Container(
                      height: 16,
                    ),
                    ITextFiled(
                      labelText: '请输入新密码',
                      obscureText: true,
                      keyboardType: TextInputType.text,
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
                      labelText: '请确认密码',
                      obscureText: true,
                      keyboardType: TextInputType.text,
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
                        setState(() {
                          vcode = context;
                        });
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
                                  '3',
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
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: IButton2(
                labelText: '提交',
                enable: oldpassword.length > 0 &&
                    password.length > 0 &&
                    passwordVerify.length > 0 &&
                    vcode.length > 0,
                fieldCallBack: () async {
                  try {
                    loading();
                    var data = await updatepassword(oldpassword, password,
                        vcode, userInfo.userInfo?.mobile != null);
                    print(data);
                    ToastManager().dismissAll(showAnim: true);
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
            )
          ],
        );
      }),
    );
  }
}

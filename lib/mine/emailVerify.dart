import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/ITextField.dart';
import 'package:huofu/api/emailcheck.dart';
import 'package:huofu/api/getcode.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/model/response.dart';

class EmailVerify extends StatefulWidget {
  @override
  EmailVerifyState createState() => EmailVerifyState();
}

class EmailVerifyState extends State {
  String username = '';
  String vcode = '';

  bool send = false;
  int time = 60;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('邮箱验证'),
          leading: IBackIcon(left: 16),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            children: [
              ITextFiled(
                labelText: '请输入邮箱',
                shadow: 'grey',
                keyboardType: TextInputType.emailAddress,
                fieldCallBack: (context) {
                  setState(() {
                    username = context;
                  });
                },
              ),
              Container(
                height: 16,
              ),
              ITextFiled(
                labelText: '请输入验证码',
                shadow: 'grey',
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
                        var body = await getcode(username, '6', false);
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
                enable: username.length > 0 && vcode.length > 0,
                fieldCallBack: () async {
                  try {
                    loading();
                    ResponseModel data = await emailcheck(username, vcode);
                    toast(data.msg);
                    if (data.code == 0) {
                      print('验证成功');
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    toast(e.toString());
                  }
                },
              ),
            ],
          ),
        ));
  }
}

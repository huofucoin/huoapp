import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/ITextField.dart';
import 'package:huofu/api/getcode.dart';
import 'package:huofu/api/register.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/userinfo.dart';

class RegisterVerify extends StatefulWidget {
  final String username;
  final String password;
  final bool isMobile;
  const RegisterVerify(this.username, this.password,
      {Key? key, this.isMobile = true})
      : super(key: key);
  @override
  RegisterVerifyState createState() => RegisterVerifyState();
}

class RegisterVerifyState extends State<RegisterVerify> {
  bool select = false;

  bool send = false;
  int time = 60;

  String vcode = '';
  String parentcodes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IBackIcon(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(32, 20, 32, 58),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '安全验证',
                    style: TextStyle(
                      color: Color(0xFF0D1333),
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 80, 0, 24),
                    child: ITextFiled(
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
                                  widget.username, '1', widget.isMobile);
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
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 48),
                    child: ITextFiled(
                      labelText: '请输入邀请码（选填）',
                      fieldCallBack: (context) {
                        setState(() {
                          parentcodes = context;
                        });
                      },
                    ),
                  ),
                  IButton2(
                    fieldCallBack: () async {
                      if (!select) {
                        toast('请阅读并同意火夫的《用户协议》');
                        return;
                      }
                      if (vcode.length == 0) {
                        toast('请输入验证码');
                        return;
                      }
                      try {
                        loading();
                        ResponseModel<UserInfoModel> body = await register(
                            widget.username,
                            widget.password,
                            vcode,
                            parentcodes,
                            widget.isMobile);
                        toast(body.code == 0 ? '注册成功' : body.msg);
                        if (body.code == 0) {
                          print(body);
                          Navigator.of(context).popUntil((route) {
                            return route.settings.name == '/';
                          });
                        }
                      } catch (error) {
                        toast(error.toString());
                      }
                    },
                    enable: vcode.length > 0,
                    labelText: '注册',
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      select = !select;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              select
                                  ? BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                      color: Color(0x36602FDA),
                                    )
                                  : BoxShadow(
                                      color: Color.fromARGB(54, 155, 150, 167),
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                      spreadRadius: 0)
                            ],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Image.asset(
                            select
                                ? 'images/selected@2x.png'
                                : 'images/select@2x.png',
                            width: 14,
                            height: 14,
                          )),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/agreement');
                  },
                  child: RichText(
                    text: TextSpan(
                      text: '阅读并同意火夫的',
                      style: TextStyle(
                        color: Color(0xFFACACAC),
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: '《用户协议》',
                          style: TextStyle(color: Color(0xFF602FDA)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

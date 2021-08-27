import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/ITextField.dart';
import 'package:huofu/api/getcode.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/state/user.dart';
import 'package:provider/provider.dart';

class PaymentVerify extends StatefulWidget {
  final int type;
  const PaymentVerify({required this.type, Key? key}) : super(key: key);
  @override
  PaymentVerifyState createState() => PaymentVerifyState();
}

class PaymentVerifyState extends State<PaymentVerify> {
  bool send = false;
  int time = 60;

  String vcode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IBackIcon(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<UserState>(
        builder: (_, userInfo, __) {
          return Container(
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
                    height: 32,
                  ),
                  Text(
                    '手机验证',
                    style: TextStyle(
                      color: Color(0xFF0D1333),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 48),
                    child: ITextFiled(
                      labelText: '请输入验证码',
                      fieldCallBack: (context) {
                        setState(() {
                          vcode = context;
                        });
                      },
                      suffix: GestureDetector(
                        onTap: () async {
                          if (widget.type < 7 || widget.type > 9) {
                            toast('未知认证类型');
                            return;
                          }
                          if (userInfo.userInfo?.mobile == null) {
                            toast('手机号码未认证');
                            return;
                          }
                          if (!send || (send && time == 0)) {
                            try {
                              loading();
                              var body = await getcode(
                                  userInfo.userInfo?.mobile ?? "",
                                  widget.type.toString(),
                                  true);
                              if (body['code'] == 0) {
                                ToastManager().dismissAll(showAnim: true);
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
                  IButton2(
                    fieldCallBack: () {
                      if (vcode.length == 0) {
                        toast('请输入验证码');
                        return;
                      }
                      Navigator.of(context).pop(vcode);
                    },
                    enable: vcode.length > 0,
                    labelText: '提交',
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/ITextField.dart';
import 'package:huofu/api/getcode.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton4.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/login/password2.dart';

class Password1 extends StatefulWidget {
  final String username;
  final bool isMobile;
  const Password1(this.username, {Key? key, this.isMobile = true})
      : super(key: key);
  @override
  Password1State createState() => Password1State();
}

class Password1State extends State<Password1> {
  bool send = false;
  int time = 60;

  String vcode = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IBackIcon(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(32, 20, 32, 20),
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
              height: 80,
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
                      var body =
                          await getcode(widget.username, '2', widget.isMobile);
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IButton4(
                    enable: vcode.length > 0,
                    fieldCallBack: () {
                      if (vcode.length == 0) {
                        toast('请输入验证码');
                        return;
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Password2(
                          widget.username,
                          vcode,
                          isMobile: widget.isMobile,
                        );
                      }));
                    },
                  )
                ],
              ),
              padding: EdgeInsets.fromLTRB(0, 48, 0, 0),
            )
          ],
        ),
      ),
    );
  }
}

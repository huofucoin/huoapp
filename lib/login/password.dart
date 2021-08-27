import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/ITextField.dart';
import 'package:huofu/countrySelect.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton4.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/login/password1.dart';
import 'package:huofu/security.dart';

class Password extends StatefulWidget {
  @override
  PasswordState createState() => PasswordState();
}

class PasswordState extends State {
  int type = 1;
  String prefix = '+86';
  String username = '';
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
                '忘记密码',
                style: TextStyle(
                  color: Color(0xFF0D1333),
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 32, 0, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: type == 1
                      ? [
                          Text(
                            '手机号',
                            style: TextStyle(
                              color: Color(0xFF313333),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                type = 2;
                              });
                            },
                            child: Text(
                              '邮箱',
                              style: TextStyle(
                                color: Color(0xFF602FDA),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ]
                      : [
                          Text(
                            '邮箱',
                            style: TextStyle(
                              color: Color(0xFF313333),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                type = 1;
                              });
                            },
                            child: Text(
                              '手机号',
                              style: TextStyle(
                                color: Color(0xFF602FDA),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                ),
              ),
              type == 1
                  ? ITextFiled(
                      labelText: '请输入手机号',
                      keyboardType: TextInputType.emailAddress,
                      prefix: CountrySelectBar(
                        prefix: prefix,
                        fieldCallBack: (context) {
                          setState(() {
                            prefix = context;
                          });
                        },
                      ),
                      fieldCallBack: (context) {
                        setState(() {
                          username = context;
                        });
                      },
                    )
                  : ITextFiled(
                      labelText: '请输入邮箱',
                      keyboardType: TextInputType.phone,
                      fieldCallBack: (context) {
                        setState(() {
                          username = context;
                        });
                      },
                    ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IButton4(
                      enable: username.length > 0,
                      fieldCallBack: () async {
                        if (username.length == 0) {
                          toast(type == 1 ? '请输入手机号' : '请输入邮箱');
                          return;
                        }
                        RegExp reg = new RegExp(r'^[0-9]*$');
                        if (type == 1 && !reg.hasMatch(username)) {
                          toast('请输入正确手机号');
                          return;
                        }
                        var checked = await Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                          return Security();
                        }));
                        if (checked != null && checked) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return Password1(
                              username,
                              isMobile: type == 1,
                            );
                          }));
                        }
                      },
                    )
                  ],
                ),
                padding: EdgeInsets.fromLTRB(0, 48, 0, 0),
              )
            ],
          ),
        ));
  }
}

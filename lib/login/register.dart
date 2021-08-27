import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huofu/iTextField.dart';
import 'package:huofu/countrySelect.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton4.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/reg.dart';
import 'package:huofu/login/registerVerify.dart';
import 'package:huofu/security.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State {
  int type = 1;
  String prefix = '+86';
  String username = '';
  String password = '';
  String passwordVerify = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IBackIcon(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(32, 20, 32, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '注册',
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
                            '手机号注册',
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
                                username = '';
                              });
                            },
                            child: Text(
                              '邮箱注册',
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
                            '邮箱注册',
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
                                username = '';
                              });
                            },
                            child: Text(
                              '手机号注册',
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
                      key: Key(type.toString()),
                      value: username,
                      labelText: '请输入手机号',
                      keyboardType: TextInputType.phone,
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
                      key: Key(type.toString()),
                      value: username,
                      labelText: '请输入邮箱',
                      keyboardType: TextInputType.emailAddress,
                      fieldCallBack: (context) {
                        setState(() {
                          username = context;
                        });
                      },
                    ),
              Container(
                height: 24,
              ),
              ITextFiled(
                labelText: '请输入密码',
                obscureText: true,
                fieldCallBack: (context) {
                  setState(() {
                    password = context;
                  });
                },
              ),
              Container(
                height: 24,
              ),
              ITextFiled(
                labelText: '请确认密码',
                obscureText: true,
                fieldCallBack: (context) {
                  setState(() {
                    passwordVerify = context;
                  });
                },
              ),
              Container(
                height: 16,
              ),
              Text(
                '注：密码为8--15位字母和数字的组合，且至少包含一位大写字母',
                style: TextStyle(
                  color: Color(0xFF5F6173),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 48, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: RichText(
                        text: TextSpan(
                            text: '已有火夫账号？',
                            style: TextStyle(
                              color: Color(0xFF9C9EA6),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: '登录',
                                style: TextStyle(
                                  color: Color(0xFF602FDA),
                                ),
                              )
                            ]),
                      ),
                    ),
                    IButton4(
                      enable: username.length > 0 &&
                          password.length > 0 &&
                          passwordVerify.length > 0,
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
                        if (!passwordCheck(password)) {
                          toast('8-15位字符，必须包含1位大写字母及1位数字');
                          return;
                        }
                        if (password.length == 0) {
                          toast('请输入密码');
                          return;
                        }
                        if (password != passwordVerify) {
                          toast('两次输入密码不一致');
                          return;
                        }
                        var checked = await Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                          return Security();
                        }));
                        if (checked != null && checked) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return RegisterVerify(
                              username,
                              password,
                              isMobile: type == 1,
                            );
                          }));
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:huofu/api/login.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/iTextField.dart';
import 'package:huofu/countrySelect.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/login/password.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/state/user.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State {
  int type = 1;
  String username = '';
  String prefix = '+86';
  String password = '';
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
        builder: (_, userInfo, __) => Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(32, 20, 32, 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '登录',
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
                              '手机号登录',
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
                                '邮箱登录',
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
                              '邮箱登录',
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
                                '手机号登录',
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
                  height: 48,
                ),
                IButton2(
                  labelText: '登录',
                  enable: password.length > 0 && username.length > 0,
                  fieldCallBack: () async {
                    if (username.length == 0) {
                      toast('请输入手机号');
                      return;
                    }
                    if (password.length == 0) {
                      toast('请输入密码');
                      return;
                    }
                    try {
                      loading();
                      ResponseModel data =
                          await login(username, password, type);
                      toast(data.code == 0 ? '登录成功' : data.msg);
                      if (data.code == 0) {
                        Navigator.of(context).popUntil((route) {
                          return route.settings.name == '/';
                        });
                      }
                    } catch (e) {
                      toast(e.toString());
                    }
                  },
                ),
                Container(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return Password();
                        }));
                      },
                      child: Text(
                        '忘记密码?',
                        style:
                            TextStyle(color: Color(0xFF602FDA), fontSize: 15),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        '立即注册',
                        style:
                            TextStyle(color: Color(0xFF602FDA), fontSize: 15),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

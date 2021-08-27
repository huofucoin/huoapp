import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/ITextField.dart';
import 'package:huofu/api/forgetpassword.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/loading.dart';

class Password2 extends StatefulWidget {
  final String username;
  final String vcode;
  final bool isMobile;
  const Password2(this.username, this.vcode, {Key? key, this.isMobile = true})
      : super(key: key);
  @override
  Password2State createState() => Password2State();
}

class Password2State extends State<Password2> {
  String password = '';
  String passwordVerify = '';
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
                  color: Color(0xFF7B7B7B),
                  fontSize: 12,
                ),
              ),
              Container(
                height: 80,
              ),
              IButton2(
                labelText: '确认重置',
                enable: password.length > 0 && passwordVerify.length > 0,
                fieldCallBack: () async {
                  if (password.length == 0) {
                    toast('请输入密码');
                    return;
                  }
                  if (password != passwordVerify) {
                    toast('两次输入密码不一致');
                    return;
                  }
                  try {
                    var data = await forgetpassword(widget.username, password,
                        widget.vcode, widget.isMobile);
                    print(data);
                    if (data['code'] == 0) {
                      toast('修改成功');
                      Navigator.of(context).popUntil((route) {
                        return route.settings.name == '/';
                      });
                    } else {
                      toast(data['msg']);
                    }
                  } catch (e) {
                    toast(e.toString());
                  }
                },
              )
            ],
          ),
        ));
  }
}

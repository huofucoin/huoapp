import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/ITextField.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton2.dart';

class OrderConfirm extends StatefulWidget {
  @override
  OrderConfirmState createState() => OrderConfirmState();
}

class OrderConfirmState extends State<OrderConfirm> {
  String vcode = '';
  String parentcodes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IBackIcon(
          left: 16,
        ),
        title: Text('安全验证'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
            color: Color(0xFFEDE6FF),
            child: Text(
              '请务必登录网上银行或第三方支付账号确认收到该笔款项。确认收到买家付款后，请及时点击【确认放币】，否则请勿点击。',
              style: TextStyle(
                color: Color(0xFF602FDA),
                fontSize: 13,
              ),
              strutStyle: StrutStyle(leading: 0.27),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 32, 16, 12),
            child: Text(
              '资金密码',
              style: TextStyle(
                color: Color(0xFF313333),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: ITextFiled(
              obscureText: true,
              labelText: '请输入资金密码',
              fieldCallBack: (context) {
                setState(() {
                  vcode = context;
                });
              },
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(16),
            child: IButton2(
              fieldCallBack: () async {
                if (vcode.length > 0) {
                  Navigator.of(context).pop(vcode);
                }
              },
              enable: vcode.length > 0,
              labelText: '确认放币',
            ),
          )
        ],
      ),
    );
  }
}

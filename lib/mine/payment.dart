import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/sksign.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/mine/alipay.dart';
import 'package:huofu/mine/bank.dart';
import 'package:huofu/mine/wechat.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Payment extends StatefulWidget {
  @override
  PaymentState createState() => PaymentState();
}

class PaymentState extends State {
  RefreshController _refreshController = RefreshController();
  bool bank = false;
  bool weixin = false;
  bool alipay = false;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    sksign().then((value) {
      setState(() {
        bank = value.sign?.bank == 'y';
        weixin = value.sign?.weixin == 'y';
        alipay = value.sign?.zfb == 'y';
      });
      _refreshController.refreshCompleted();
    }).catchError((error) {
      _refreshController.refreshFailed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收款方式'),
        leading: IBackIcon(left: 16),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: ListView(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: 0,
                      color: Color(0x21C7C3D0))
                ],
              ),
              child: Column(
                children: [
                  settingItem('银行卡', () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (_) {
                      return Bank();
                    }));
                    _onRefresh();
                  }, binded: bank, icon: Image.asset('images/bank@2x.png')),
                  Container(
                    height: 1,
                    color: Color(0xFFF6F6F6),
                  ),
                  settingItem('微信', () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (_) {
                      return WeChat();
                    }));
                    _onRefresh();
                  }, binded: weixin, icon: Image.asset('images/wechat@2x.png')),
                  Container(
                    height: 1,
                    color: Color(0xFFF6F6F6),
                  ),
                  settingItem('支付宝', () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (_) {
                      return Alipay();
                    }));
                    _onRefresh();
                  }, binded: alipay, icon: Image.asset('images/alipay@2x.png')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

settingItem(String title, GestureTapCallback onTap,
    {bool binded = false, Image? icon}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 54,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  margin: EdgeInsets.only(right: 8),
                  child: icon == null
                      ? Container(
                          width: 0,
                        )
                      : icon,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF0D1333),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          binded
              ? Text(
                  '已绑定',
                  style: TextStyle(
                    color: Color(0xFF9C9EA6),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : Text(
                  '未绑定',
                  style: TextStyle(
                    color: Color(0xFF602FDA),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(0xFFD2D2D2),
          )
        ],
      ),
    ),
  );
}

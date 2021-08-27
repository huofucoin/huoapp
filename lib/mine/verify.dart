import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/auth1detail.dart';
import 'package:huofu/api/auth2detail.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/mine/verify1.dart';
import 'package:huofu/mine/verify2.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Verify extends StatefulWidget {
  @override
  VerifyState createState() => VerifyState();
}

class VerifyState extends State {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int status1 = 0;
  int status2 = 0;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    Future.wait<dynamic>([auth1detail(), auth2detail()]).then((value) {
      setState(() {
        status1 = value[0].data?.status ?? 0;
        status2 = value[1].data?.status ?? 0;
      });
      _refreshController.refreshCompleted();
    }).catchError((error) {
      print(error);
      _refreshController.refreshFailed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('身份认证'),
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
                  ]),
              child: Column(
                children: [
                  settingItem('一级认证', 'OTC累计出售额度为500HFT，购买额度不限制',
                      status1 == 0 ? 4 : status1, () async {
                    if (status1 != 1) {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (_) {
                        return Verify1();
                      }));
                      _onRefresh();
                    }
                  }),
                  Container(
                    height: 1,
                    color: Color(0xFFF6F6F6),
                  ),
                  settingItem('二级认证', 'OTC出售额度不限制，购买额度不限制',
                      status1 == 2 ? (status2 == 0 ? 4 : status2) : 0,
                      () async {
                    if (status1 == 2 && status2 != 1) {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (_) {
                        return Verify2();
                      }));
                      _onRefresh();
                    }
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 1，审核中
// 2，已认证
// 3，认证失败
// 4，未认证，可认证
// 0，未认证，不可认证

settingItem(
    String title, String subTitle, int status, GestureTapCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                title,
                style: TextStyle(
                  color: Color(0xFF313333),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              )),
              statusItem(status)
            ],
          ),
          Container(
            height: 16,
          ),
          Row(
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.5),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFF0F0F0), Color(0xFFDDDDDD)]),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 3,
                      spreadRadius: 0,
                      color: Color(0x2B9B96A7),
                    ),
                  ],
                ),
              ),
              Container(
                width: 8,
              ),
              Expanded(
                  child: Text(
                subTitle,
                style: TextStyle(
                  color: Color(0xFF9C9EA6),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ))
            ],
          )
        ],
      ),
    ),
  );
}

statusItem(int status) {
  switch (status) {
    case 1:
      return Text(
        '审核中',
        style: TextStyle(
            color: Color(0xFFFF9200),
            fontSize: 13,
            fontWeight: FontWeight.w400),
      );
    case 3:
      return Row(
        children: [
          Text(
            '认证失败，请重新认证',
            style: TextStyle(
                color: Color(0xFFEF3280),
                fontSize: 13,
                fontWeight: FontWeight.w400),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(0xFFEF3280),
            size: 12,
          )
        ],
      );
    case 2:
      return Row(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            width: 22,
            height: 24,
            child: Image.asset('images/success@2x.png'),
          ),
          Container(
            width: 4,
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              '已认证',
              style: TextStyle(
                  color: Color(0xFF2ECEE0),
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      );
    case 4: // 两个都为0的情况
      return Row(
        children: [
          Text(
            '未认证',
            style: TextStyle(
                color: Color(0xFF602FDA),
                fontSize: 13,
                fontWeight: FontWeight.w400),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(0xFF602FDA),
            size: 12,
          )
        ],
      );
    case 0:
    default:
      return Text(
        '未认证',
        style: TextStyle(
            color: Color(0xFF5F6173),
            fontSize: 13,
            fontWeight: FontWeight.w400),
      );
  }
}

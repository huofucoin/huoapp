import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/sharesignup.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/model/sharesignup.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Share2 extends StatefulWidget {
  @override
  Share2State createState() => Share2State();
}

class Share2State extends State {
  RefreshController _refreshController = RefreshController();
  int page = 1;
  List<ShareSignupModel> shares = [];
  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    sharesignup(1).then((value) {
      setState(() {
        shares = value.data ?? [];
        page = 2;
      });
      if ((value.data ?? []).length == 10) {
        _refreshController.resetNoData();
      }
      _refreshController.refreshCompleted();
    }).catchError((error) {
      print(error);
      _refreshController.refreshFailed();
    });
  }

  void _onLoading() {
    sharesignup(page).then((value) {
      setState(() {
        shares.addAll(value.data ?? []);
      });
      if ((value.data ?? []).length < 10) {
        _refreshController.loadNoData();
      } else {
        setState(() {
          page = page + 1;
        });
        _refreshController.loadComplete();
      }
    }).catchError((error) {
      _refreshController.loadFailed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('邀请注册奖励'),
        leading: IBackIcon(left: 16),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: ClassicFooter(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
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
                  ...shares.asMap().keys.map((index) {
                    ShareSignupModel share = shares[index];
                    return settingItem(
                        share.title,
                        formatDate(share.createtime,
                            [mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
                        share.money,
                        index);
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

settingItem(String title, String subTitle, double count, int index) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 24, 0, 24),
    decoration: index > 0
        ? BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFFF6F6F6))))
        : null,
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xFF313333),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 2,
              ),
              Text(
                subTitle,
                style: TextStyle(
                  color: Color(0xFF5F6173),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, right: 10),
              child: Image.asset(
                'images/icon1@2x.png',
                width: 24,
                height: 32,
              ),
            ),
            Text(
              count.toString() + ' HFT',
              style: TextStyle(
                color: Color(0xFFFF9200),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        )
      ],
    ),
  );
}

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/signdetail.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/model/sign.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SignDetail extends StatefulWidget {
  @override
  _SignDetailState createState() => _SignDetailState();
}

class _SignDetailState extends State {
  RefreshController _refreshController = RefreshController();
  int page = 1;
  List<SignModel> items = [];
  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    signdetial(1).then((value) {
      setState(() {
        items = value.list ?? [];
        page = 2;
      });
      if ((value.list ?? []).length == 10) {
        _refreshController.resetNoData();
      }
      _refreshController.refreshCompleted();
    }).catchError((error) {
      _refreshController.refreshFailed();
    });
  }

  void _onLoading() {
    signdetial(page).then((value) {
      setState(() {
        items.addAll(value.list ?? []);
      });
      if ((value.list ?? []).length < 10) {
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
        title: Text('签到明细'),
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
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 8,
                    spreadRadius: 0,
                    color: Color(0x21C7C3D0),
                  )
                ]),
            child: Column(
              children: [
                ...items.asMap().keys.map((index) {
                  SignModel sign = items[index];
                  return Container(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    decoration: BoxDecoration(
                      border: index == 0
                          ? Border()
                          : Border(top: BorderSide(color: Color(0xFFF6F6F6))),
                    ),
                    child: Column(
                      children: [
                        _settingItem(
                            '签到',
                            formatDate(sign.createtime,
                                [mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
                            sign.money),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_settingItem(String title, String subTitle, double count) {
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF5F6173),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              height: 5,
            ),
            Text(
              subTitle,
              style: TextStyle(
                color: Color(0xFF9C9EA6),
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
            '+' + count.toString() + ' HFT',
            style: TextStyle(
              color: Color(0xFFFF9200),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      )
    ],
  );
}

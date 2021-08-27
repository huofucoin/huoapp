import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/sharetrade.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton.dart';
import 'package:huofu/model/sharesignup.dart';
import 'package:huofu/trade/kline.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Share3 extends StatefulWidget {
  @override
  Share3State createState() => Share3State();
}

class Share3State extends State {
  RefreshController _refreshController = RefreshController();
  int page = 1;
  int index = 4;
  List<ShareSignupModel> shares = [];
  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    sharetrade(index, 1).then((value) {
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
    sharetrade(index, page).then((value) {
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
        title: Text('交易收益明细'),
        leading: IBackIcon(left: 16),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                  child: PreferredSize(
                preferredSize: Size.fromHeight(90),
                child: Container(
                  color: Color(0xFFFAFAFA),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '返佣类型',
                            style: TextStyle(
                              color: Color(0xFF5F6173),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: IButton(
                              labelText: '直接奖励',
                              selected: index == 4,
                              fieldCallBack: (select) {
                                if (select) {
                                  setState(() {
                                    index = 4;
                                    _onRefresh();
                                  });
                                }
                              },
                            ),
                          ),
                          Container(
                            width: 16,
                          ),
                          Expanded(
                            child: IButton(
                              labelText: '间接奖励',
                              selected: index == 5,
                              fieldCallBack: (select) {
                                if (select) {
                                  setState(() {
                                    index = 5;
                                    _onRefresh();
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )),
            )
          ];
        },
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: ClassicFooter(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
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
                        share.coinname,
                        index);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

settingItem(
    String title, String subTitle, double count, String coinname, int index) {
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
            Text(
              count.toString() + ' ' + coinname,
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

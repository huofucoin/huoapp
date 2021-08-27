import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/shareincome.dart';
import 'package:huofu/api/shareoverview.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/mine/customTabIndicator.dart';
import 'package:huofu/model/shareoverview.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Share1 extends StatefulWidget {
  @override
  Share1State createState() => Share1State();
}

class Share1State extends State {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // bottom: TabBar(
          //   labelColor: Color(0xFF602FDA),
          //   unselectedLabelColor: Color(0xFF5F6173),
          //   labelStyle: TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.w500,
          //   ),
          //   unselectedLabelStyle: TextStyle(
          //     fontSize: 15,
          //     fontWeight: FontWeight.w400,
          //   ),
          //   indicator: CustomUnderlineTabIndicator(
          //       borderSide: BorderSide(color: Color(0xFF602FDA), width: 4.0)),
          //   tabs: [
          //     Tab(
          //       text: '邀请奖励好友明细',
          //     ),
          //     Tab(
          //       text: '邀请总览',
          //     )
          //   ],
          // ),
          title: Text('邀请总览'),
          leading: IBackIcon(left: 16),
        ),
        // body: TabBarView(
        //   children: [
        //     List1(),
        //     List2(),
        //   ],
        // ),
        body: List2(),
      ),
    );
  }
}

class List1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return List1State();
  }
}

class List1State extends State {
  RefreshController _refreshController = RefreshController();
  int count = 0;
  List<ShareOverviewModel> shares = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    shareincome(1).then((value) {
      setState(() {
        count = value.count ?? 0;
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
    shareincome(page).then((value) {
      setState(() {
        count = value.count ?? 0;
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
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: ClassicFooter(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Container(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Text(
              '累计已实名好友： ' + count.toString() + ' 人',
              style: TextStyle(
                color: Color(0xFF5F6173),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
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
                  ShareOverviewModel share = shares[index];
                  return settingItem(
                      share.username,
                      formatDate(share.createTime,
                          [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
                      '直接邀请',
                      index,
                      status: share.shiming);
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class List2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return List2State();
  }
}

class List2State extends State {
  int totalcount = 0;
  int zcount = 0;
  int jcount = 0;
  List<ShareOverviewModel> shares = [];
  RefreshController _refreshController = RefreshController();
  int page = 1;
  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    shareoverview(1).then((value) {
      setState(() {
        totalcount = value.totalcount ?? 0;
        zcount = value.zcount ?? 0;
        jcount = value.jcount ?? 0;
        shares = value.data ?? [];
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
    shareoverview(page).then((value) {
      setState(() {
        shares.addAll(value.data ?? []);
        zcount = value.zcount ?? 0;
        jcount = value.jcount ?? 0;
        shares = value.data ?? [];
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
    return SmartRefresher(
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
            padding: EdgeInsets.all(16),
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
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        totalcount.toString(),
                        style: TextStyle(
                          color: Color(0xFF313333),
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '累计邀请人数',
                        style: TextStyle(
                          color: Color(0xFF5F6173),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 27,
                  color: Color(0xFFF6F6F6),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        zcount.toString(),
                        style: TextStyle(
                          color: Color(0xFF313333),
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '直接邀请',
                        style: TextStyle(
                          color: Color(0xFF5F6173),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 27,
                  color: Color(0xFFF6F6F6),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        jcount.toString(),
                        style: TextStyle(
                          color: Color(0xFF313333),
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '间接邀请',
                        style: TextStyle(
                          color: Color(0xFF5F6173),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 16,
          ),
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
                  ShareOverviewModel share = shares[index];
                  return settingItem(
                      share.username,
                      formatDate(share.createTime,
                          [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
                      share.level == 1 ? '直接邀请' : '间接邀请',
                      index,
                      status: share.shiming);
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

settingItem(String title, String subTitle, String from, int index,
    {int status = 0}) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Color(0xFF0D1333),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  statusItem(status)
                ],
              ),
              Container(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '注册时间：' + subTitle,
                    style: TextStyle(
                      color: Color(0xFF5F6173),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    from,
                    style: TextStyle(
                      color: Color(0xFF5F6173),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

statusItem(int status) {
  switch (status) {
    case 1:
      return Text(
        '已实名',
        style: TextStyle(
            color: Color(0xFF5F6173),
            fontSize: 13,
            fontWeight: FontWeight.w400),
      );
    default:
      return Row(
        children: [
          Image.asset(
            'images/share_alert@2x.png',
            width: 12,
            height: 12,
          ),
          Container(
            width: 4,
          ),
          Text(
            '未实名',
            style: TextStyle(
                color: Color(0xFFEF3280),
                fontSize: 13,
                fontWeight: FontWeight.w400),
          )
        ],
      );
  }
}

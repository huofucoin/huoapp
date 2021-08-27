import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:huofu/api/announcement.dart';
import 'package:huofu/api/banner.dart';
import 'package:huofu/api/messageunread.dart';
import 'package:huofu/api/tradenow.dart';
import 'package:huofu/guide.dart';
import 'package:huofu/message.dart';
import 'package:huofu/messageDetail.dart';
import 'package:huofu/mine/help.dart';
import 'package:huofu/mine/updateAlert.dart';
import 'package:huofu/model/announcement.dart';
import 'package:huofu/model/banner.dart';
import 'package:huofu/model/response.dart' as Response;
import 'package:huofu/model/response1.dart';
import 'package:huofu/model/response2.dart' as Response2;
import 'package:huofu/order/order.dart';
import 'package:huofu/state/user.dart';
import 'package:huofu/tabControl.dart';
import 'package:huofu/trade/kline.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:huofu/api/version.dart';
import 'package:huofu/model/version.dart';

class Home extends StatefulWidget {
  final SwitchTabCallBack? callBack;

  const Home({this.callBack, Key? key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<AnnouncementModel> announcements = [];
  int messages = 0;
  List<BannerModel> banners = [];
  double nowprice = 0;
  String updown = '--';

  @override
  void initState() {
    super.initState();
    _onRefresh();
    _checkUpdate();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      SharedPreferences.getInstance().then((value) async {
        var guide = value.get('guide');
        if (guide != '1') {
          await Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Guide();
          }));
          await value.setString('guide', '1');
        }
      });
    });
  }

  void _checkUpdate() async {
    version().then((value) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      VersionModel? ver = value.version;
      if (ver != null) {
        if ((int.tryParse(ver.vercode) ?? 0) >
            (int.tryParse(packageInfo.buildNumber) ?? double.infinity)) {
          updateAlert(
              context, ver.appurl, ver.isforce == 2, ver.contents, ver.vername);
        }
      }
    });
  }

  void _onRefresh() async {
    Future.wait([messageunread(), announcement(), banner(), tradenow()])
        .then((value) {
      setState(() {
        messages = (value[0] as Response2.ResponseModel).count;
        announcements =
            (value[1] as ResponseModel<AnnouncementModel>).data ?? [];
        banners = (value[2] as ResponseModel<BannerModel>).data ?? [];
        nowprice = (value[3] as Response.ResponseModel).nowprice ?? 0;
        updown = (value[3] as Response.ResponseModel).updown ?? '--';
      });
      _refreshController.refreshCompleted();
    }).catchError((error) {
      _refreshController.refreshFailed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (_, userState, __) => Scaffold(
        appBar: AppBar(
          title: Text(
            '火夫',
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, userState.isLogin ? '/notice' : '/login');
              },
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      'images/message@2x.png',
                      width: 24,
                      height: 24,
                    ),
                    if (messages > 0)
                      Positioned(
                        right: -5,
                        child: Image.asset(
                          'images/reddot@2x.png',
                          width: 10,
                          height: 13,
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
        body: SmartRefresher(
          enablePullDown: true,
          header: WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 3,
                        spreadRadius: 0,
                        color: Color(0x21C7C3D0))
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: AspectRatio(
                        aspectRatio: 690 / 288,
                        child: Swiper(
                          autoplay: banners.length > 1,
                          loop: banners.length > 1,
                          itemBuilder: (context, index) {
                            BannerModel banner = banners[index];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                color: Color(0xFFFAFAFA),
                                child: Image.network(
                                  banner.urls,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          itemCount: banners.length,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Image.asset(
                            'images/notice@2x.png',
                            width: 24,
                            height: 24,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 8),
                              height: 20,
                              child: Swiper(
                                autoplay: announcements.length > 1,
                                loop: announcements.length > 1,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  var announce = announcements[index];
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return MessageDetail(
                                          model: announce,
                                        );
                                      }));
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            announce.title,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Color(0xFF5F6173),
                                              fontSize: 13,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemCount: announcements.length,
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return Message();
                              }));
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Image.asset(
                                'images/message_next@2x.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 3,
                        spreadRadius: 0,
                        color: Color(0x21C7C3D0))
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context,
                                  userState.isLogin ? '/innovation' : '/login');
                            },
                            behavior: HitTestBehavior.opaque,
                            child: AspectRatio(
                              aspectRatio: 334 / 180,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset('images/banner1@2x.png'),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 8,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (userState.isLogin) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return Order(
                                    buy: true,
                                    canPop: true,
                                  );
                                }));
                              } else {
                                Navigator.pushNamed(context, '/login');
                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child: AspectRatio(
                              aspectRatio: 334 / 180,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset('images/banner2@2x.png'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 8,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pushNamed(
                            context, userState.isLogin ? '/share' : '/login');
                      },
                      child: AspectRatio(
                        aspectRatio: 690 / 184,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset('images/banner4@2x.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 3,
                      spreadRadius: 0,
                      color: Color(0x21C7C3D0),
                    )
                  ],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return Help();
                        }));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '新手训练营',
                            style: TextStyle(
                              color: Color(0xFF0D1333),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Image.asset(
                            'images/message_next@2x.png',
                            width: 20,
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 8,
                            spreadRadius: 0,
                            color: Color(0x21C7C3D0),
                          )
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFA5F1FF), Color(0xFF0A3CC7)],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 17,
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'images/c@2x.png',
                                width: 30,
                                height: 30,
                              ),
                              Container(
                                height: 4,
                              ),
                              Text(
                                '了解火夫',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Image.asset(
                              'images/b@2x.png',
                              width: 26,
                              height: 12,
                            ),
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'images/d@2x.png',
                                width: 30,
                                height: 30,
                              ),
                              Container(
                                height: 4,
                              ),
                              Text(
                                '了解OTC',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Image.asset(
                              'images/b@2x.png',
                              width: 26,
                              height: 12,
                            ),
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'images/e@2x.png',
                                width: 30,
                                height: 30,
                              ),
                              Container(
                                height: 4,
                              ),
                              Text(
                                '了解币币',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(top: 5, bottom: 18, left: 4),
                            child: Image.asset(
                              'images/a@2x.png',
                              width: 70,
                              height: 72,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return KLine();
                  }));
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  margin: EdgeInsets.only(top: 16, bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 3,
                        spreadRadius: 0,
                        color: Color(0x21C7C3D0),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(),
                      1: IntrinsicColumnWidth(),
                      2: FlexColumnWidth()
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              '币对',
                              style: TextStyle(
                                color: Color(0xFFACACAC),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              '最新价',
                              style: TextStyle(
                                color: Color(0xFFACACAC),
                                fontSize: 13,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              '24H 涨跌',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFFACACAC),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Container(
                            height: 7,
                          ),
                          Container(
                            height: 7,
                          ),
                          Container(
                            height: 7,
                          )
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Text(
                              'HFC/HFT',
                              style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              nowprice > 0 ? nowprice.toString() : '--',
                              style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              updown.indexOf('-') == 0
                                  ? updown
                                  : ('+' + updown),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: updown.indexOf('-') == 0
                                    ? Color(0xFFEF3280)
                                    : Color(0xFF2ECEE0),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

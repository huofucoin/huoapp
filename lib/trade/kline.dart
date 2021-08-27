import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huofu/api/tradechengjiao.dart';
import 'package:huofu/api/tradekline.dart';
import 'package:huofu/api/tradeprice.dart';
import 'package:huofu/api/tradeup.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/mine/customTabIndicator.dart';
import 'package:huofu/model/kup.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/response1.dart' as ResponseList;
import 'package:huofu/model/tradechengjiao.dart';
import 'package:huofu/model/tradeprice.dart';
import 'package:huofu/trade/klineList1.dart';
import 'package:huofu/trade/klineList2.dart';
import 'package:huofu/trade/klineList3.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:k_chart/chart_style.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:k_chart/flutter_k_chart.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class KLine extends StatefulWidget {
  @override
  KLineState createState() => KLineState();
}

class KLineState extends State with SingleTickerProviderStateMixin {
  TabController? tabController;
  List<TradeChengjiaoModel> chengjiao = [];
  KupModel? kup;
  bool setting = false;
  bool moretime = false;

  List<KLineEntity>? datas;
  bool isChinese = true;
  bool _volHidden = false;
  MainState _mainState = MainState.MA;
  SecondaryState _secondaryState = SecondaryState.NONE;
  bool isLine = false;

  TradePriceModel? price;
  String time = '1m';

  ChartStyle chartStyle = new ChartStyle();
  ChartColors chartColors = new ChartColors();
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _reload(t: loading());
    });
  }

  void _reload({ToastFuture? t}) {
    Future.wait([tradekline(time), tradeprice(), tradechengjiao(), tradeup()])
        .then((value) {
      if (mounted) {
        DataUtil.calculate(
            (value[0] as ResponseList.ResponseModel<KLineEntity>).data ?? []);
        setState(() {
          datas = (value[0] as ResponseList.ResponseModel<KLineEntity>).data;
          price = (value[1] as ResponseModel<TradePriceModel>).data;
          chengjiao =
              (value[2] as ResponseList.ResponseModel<TradeChengjiaoModel>)
                      .data ??
                  [];
          kup = (value[3] as ResponseModel<KupModel>).data;
        });
        Timer(Duration(seconds: 3), () {
          _reload(t: t);
        });
      }
      if (t != null) t.dismiss(showAnim: true);
    }).catchError((error) {
      print(error);
      Timer(Duration(seconds: 3), () {
        _reload(t: t);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              brightness: Brightness.dark,
              pinned: true,
              title: Text(
                'HFC/HFT',
                style: TextStyle(color: Colors.white),
              ),
              leading: IBackIcon(
                left: 16,
                style: 'white',
              ),
              backgroundColor: Color(0xFF0D1333),
              actions: [
                // Image.asset(
                //   'images/fullscreen@2x.png',
                //   width: 24,
                //   height: 24,
                // )
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    color: Color(0xFF0D1333),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 45,
                                  child: Row(
                                    children: [
                                      Text(
                                        (kup?.newprice ?? 0).toStringAsFixed(6),
                                        style: TextStyle(
                                          color: Color(0xFF2ECEE0),
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  margin: EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        '≈' + (kup?.usdprice ?? '0') + ' USD ',
                                        style: TextStyle(
                                          color: Color(0xFF9C9EA6),
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        ((double.tryParse(kup?.rate ?? '0') ??
                                                        0) >
                                                    0
                                                ? '+'
                                                : '') +
                                            (double.tryParse(
                                                        kup?.rate ?? '0') ??
                                                    0)
                                                .toStringAsFixed(2) +
                                            '%',
                                        style: TextStyle(
                                          color: Color(0xFF2ECEE0),
                                          fontSize: 13,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: 20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '高',
                                          style: TextStyle(
                                            color: Color(0xFF9C9EA6),
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          (kup?.high ?? 0).toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '低',
                                          style: TextStyle(
                                            color: Color(0xFF9C9EA6),
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          (kup?.low ?? 0).toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '24H',
                                          style: TextStyle(
                                            color: Color(0xFF9C9EA6),
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          (kup?.volume ?? 0).toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 4,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  time = '1m';
                                  isLine = false;
                                  moretime = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  '1分',
                                  style: TextStyle(
                                    color: time == '1m' && !isLine
                                        ? Color(0xFFAF97EC)
                                        : Color(0xFF9C9EA6),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 16,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  time = '15m';
                                  isLine = false;
                                  moretime = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  '15分',
                                  style: TextStyle(
                                    color: time == '15m'
                                        ? Color(0xFFAF97EC)
                                        : Color(0xFF9C9EA6),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 16,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  time = '1h';
                                  isLine = false;
                                  moretime = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  '1时',
                                  style: TextStyle(
                                    color: time == '1h'
                                        ? Color(0xFFAF97EC)
                                        : Color(0xFF9C9EA6),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 16,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  time = '4h';
                                  isLine = false;
                                  moretime = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  '4时',
                                  style: TextStyle(
                                    color: time == '4h'
                                        ? Color(0xFFAF97EC)
                                        : Color(0xFF9C9EA6),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 16,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  time = '1d';
                                  isLine = false;
                                  moretime = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  '1日',
                                  style: TextStyle(
                                    color: time == '1d'
                                        ? Color(0xFFAF97EC)
                                        : Color(0xFF9C9EA6),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 16,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  time = '1w';
                                  isLine = false;
                                  moretime = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  '1周',
                                  style: TextStyle(
                                    color: time == '1w'
                                        ? Color(0xFFAF97EC)
                                        : Color(0xFF9C9EA6),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 16,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  moretime = !moretime;
                                  setting = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  ['15m', '1h', '4h', '1d', '1w']
                                              .indexOf(time) >=
                                          0
                                      ? '更多'
                                      : (isLine
                                          ? '分时'
                                          : time
                                              .replaceAll('m', '分')
                                              .replaceAll('h', '时')),
                                  style: TextStyle(
                                    color: ['15m', '1h', '4h', '1d', '1w']
                                                .indexOf(time) >=
                                            0
                                        ? Color(0xFF9C9EA6)
                                        : Color(0xFFAF97EC),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  setting = !setting;
                                  moretime = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 8, bottom: 8),
                                child: Text(
                                  '设置',
                                  style: TextStyle(
                                    color: Color(0xFFAF97EC),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 450,
                        child: KChartWidget(
                          datas,
                          chartStyle,
                          chartColors,
                          isLine: isLine,
                          mainState: _mainState,
                          volHidden: _volHidden,
                          secondaryState: _secondaryState,
                          fixedLength: 6,
                          timeFormat: TimeFormat.YEAR_MONTH_DAY_WITH_HOUR,
                          isChinese: isChinese,
                        ),
                      ),
                      if (setting)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            color: Color(0xFF0D1333),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '主图',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 16,
                                    bottom: 16,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            setState(() {
                                              _mainState = MainState.MA;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.white),
                                            ),
                                            padding: EdgeInsets.all(8),
                                            child: Center(
                                              child: Text(
                                                'MA',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            setState(() {
                                              _mainState = MainState.BOLL;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.white),
                                            ),
                                            padding: EdgeInsets.all(8),
                                            child: Center(
                                              child: Text(
                                                'BOLL',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Container(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 16,
                                ),
                                Text(
                                  '副图',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 16,
                                    bottom: 16,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            setState(() {
                                              _secondaryState =
                                                  SecondaryState.MACD;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.white),
                                            ),
                                            padding: EdgeInsets.all(8),
                                            child: Center(
                                              child: Text(
                                                'MACD',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            setState(() {
                                              _secondaryState =
                                                  SecondaryState.KDJ;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.white),
                                            ),
                                            padding: EdgeInsets.all(8),
                                            child: Center(
                                              child: Text(
                                                'KDJ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            setState(() {
                                              _secondaryState =
                                                  SecondaryState.RSI;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.white),
                                            ),
                                            padding: EdgeInsets.all(8),
                                            child: Center(
                                              child: Text(
                                                'RSI',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            setState(() {
                                              _secondaryState =
                                                  SecondaryState.WR;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.white),
                                            ),
                                            padding: EdgeInsets.all(8),
                                            child: Center(
                                              child: Text(
                                                'WR',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (moretime)
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(16),
                            color: Color(0xFF0D1333),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      setState(() {
                                        isLine = true;
                                        time = '1m';
                                        moretime = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: time == '1m' && isLine
                                                ? Color(0xFFAF97EC)
                                                : Colors.white),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Center(
                                        child: Text(
                                          '分时',
                                          style: TextStyle(
                                              color: time == '1m' && isLine
                                                  ? Color(0xFFAF97EC)
                                                  : Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 16,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      setState(() {
                                        isLine = false;
                                        time = '5m';
                                        moretime = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: time == '5m'
                                                ? Color(0xFFAF97EC)
                                                : Colors.white),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Center(
                                        child: Text('5分',
                                            style: TextStyle(
                                                color: time == '5m'
                                                    ? Color(0xFFAF97EC)
                                                    : Colors.white)),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 16,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      setState(() {
                                        isLine = false;
                                        time = '30m';
                                        moretime = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: time == '30m'
                                                ? Color(0xFFAF97EC)
                                                : Colors.white),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Center(
                                        child: Text(
                                          '30分',
                                          style: TextStyle(
                                              color: time == '30m'
                                                  ? Color(0xFFAF97EC)
                                                  : Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 16,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      setState(() {
                                        isLine = false;
                                        time = '6h';
                                        moretime = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: time == '6h'
                                                ? Color(0xFFAF97EC)
                                                : Colors.white),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Center(
                                        child: Text(
                                          '6时',
                                          style: TextStyle(
                                              color: time == '6h'
                                                  ? Color(0xFFAF97EC)
                                                  : Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 16,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      setState(() {
                                        isLine = false;
                                        time = '12h';
                                        moretime = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: time == '12h'
                                                ? Color(0xFFAF97EC)
                                                : Colors.white),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Center(
                                        child: Text(
                                          '12时',
                                          style: TextStyle(
                                              color: time == '12h'
                                                  ? Color(0xFFAF97EC)
                                                  : Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x21C7C3D0),
                      offset: Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: TabBar(
                  controller: tabController,
                  labelColor: Color(0xFF602FDA),
                  unselectedLabelColor: Color(0xFF5F6173),
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  indicator: CustomUnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Color(0xFF602FDA),
                      width: 4.0,
                    ),
                  ),
                  tabs: [
                    Tab(
                      text: '委托订单',
                    ),
                    Tab(
                      text: '成交',
                    ),
                    Tab(
                      text: '简介',
                    )
                  ],
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [
            KLineList1(
              price: this.price,
            ),
            KLineList2(
              chengjiao: chengjiao,
            ),
            KLineList3()
          ],
        ),
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;
  final BoxDecoration? decoration;

  StickyTabBarDelegate({required this.child, this.decoration});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: decoration,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

item() {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Center(
                    child: Text(
                      '成交时间',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Center(
                    child: Text(
                      '04-07 20:15:16',
                      style: TextStyle(
                        color: Color(0xFF313333),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Center(
                    child: Text(
                      '成交价格(HFT)',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Center(
                    child: Text(
                      '3.99',
                      style: TextStyle(
                        color: Color(0xFF313333),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Center(
                    child: Text(
                      '成交数量(HFC)',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Center(
                    child: Text(
                      '1231231.1233',
                      style: TextStyle(
                        color: Color(0xFF313333),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        color: Color(0xFFF6F6F6),
        height: 1,
      ),
    ],
  );
}

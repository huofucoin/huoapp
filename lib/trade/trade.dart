import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/api/tradenow.dart';
import 'package:huofu/api/tradecreate.dart';
import 'package:huofu/api/tradeprice.dart';
import 'package:huofu/api/zichan.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/iTextField2.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/mine/customTabIndicator.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/response1.dart' as Response1;
import 'package:huofu/model/tradeprice.dart';
import 'package:huofu/model/zichan.dart';
import 'package:huofu/state/user.dart';
import 'package:huofu/trade/iSlider.dart';
import 'package:huofu/trade/kline.dart';
import 'package:huofu/trade/tradeAll.dart';
import 'package:huofu/trade/tradeList.dart';
import 'package:provider/provider.dart';

class Trade extends StatefulWidget {
  @override
  TradeState createState() => TradeState();
}

class TradeState extends State with SingleTickerProviderStateMixin {
  TabController? tabController;
  double sliderValue = 0;
  bool priceLimit = false;
  bool buy = true;
  String hft = '';
  String hfc = '';
  int direction = 0;
  String total = '';
  TradePriceModel? price;
  ZiChanModel? zichanhft;
  ZiChanModel? zichanhfc;
  double nowprice = 0;
  String updown = '--';
  DateTime lastInsert = DateTime.now();

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _reload(t: loading());
    });
  }

  void _reload({ToastFuture? t}) {
    Future.wait([tradeprice(), zichan(), tradenow()]).then((value) {
      if (mounted) {
        TradePriceModel? newprice =
            (value[0] as ResponseModel<TradePriceModel>).data;
        setState(() {
          direction = (double.tryParse(price?.newprice ?? '0') ?? 0) >
                  (double.tryParse(newprice?.newprice ?? '0') ?? 0)
              ? 2
              : 1;
          price = newprice;
          (value[1] as Response1.ResponseModel<ZiChanModel>).data?.forEach((e) {
            if (e.coinName == 'HFT') {
              setState(() {
                zichanhft = e;
              });
            } else if (e.coinName == 'HFC') {
              setState(() {
                zichanhfc = e;
              });
            }
          });
          nowprice = (value[2] as ResponseModel).nowprice ?? 0;
          updown = (value[2] as ResponseModel).updown ?? '--';
        });
        Timer(Duration(seconds: 3), () {
          _reload(t: t);
        });
      }
      if (t != null) t.dismiss(showAnim: true);
    }).catchError((error) {
      Timer(Duration(seconds: 3), () {
        _reload(t: t);
      });
    });
  }

  void _update({bool slider = false}) {
    //更新交易金额，百分比等数据
    setState(() {
      if (slider) {
        double p = (priceLimit
            ? (double.tryParse(hft) ?? 0)
            : (double.tryParse(price?.newprice ?? '0') ?? 0));
        if (p <= 0) {
          sliderValue = 0;
          total = '0';
        } else {
          if (buy) {
            double t =
                ((buy ? zichanhft : zichanhfc)?.balance ?? 0) * sliderValue;
            total = t.toStringAsFixed(6);
            hfc = (t / p).toStringAsFixed(4);
          } else {
            hfc = ((zichanhfc?.balance ?? 0) * sliderValue).toStringAsFixed(4);
            total = ((double.tryParse(hfc) ?? 0) * p).toStringAsFixed(6);
          }
        }
      } else {
        total = ((priceLimit
                    ? (double.tryParse(hft) ?? 0)
                    : (double.tryParse(price?.newprice ?? '0') ?? 0)) *
                (double.tryParse(hfc) ?? 0))
            .toStringAsFixed(6);
        if (buy) {
          sliderValue = (double.tryParse(total) ?? 0) /
              ((zichanhft?.balance ?? 0) > 0 ? (zichanhft?.balance ?? 0) : 1);
        } else {
          sliderValue = (double.tryParse(hfc) ?? 0) /
              ((zichanhfc?.balance ?? 0) > 0 ? (zichanhfc?.balance ?? 0) : 1);
        }
      }
    });
  }

  List<Widget> deepOut() {
    List<String> list = (price?.priceout.keys ?? ['', '', '', '', '']).toList()
      ..sort((a, b) => a.compareTo(b));
    list = list.sublist(0, 5)..sort((a, b) => b.compareTo(a));
    double max = 0;
    list.forEach((e) {
      max = max > (double.tryParse(price?.priceout[e] ?? '0') ?? 0)
          ? max
          : (double.tryParse(price?.priceout[e] ?? '0') ?? 0);
    });
    return list.map<Widget>((e) {
      return deepItem(false, double.tryParse(e) ?? 0,
          double.tryParse(price?.priceout[e] ?? '0') ?? 0, max);
    }).toList();
  }

  List<Widget> deepIn() {
    List<String> list = (price?.pricein.keys ?? ['', '', '', '', '']).toList()
      ..sort((a, b) => a.compareTo(b));
    list = list.sublist(0, 5);
    double max = 0;
    list.forEach((e) {
      max = max > (double.tryParse(price?.pricein[e] ?? '0') ?? 0)
          ? max
          : (double.tryParse(price?.pricein[e] ?? '0') ?? 0);
    });
    return list.map<Widget>((e) {
      return deepItem(true, double.tryParse(e) ?? 0,
          double.tryParse(price?.pricein[e] ?? '0') ?? 0, max);
    }).toList();
  }

  void onPriceType() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      priceLimit = true;
                    });
                    _update();
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    padding: EdgeInsets.only(top: 18, bottom: 18),
                    child: Center(
                      child: Text(
                        '限价',
                        style: TextStyle(
                          color: Color(0xFF313333),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Color(0xFFF6F6F6),
                height: 1,
              ),
              Container(
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      priceLimit = false;
                    });
                    _update();
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 18, bottom: 18),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        '市价',
                        style: TextStyle(
                          color: Color(0xFF313333),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 18, bottom: 18),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        '取消',
                        style: TextStyle(
                          color: Color(0xFF313333),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(builder: (_, userInfo, __) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: MediaQuery.of(context).padding,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 45,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'HFC/HFT',
                                          style: TextStyle(
                                            color: Color(0xFF0D1333),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 4),
                                          padding:
                                              EdgeInsets.fromLTRB(2, 1, 2, 1),
                                          decoration: BoxDecoration(
                                            color: updown.indexOf('-') == 0
                                                ? Color(0xFFFFE5F0)
                                                : Color(0x1A16C9C5),
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                          child: Text(
                                            updown.indexOf('-') == 0
                                                ? updown
                                                : ('+' + updown),
                                            style: TextStyle(
                                              color: updown.indexOf('-') == 0
                                                  ? Color(0xFFEF3280)
                                                  : Color(0xFF2ECEE0),
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 17, bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '价格(HFT)',
                                            style: TextStyle(
                                              color: Color(0xFF9C9EA6),
                                              fontSize: 11,
                                            ),
                                          ),
                                          Text(
                                            '数量(HFC)',
                                            style: TextStyle(
                                              color: Color(0xFF9C9EA6),
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ...deepOut(),
                                    Container(
                                      height: 40,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            (double.tryParse(price?.newprice ??
                                                        '0') ??
                                                    0)
                                                .toString(),
                                            style: TextStyle(
                                              color: Color(0xFF2ECEE0),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Image.asset(
                                            direction == 2
                                                ? 'images/tradedown@2x.png'
                                                : 'images/up@2x.png',
                                            width: 16,
                                            height: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                    ...deepIn(),
                                  ],
                                ),
                              ),
                              Container(
                                width: 17,
                              ),
                              Expanded(
                                flex: 55,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (builder) {
                                              return KLine();
                                            }));
                                          },
                                          child: Image.asset(
                                            'images/chart@2x.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 14),
                                      transform:
                                          Matrix4.translationValues(0, 0, 0),
                                      child: Stack(
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 191 / 44,
                                            child: buy
                                                ? Image.asset(
                                                    'images/trade_buy@2x.png')
                                                : Image.asset(
                                                    'images/trade_sell@2x.png'),
                                          ),
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                            child: Flex(
                                              direction: Axis.horizontal,
                                              children: [
                                                Expanded(
                                                  flex: 88,
                                                  child: GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () {
                                                      setState(() {
                                                        buy = true;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 9,
                                                  child: Container(),
                                                ),
                                                Expanded(
                                                  flex: 88,
                                                  child: GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () {
                                                      setState(() {
                                                        buy = false;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: onPriceType,
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(8, 4, 8, 4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          border: Border.all(
                                            color: Color(0xFFF6F6F6),
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              priceLimit ? '限价' : '市价',
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 11,
                                              ),
                                            ),
                                            Image.asset(
                                              'images/down@2x.png',
                                              width: 12,
                                              height: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 16, bottom: 8),
                                      height: 32,
                                      child: ITextFiled2(
                                        enable: priceLimit,
                                        fixed: 2,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+(\.\d{0,2})?'))
                                        ],
                                        value: priceLimit
                                            ? hft
                                            : (double.tryParse(
                                                        price?.newprice ??
                                                            '') ??
                                                    0)
                                                .toString(),
                                        labelText: '价格(HFT)',
                                        fieldCallBack: (content) {
                                          setState(() {
                                            hft = content;
                                          });
                                          _update();
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 16),
                                      height: 32,
                                      child: ITextFiled2(
                                        fixed: 4,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+(\.\d{0,4})?'))
                                        ],
                                        value: hfc,
                                        labelText: '数量(HFC)',
                                        fieldCallBack: (content) {
                                          setState(() {
                                            hfc = content;
                                          });
                                          _update();
                                        },
                                      ),
                                    ),
                                    ...(userInfo.isLogin
                                        ? [
                                            ISlider(
                                              value: sliderValue,
                                              fieldCallBack: (value) {
                                                setState(() {
                                                  print(value);
                                                  sliderValue = value;
                                                });
                                                _update(slider: true);
                                              },
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '可用',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF9C9EA6),
                                                          fontSize: 11,
                                                        ),
                                                      ),
                                                      Text(
                                                        ((buy ? zichanhft : zichanhfc)
                                                                        ?.balance ??
                                                                    0)
                                                                .toString() +
                                                            (buy
                                                                ? ' HFT'
                                                                : ' HFC'),
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF9C9EA6),
                                                          fontSize: 11,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 16, bottom: 14),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          '交易金额',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF9C9EA6),
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                        Text(
                                                          total + ' HFT',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFF9C9EA6),
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            IButton2(
                                              fieldCallBack: () async {
                                                if (priceLimit &&
                                                    (double.tryParse(hft) ==
                                                            null ||
                                                        double.parse(hft) <=
                                                            0)) {
                                                  toast('请输入交易金额');
                                                  return;
                                                }
                                                if (double.tryParse(hfc) ==
                                                        null ||
                                                    double.parse(hfc) <= 0) {
                                                  toast('请输入交易数量');
                                                  return;
                                                }
                                                if (buy) {
                                                  if ((zichanhft?.balance ??
                                                          0) <
                                                      (double.tryParse(total) ??
                                                          0)) {
                                                    toast('余额不足');
                                                    return;
                                                  }
                                                } else {
                                                  if ((zichanhfc?.balance ??
                                                          0) <
                                                      (double.tryParse(hfc) ??
                                                          0)) {
                                                    toast('余额不足');
                                                    return;
                                                  }
                                                }
                                                loading();
                                                ResponseModel response =
                                                    await tradecreate(
                                                        buy
                                                            ? (priceLimit
                                                                ? 0
                                                                : 2)
                                                            : (priceLimit
                                                                ? 1
                                                                : 3),
                                                        priceLimit
                                                            ? hft
                                                            : (price?.newprice ??
                                                                '0'),
                                                        hfc);
                                                toast(response.msg);
                                                setState(() {
                                                  lastInsert = DateTime.now();
                                                });
                                              },
                                              labelText: buy ? '买入' : '卖出',
                                              height: 40,
                                              fontSize: 15,
                                              enable: double.tryParse(hfc) !=
                                                      null &&
                                                  double.parse(hfc) > 0 &&
                                                  (!priceLimit ||
                                                      (double.tryParse(hft) !=
                                                              null &&
                                                          double.parse(hft) >
                                                              0)) &&
                                                  (buy
                                                      ? (zichanhft?.balance ??
                                                              0) >=
                                                          (double.tryParse(
                                                                  total) ??
                                                              0)
                                                      : (zichanhfc?.balance ??
                                                              0) >=
                                                          (double.tryParse(
                                                                  hfc) ??
                                                              0)),
                                            )
                                          ]
                                        : [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IButton2(
                                                    fieldCallBack: () {
                                                      Navigator.of(context)
                                                          .pushNamed('/login');
                                                    },
                                                    labelText: '登录/注册',
                                                    height: 40,
                                                    fontSize: 15,
                                                    fontShadow: false,
                                                    enable: true,
                                                  )
                                                ],
                                              ),
                                            )
                                          ])
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 16,
                        color: Color(0xFFFAFAFA),
                      ),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyTabBarDelegate(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0x21C7C3D0),
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: PreferredSize(
                      preferredSize: Size.fromHeight(kTextTabBarHeight),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          Container(
                            width: 210,
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
                                  text: '当前委托',
                                ),
                                Tab(
                                  text: '历史委托',
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return TradeAll();
                              }));
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: Text(
                                '全部',
                                style: TextStyle(
                                  color: Color(0xFF602FDA),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ];
            },
            body: TabBarView(
              controller: tabController,
              children: [
                TradeList(
                  update: lastInsert,
                  status: TradeListStatus.current,
                ),
                TradeList(
                  update: lastInsert,
                  status: TradeListStatus.history,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

Widget deepItem(bool buy, double price, double count, double max) {
  max = max > 0 ? max : 1;
  return Stack(
    children: [
      Container(
        height: 28,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(),
              flex: 100 - ((count / max) * 100).truncate(),
            ),
            Expanded(
              child: Container(
                color: buy ? Color(0x1A16C9C5) : Color(0xFFFFE5F0),
              ),
              flex: ((count / max) * 100).truncate(),
            )
          ],
        ),
      ),
      Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              price.toString(),
              style: TextStyle(
                color: buy ? Color(0xFF2ECEE0) : Color(0xFFEF3280),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              count.toString(),
              style: TextStyle(
                color: Color(0xFF9C9EA6),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

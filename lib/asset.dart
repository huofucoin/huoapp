import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/zichan.dart';
import 'package:huofu/mine/mobileVerify.dart';
import 'package:huofu/mine/verify.dart';
import 'package:huofu/model/zichan.dart';
import 'package:huofu/order/order.dart';
import 'package:huofu/orderList.dart';
import 'package:huofu/state/user.dart';
import 'package:huofu/tabControl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Asset extends StatefulWidget {
  final SwitchTabCallBack? callBack;

  const Asset({this.callBack, Key? key}) : super(key: key);

  @override
  AssetState createState() => AssetState();
}

class AssetState extends State<Asset> {
  RefreshController _refreshController = RefreshController();
  List<ZiChanModel> zichans = [];
  double tlmoney = 0;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    zichan().then((value) {
      setState(() {
        zichans = value.data ?? [];
        tlmoney = value.tlmoney ?? 0;
      });
      _refreshController.refreshCompleted();
    }).catchError((error) {
      _refreshController.refreshFailed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(builder: (_, userState, __) {
      switch (userState.userInfo?.checks ?? 0) {
        case 0:
          return Scaffold(
            appBar: AppBar(
              title: Text('资产'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/emptyMobile@2x.png',
                    width: 185,
                    height: 100,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 13),
                    child: Text(
                      '验证手机号',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF5F6173),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      '为了确保您的账户安全，我们',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      '需要验证您的手机号',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return MobileVerify();
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 31),
                      width: 100,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Color(0xFF602FDA),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '去认证',
                          style: TextStyle(
                            color: Color(0xFF602FDA),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        case 1:
          return Scaffold(
            appBar: AppBar(
              title: Text('资产'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/emptyVerify@2x.png',
                    width: 185,
                    height: 93,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 13),
                    child: Text(
                      '身份认证',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF5F6173),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      '为了确保您的账户安全，您需',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      '要完成身份认证',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Verify();
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 31),
                      width: 100,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Color(0xFF602FDA),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '去认证',
                          style: TextStyle(
                            color: Color(0xFF602FDA),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        default:
          return Scaffold(
            backgroundColor: Color(0xFF602FDA),
            appBar: AppBar(
              title: Text(
                '资产',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.transparent,
              brightness: Brightness.dark,
              elevation: 0,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return OrderList();
                    }));
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Image.asset(
                      'images/order@2x.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                )
              ],
            ),
            body: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                color: Color(0xFFFAFAFA),
                child: SmartRefresher(
                  enablePullDown: true,
                  header: WaterDropHeader(),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(16, 24, 15, 24),
                    children: [
                      Text(
                        '总资产折合（元）',
                        style: TextStyle(
                          color: Color(0xFF0D1333),
                          fontSize: 13,
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      Text(
                        tlmoney.toStringAsFixed(2),
                        style: TextStyle(
                          color: Color(0xFF0D1333),
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      ...zichans.map((e) {
                        switch (e.coinName) {
                          case 'HFT':
                            return Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x21C7C3D0),
                                    offset: Offset(0, 2),
                                    blurRadius: 8,
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 4),
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF0084FF),
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        child: Center(
                                          child: Text(
                                            e.coinName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        e.coinName,
                                        style: TextStyle(
                                          color: Color(0xFF0D1333),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 16,
                                  ),
                                  Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Text(
                                              '可用',
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              '冻结',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              '总资产',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 11,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      TableRow(children: [
                                        Container(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 8,
                                        )
                                      ]),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Text(
                                              e.balance.toStringAsFixed(6),
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              e.frozens.toStringAsFixed(6),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              e.totalamount.toStringAsFixed(6),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (_) {
                                              return Order(
                                                buy: true,
                                                canPop: true,
                                              );
                                            }));
                                          },
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xFF5BE9F2),
                                                  Color(0xFF2ECEE0)
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset(0, 20),
                                                  blurRadius: 16,
                                                  spreadRadius: -16,
                                                  color: Color(0x6116C9C5),
                                                )
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                '买入',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
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
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return Order(
                                                buy: false,
                                                canPop: true,
                                              );
                                            }));
                                          },
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xFFF861B6),
                                                  Color(0xFFEF3280)
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset(0, 20),
                                                  blurRadius: 16,
                                                  spreadRadius: -16,
                                                  color: Color(0x61FF0069),
                                                )
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                '卖出',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          case 'HFC':
                            return Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x21C7C3D0),
                                    offset: Offset(0, 2),
                                    blurRadius: 8,
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 4),
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF2ECEE0),
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                        child: Center(
                                          child: Text(
                                            e.coinName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        e.coinName,
                                        style: TextStyle(
                                          color: Color(0xFF0D1333),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 16,
                                  ),
                                  Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Text(
                                              '可用',
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              '冻结',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              '锁仓',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              '总资产',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 11,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      TableRow(children: [
                                        Container(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 8,
                                        )
                                      ]),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Text(
                                              e.balance.toStringAsFixed(6),
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              e.frozens.toStringAsFixed(6),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              e.lockp.toStringAsFixed(6),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              e.totalamount.toStringAsFixed(6),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      TableRow(children: [
                                        Container(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 8,
                                        ),
                                        Container(
                                          height: 8,
                                        )
                                      ]),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Text(
                                              '≈ ￥' +
                                                  e.balancemoney
                                                      .toStringAsFixed(2),
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              '≈ ￥' +
                                                  e.frozensmoney
                                                      .toStringAsFixed(2),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              '≈ ￥' +
                                                  e.lockpmoney
                                                      .toStringAsFixed(2),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Text(
                                              '≈ ￥' +
                                                  e.totalamountmoney
                                                      .toStringAsFixed(2),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            widget.callBack?.call(1);
                                          },
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xFF995CEF),
                                                  Color(0xFF602FDA)
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '交易',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                        }
                        return Container();
                      })
                    ],
                  ),
                ),
              ),
            ),
          );
      }
    });
  }
}

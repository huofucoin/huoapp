import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/api/ordersell.dart';
import 'package:huofu/api/ordersxf.dart';
import 'package:huofu/api/sksign.dart';
import 'package:huofu/api/zichan.dart';
import 'package:huofu/iButton.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/iTextField.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/mine/payment.dart';
import 'package:huofu/model/order.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/zichan.dart';
import 'package:huofu/order/detail.dart';
import 'package:huofu/state/user.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderSell extends StatefulWidget {
  @override
  OrderSellState createState() => OrderSellState();
}

class OrderSellState extends State {
  String count = '';
  String sxf = '';
  String money = '';
  String payment = '';
  RefreshController _refreshController = RefreshController();
  ZiChanModel? zichans;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    zichan().then((value) {
      value.data?.forEach((e) {
        if (e.coinName == 'HFT') {
          setState(() {
            zichans = e;
          });
        }
      });
    }).catchError((error) {
      print(error);
    });
    sksign().then((value) {
      setState(() {
        if (value.sign?.bank == 'y') {
          payment = '银行卡';
        } else if (value.sign?.weixin == 'y') {
          payment = '微信';
        } else if (value.sign?.zfb == 'y') {
          payment = '支付宝';
        }
      });
      _refreshController.refreshCompleted();
    }).catchError((error) {
      _refreshController.refreshFailed();
    });
  }

  Widget payInfo() {
    return Consumer<UserState>(
      builder: (_, userState, ___) {
        if (userState.skSignModel == null ||
            (userState.skSignModel?.bank == 'n' &&
                userState.skSignModel?.weixin == 'n' &&
                userState.skSignModel?.zfb == 'n')) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return Payment();
              }));
            },
            child: Container(
              margin: EdgeInsets.only(top: 8, bottom: 32),
              padding: EdgeInsets.fromLTRB(15, 8, 16, 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFF6F6F6),
                  width: 1,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x21C7C3D0),
                    offset: Offset(0, 2),
                    blurRadius: 8,
                    spreadRadius: 0,
                  )
                ],
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '设置我的收款方式',
                    style: TextStyle(
                      color: Color(0xFF9C9EA6),
                      fontSize: 15,
                    ),
                  ),
                  Image.asset(
                    'images/message_next@2x.png',
                    width: 24,
                    height: 24,
                  )
                ],
              ),
            ),
          );
        }
        double width = (MediaQuery.of(context).size.width - 64) / 3;
        return Container(
          padding: EdgeInsets.only(top: 8, bottom: 32),
          child: Row(
            children: [
              if (userState.skSignModel?.bank == 'y')
                Container(
                  width: width,
                  margin: EdgeInsets.only(right: 16),
                  child: IButton(
                    labelText: '银行卡',
                    selected: payment == '银行卡',
                    borderRadius: 8,
                    border: Border.all(
                      color: Color(0xFFF6F6F6),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    fieldCallBack: (select) {
                      if (select) {
                        setState(() {
                          payment = '银行卡';
                        });
                      }
                    },
                  ),
                ),
              if (userState.skSignModel?.weixin == 'y')
                Container(
                  width: width,
                  margin: EdgeInsets.only(right: 16),
                  child: IButton(
                    labelText: '微信',
                    selected: payment == '微信',
                    borderRadius: 8,
                    border: Border.all(
                      color: Color(0xFFF6F6F6),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    fieldCallBack: (select) {
                      if (select) {
                        setState(() {
                          payment = '微信';
                        });
                      }
                    },
                  ),
                ),
              if (userState.skSignModel?.zfb == 'y')
                Container(
                  width: width,
                  margin: EdgeInsets.only(right: 16),
                  child: IButton(
                    labelText: '支付宝',
                    selected: payment == '支付宝',
                    borderRadius: 8,
                    border: Border.all(
                      color: Color(0xFFF6F6F6),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                    fieldCallBack: (select) {
                      if (select) {
                        setState(() {
                          payment = '支付宝';
                        });
                      }
                    },
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  Widget balance() {
    return Consumer<UserState>(builder: (_, userState, __) {
      return Container(
        padding: EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '余额： ' + (zichans?.balance ?? 0.00).toString() + ' HFT',
              style: TextStyle(
                color: Color(0xFF0D1333),
                fontSize: 13,
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            header: WaterDropHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Text(
                  '卖出数量',
                  style: TextStyle(
                    color: Color(0xFF0D1333),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8),
                  child: ITextFiled(
                    value: count,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+(\.\d{0,2})?'))
                    ],
                    labelText: '100.00 HFT起',
                    suffix: Container(
                      padding: EdgeInsets.only(right: 16),
                      child: Text(
                        'HFT',
                        style: TextStyle(
                          color: Color(0xFF0D1333),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    fieldCallBack: (content) {
                      setState(() {
                        count = content;
                      });
                      ordersxf(double.tryParse(content) ?? 0).then((value) {
                        if (count == content) {
                          setState(() {
                            sxf = (value.data?.sxf ?? '').toString();
                            money = ((double.tryParse(content) ?? 0) -
                                    (value.data?.sxf ?? 0))
                                .toString();
                          });
                        }
                      });
                    },
                  ),
                ),
                balance(),
                Container(
                  padding: EdgeInsets.only(top: 32),
                  child: Text(
                    '收款方式',
                    style: TextStyle(
                      color: Color(0xFF0D1333),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                payInfo(),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: Color(0x80FAFAFA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFF6F6F6),
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '价格',
                              style: TextStyle(
                                color: Color(0xFF5F6173),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '1 HFT ＝ 1 CNY',
                              style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFF6F6F6),
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '手续费(0.8%)',
                              style: TextStyle(
                                color: Color(0xFF5F6173),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              (double.tryParse(sxf)?.toString() ?? '--') +
                                  ' HFT',
                              style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '到账金额',
                              style: TextStyle(
                                color: Color(0xFF5F6173),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              (double.tryParse(money)?.toString() ?? '--') +
                                  ' CNY',
                              style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: IButton2(
            labelText: '出售',
            enable: true,
            fieldCallBack: () {
              if (payment.length == 0) {
                toast('请选择您的收款方式');
                return;
              }
              if (double.parse(count) < 100) {
                toast('最小出售数量100.00HFT');
                return;
              }
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (_) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 44),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 8, bottom: 17),
                                  child: Text(
                                    '确认出售',
                                    style: TextStyle(
                                      color: Color(0xFF0D1333),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 16,
                                    bottom: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEDE6FF),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '到账金额',
                                          style: TextStyle(
                                            color: Color(0xFFAF97EC),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Container(
                                          width: 10,
                                        ),
                                        Text(
                                          (double.tryParse(money) ?? '--')
                                                  .toString() +
                                              ' CNY',
                                          style: TextStyle(
                                            color: Color(0xFF602FDA),
                                            fontSize: 26,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10, bottom: 24),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(0xFFF6F6F6),
                                              width: 1,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '收款方式',
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              payment,
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(0xFFF6F6F6),
                                              width: 1,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '出售数量',
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              (double.tryParse(count) ?? '--')
                                                      .toString() +
                                                  ' HFT',
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(0xFFF6F6F6),
                                              width: 1,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '价格',
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              '1 HFT ＝ 1 CNY',
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '手续费(0.8%)',
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              (double.tryParse(sxf) ?? '--')
                                                      .toString() +
                                                  ' HFT',
                                              style: TextStyle(
                                                color: Color(0xFF0D1333),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IButton2(
                                  labelText: '下单',
                                  enable: true,
                                  fieldCallBack: () async {
                                    Navigator.of(context).pop();
                                    loading();
                                    ResponseModel<OrderModel> result =
                                        await ordersell(
                                            payment == '微信'
                                                ? 2
                                                : (payment == '支付宝' ? 3 : 1),
                                            double.parse(count));
                                    ToastManager().dismissAll(showAnim: true);
                                    if (result.code == 0 &&
                                        result.data != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return Detail(
                                              orderid: result.data!.id,
                                            );
                                          },
                                        ),
                                      );
                                    } else {
                                      toast(result.msg);
                                    }
                                  },
                                )
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  'images/close@2x.png',
                                  width: 28,
                                  height: 28,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}

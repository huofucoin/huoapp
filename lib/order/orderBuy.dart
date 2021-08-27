import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/api/orderbuy.dart';
import 'package:huofu/api/sksign.dart';
import 'package:huofu/iButton.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/iTextField.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/model/order.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/order/detail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderBuy extends StatefulWidget {
  @override
  OrderBuyState createState() => OrderBuyState();
}

class OrderBuyState extends State {
  String count = '';
  int payment = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    sksign();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
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
                  '买入金额',
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
                    labelText: '100.00 CNY起',
                    suffix: Container(
                      padding: EdgeInsets.only(right: 16),
                      child: Text(
                        'CNY',
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
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 32),
                  child: Text(
                    '支付方式',
                    style: TextStyle(
                      color: Color(0xFF0D1333),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8, bottom: 32),
                  child: Row(
                    children: [
                      Expanded(
                        child: IButton(
                          labelText: '银行卡',
                          selected: payment == 0,
                          borderRadius: 8,
                          border: Border.all(
                            color: Color(0xFFF6F6F6),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          fieldCallBack: (select) {
                            if (select) {
                              setState(() {
                                payment = 0;
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
                          labelText: '微信',
                          selected: payment == 1,
                          borderRadius: 8,
                          border: Border.all(
                            color: Color(0xFFF6F6F6),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          fieldCallBack: (select) {
                            if (select) {
                              setState(() {
                                payment = 1;
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
                          labelText: '支付宝',
                          selected: payment == 2,
                          borderRadius: 8,
                          border: Border.all(
                            color: Color(0xFFF6F6F6),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          fieldCallBack: (select) {
                            if (select) {
                              setState(() {
                                payment = 2;
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
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
                              '手续费',
                              style: TextStyle(
                                color: Color(0xFF5F6173),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '免费',
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
                              '到账数量',
                              style: TextStyle(
                                color: Color(0xFF5F6173),
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              ((count.length > 0 ? count : '--') + ' HFT'),
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
            labelText: '购买',
            enable: true,
            fieldCallBack: () {
              if (count.length == 0 || double.parse(count) < 100) {
                toast('最小购买金额100.00CNY');
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
                                    '确认购买',
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
                                          '到账数量',
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
                                          (count.length > 0 ? count : '--') +
                                              ' HFT',
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
                                              '付款方式',
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              '银行卡',
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
                                              '买入金额',
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              (count.length > 0
                                                      ? count
                                                      : '--') +
                                                  ' CNY',
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
                                              '手续费',
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              '免费',
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
                                        await orderbuy(
                                            payment + 1, double.parse(count));
                                    ToastManager().dismissAll(showAnim: true);
                                    if (result.code == 0 &&
                                        result.data != null) {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return Detail(
                                          orderid: result.data!.id,
                                        );
                                      }));
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

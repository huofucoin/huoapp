import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/mine/mobileVerify.dart';
import 'package:huofu/mine/verify.dart';
import 'package:huofu/order/orderBuy.dart';
import 'package:huofu/order/orderSell.dart';
import 'package:huofu/order/list.dart';
import 'package:huofu/state/user.dart';
import 'package:provider/provider.dart';

class Order extends StatefulWidget {
  final bool canPop;
  final bool buy;
  const Order({this.buy = true, this.canPop = false, Key? key})
      : super(key: key);
  @override
  OrderState createState() => OrderState();
}

class OrderState extends State<Order> {
  bool buy = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      buy = widget.buy;
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
              leading: widget.canPop
                  ? IBackIcon(
                      left: 16,
                    )
                  : null,
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
              leading: widget.canPop
                  ? IBackIcon(
                      left: 16,
                    )
                  : null,
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
            appBar: AppBar(
              brightness: Brightness.dark,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                '买/卖HFT',
                style: TextStyle(color: Colors.white),
              ),
              leading: widget.canPop
                  ? IBackIcon(
                      left: 16,
                      style: 'white',
                    )
                  : null,
            ),
            backgroundColor: Color(0xFF602FDA),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              setState(() {
                                buy = true;
                              });
                            },
                            child: Text(
                              '我要买',
                              style: buy
                                  ? TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                    )
                                  : TextStyle(
                                      color: Color(0x80FFFFFF),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                            ),
                          ),
                          Container(
                            width: 32,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              setState(() {
                                buy = false;
                              });
                            },
                            child: Text(
                              '我要卖',
                              style: !buy
                                  ? TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                    )
                                  : TextStyle(
                                      color: Color(0x80FFFFFF),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return OrderList();
                          }));
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'images/order@2x.png',
                              width: 21,
                              height: 21,
                            ),
                            Container(
                              width: 4,
                            ),
                            Text(
                              '订单',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: buy ? OrderBuy() : OrderSell(),
                  ),
                )
              ],
            ),
          );
      }
    });
  }
}

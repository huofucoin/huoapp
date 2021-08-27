import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/orderlist.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/mine/customTabIndicator.dart';
import 'package:huofu/model/order.dart';
import 'package:huofu/order/detail.dart';
import 'package:huofu/trade/tradeList.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderList extends StatefulWidget {
  @override
  OrderListState createState() => OrderListState();
}

class OrderListState extends State with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text(
          '订单',
        ),
        leading: IBackIcon(
          left: 16,
        ),
        bottom: TabBar(
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
              text: '未完成',
            ),
            Tab(
              text: '已完成',
            ),
            Tab(
              text: '已取消',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          OrderList1(
            type: 1,
          ),
          OrderList1(
            type: 2,
          ),
          OrderList1(
            type: 3,
          )
        ],
      ),
    );
  }
}

class OrderList1 extends StatefulWidget {
  final int type;
  const OrderList1({this.type = 1, Key? key}) : super(key: key);
  @override
  OrderList1State createState() => OrderList1State();
}

class OrderList1State extends State<OrderList1> with TickerProviderStateMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<OrderModel> bills = [];

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    orderlist(widget.type, 1).then((value) {
      setState(() {
        bills = value.data ?? [];
      });
      _refreshController.refreshCompleted();
    }).catchError((error) {
      _refreshController.refreshFailed();
    });
  }

  String status(int status) {
    switch (status) {
      case 1:
        return '待付款';
      case 2:
        return '已完成';
      case 3:
        return '买家取消';
      case 4:
        return '超时取消';
      case 5:
        return '系统取消';
      case 6:
        return '待放币';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: WaterDropHeader(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: bills.length > 0
          ? ListView.separated(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              itemBuilder: (context, index) {
                OrderModel order = bills[index];
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return Detail(orderid: order.id);
                    }));
                  },
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
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(top: 10, bottom: 8, left: 19),
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
                                    'HFT',
                                    style: TextStyle(
                                      color: Color(0xFF313333),
                                      fontSize: 17,
                                    ),
                                  ),
                                  Text(
                                    status(order.status),
                                    style: TextStyle(
                                      color: Color(0xFFFF9200),
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            order.ordertype == 1
                                ? Positioned(
                                    left: -27,
                                    top: 10,
                                    child: Image.asset(
                                      'images/buy2@2x.png',
                                      width: 41,
                                      height: 26,
                                    ),
                                  )
                                : Positioned(
                                    left: -24,
                                    top: 10,
                                    child: Image.asset(
                                      'images/sell2@2x.png',
                                      width: 35,
                                      height: 24,
                                    ),
                                  )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 4),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: Color(0xFFF6F6F6),
                                        width: 1,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 47,
                                            child: Text(
                                              '价格',
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            order.unitmoney.toString() + ' CNY',
                                            style: TextStyle(
                                              color: Color(0xFF5F6173),
                                              fontSize: 13,
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: 8, bottom: 8),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 47,
                                              child: Text(
                                                '数量',
                                                style: TextStyle(
                                                  color: Color(0xFF9C9EA6),
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              order.count.toString() + ' HFT',
                                              style: TextStyle(
                                                color: Color(0xFF5F6173),
                                                fontSize: 13,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 47,
                                            child: Text(
                                              '手续费',
                                              style: TextStyle(
                                                color: Color(0xFF9C9EA6),
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            order.ordertype == 1
                                                ? '免费'
                                                : order.sxfmoney.toString() +
                                                    ' HFT',
                                            style: TextStyle(
                                              color: Color(0xFF5F6173),
                                              fontSize: 13,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      order.money.toString() + ' CNY',
                                      style: TextStyle(
                                        color: Color(0xFF313333),
                                        fontSize: 22,
                                      ),
                                    ),
                                    Container(
                                      height: 5,
                                    ),
                                    Text(
                                      '总金额',
                                      style: TextStyle(
                                        color: Color(0xFF9C9EA6),
                                        fontSize: 15,
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
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 8,
                );
              },
              itemCount: bills.length,
            )
          : empty(),
    );
  }
}

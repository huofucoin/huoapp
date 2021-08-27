import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/bill.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/innovationOrder.dart';
import 'package:huofu/mine/customTabIndicator.dart';
import 'package:huofu/model/bill.dart';
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
    tabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text(
          '账单',
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
              text: '币币交易',
            ),
            Tab(
              text: 'OTC',
            ),
            Tab(
              text: '投资理财',
            ),
            Tab(
              text: '活动奖励',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          OrderList1(
            status: 1,
          ),
          OrderList1(
            status: 2,
          ),
          OrderList1(
            status: 3,
          ),
          OrderList1(
            status: 4,
          ),
        ],
      ),
    );
  }
}

class OrderList1 extends StatefulWidget {
  final int status;
  const OrderList1({Key? key, required this.status}) : super(key: key);
  @override
  OrderList1State createState() => OrderList1State();
}

class OrderList1State extends State<OrderList1> with TickerProviderStateMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<BillModel> bills = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    bill(widget.status, 1).then((value) {
      setState(() {
        bills = value.data ?? [];
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
    bill(widget.status, page).then((value) {
      setState(() {
        bills.addAll(value.data ?? []);
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
      child: bills.length > 0
          ? SingleChildScrollView(
              padding: EdgeInsets.all(16),
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
                    ...bills.asMap().keys.map((index) {
                      BillModel bill = bills[index];
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (widget.status == 2) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return Detail(orderid: bill.orderid);
                            }));
                          } else if (widget.status == 3) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return InnovationOrder(id: bill.orderid);
                            }));
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Color(0xFFF6F6F6),
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bill.title,
                                      style: TextStyle(
                                        color: Color(0xFF313333),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      height: 5,
                                    ),
                                    Text(
                                      formatDate(bill.createtime, [
                                        mm,
                                        '-',
                                        dd,
                                        ' ',
                                        HH,
                                        ':',
                                        nn,
                                        ':',
                                        ss
                                      ]),
                                      style: TextStyle(
                                        color: Color(0xFF5F6173),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                bill.chemical +
                                    bill.money.toString() +
                                    ' ' +
                                    bill.coinname,
                                style: TextStyle(
                                  color: Color(0xFF2ECEE0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (widget.status == 2 || widget.status == 3)
                                Image.asset(
                                  'images/message_next@2x.png',
                                  width: 24,
                                  height: 24,
                                )
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            )
          : empty(),
    );
  }
}

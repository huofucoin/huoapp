import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/wakuanglist.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/innovationOrder.dart';
import 'package:huofu/mine/customTabIndicator.dart';
import 'package:huofu/model/wakuang.dart';
import 'package:huofu/trade/tradeList.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InnovationList extends StatefulWidget {
  @override
  _InnovationListState createState() => _InnovationListState();
}

class _InnovationListState extends State with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text(
          '挖矿订单',
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
              text: '挖矿中',
            ),
            Tab(
              text: '已赎回',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          _OrderList1(
            status: 2,
          ),
          _OrderList1(
            status: 3,
          ),
        ],
      ),
    );
  }
}

class _OrderList1 extends StatefulWidget {
  final int status;
  const _OrderList1({Key? key, required this.status}) : super(key: key);
  @override
  _OrderList1State createState() => _OrderList1State();
}

class _OrderList1State extends State<_OrderList1>
    with TickerProviderStateMixin {
  List<WaKuangModel> jiaocangs = [];
  RefreshController _refreshController = RefreshController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    wakuanglist(widget.status, 1).then((value) {
      setState(() {
        jiaocangs = value.data ?? [];
        page = 2;
      });
      if ((value.data ?? []).length == 10) {
        _refreshController.resetNoData();
      }
      _refreshController.refreshCompleted();
    }).catchError((error) {
      _refreshController.refreshFailed();
    });
  }

  void _onLoading() {
    wakuanglist(widget.status, page).then((value) {
      setState(() {
        jiaocangs.addAll(value.data ?? []);
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
      child: jiaocangs.length > 0
          ? ListView.separated(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              clipBehavior: Clip.none,
              itemBuilder: (context, index) {
                WaKuangModel wakuang = jiaocangs[index];
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return InnovationOrder(
                        id: wakuang.id,
                      );
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 8,
                          spreadRadius: -2,
                          color: Color(0x366545B5),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '智能挖矿' + wakuang.days.toString() + '天',
                              style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              formatDate(wakuang.createtime, [
                                'yyyy',
                                '-',
                                'mm',
                                '-',
                                'dd',
                                ' ',
                                'HH',
                                ':',
                                'nn',
                                ':',
                                'ss'
                              ]),
                              style: TextStyle(
                                color: Color(0xFF5F6173),
                                fontSize: 11,
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16, bottom: 16),
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Text(
                                      '购买份额',
                                      style: TextStyle(
                                        color: Color(0xFF9C9EA6),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      '回报率',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF9C9EA6),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Text(
                                      '已产生收益',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color(0xFF9C9EA6),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: RichText(
                                        text: TextSpan(
                                          text: wakuang.count.toString(),
                                          style: TextStyle(
                                            color: Color(0xFF0D1333),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: ' 份',
                                              style: TextStyle(
                                                color: Color(0xFF5F6173),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text:
                                              (wakuang.rates * 100).toString(),
                                          style: TextStyle(
                                            color: Color(0xFF602FDA),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: ' %/天',
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: RichText(
                                        textAlign: TextAlign.right,
                                        text: TextSpan(
                                          text: wakuang.yprofit.toString(),
                                          style: TextStyle(
                                            color: Color(0xFF0D1333),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: ' HFC',
                                              style: TextStyle(
                                                color: Color(0xFF5F6173),
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatDate(wakuang.starttime, [
                                'yyyy',
                                '-',
                                'mm',
                                '-',
                                'dd',
                                ' ',
                                'HH',
                                ':',
                                'nn',
                                ':',
                                'ss'
                              ]),
                              style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 11,
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Image.asset(
                                    'images/arrow@2x.png',
                                    width: 57,
                                    height: 7,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              formatDate(wakuang.endtime, [
                                'yyyy',
                                '-',
                                'mm',
                                '-',
                                'dd',
                                ' ',
                                'HH',
                                ':',
                                'nn',
                                ':',
                                'ss'
                              ]),
                              style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 11,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Container(height: 8);
              },
              itemCount: jiaocangs.length,
            )
          : empty(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/jiaocanglist.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/innovationDetail.dart';
import 'package:huofu/innovationList.dart';
import 'package:huofu/mine/customTabIndicator.dart';
import 'package:huofu/model/jiaocang.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Innovation extends StatefulWidget {
  @override
  _InnovationState createState() => _InnovationState();
}

class _InnovationState extends State with TickerProviderStateMixin {
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
          '创新板块',
        ),
        leading: IBackIcon(
          left: 16,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return InnovationList();
              }));
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Image.asset(
                'images/order.light@2x.png',
                width: 24,
                height: 24,
              ),
            ),
          )
        ],
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
              text: '智能挖矿',
            ),
            Tab(
              text: '云算力',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          _OrderList1(),
          _OrderList2(),
        ],
      ),
    );
  }
}

class _OrderList1 extends StatefulWidget {
  @override
  _OrderList1State createState() => _OrderList1State();
}

class _OrderList1State extends State with TickerProviderStateMixin {
  List<JiaoCangModel> jiaocangs = [];
  RefreshController _refreshController = RefreshController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    jiaocanglist(1).then((value) {
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
    jiaocanglist(page).then((value) {
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
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          JiaoCangModel jiaocang = jiaocangs[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return InnovationDetail(
                  id: jiaocang.id,
                );
              }));
            },
            behavior: HitTestBehavior.opaque,
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
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 4),
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Color(0xFF2ECEE0),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(
                            'HFC',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        jiaocang.name,
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
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Color(0xFFEDE6FF),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFFEDE6FF),
                                offset: Offset(0, 1),
                                blurRadius: 2,
                                spreadRadius: 0),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: jiaocang.scount / jiaocang.tcount,
                          heightFactor: 1,
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Color(0xFF602FDA), Color(0xFF995CEF)],
                              ),
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.red,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xA8602FDA),
                                  offset: Offset(0, 2),
                                  blurRadius: 3,
                                  spreadRadius: -1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: jiaocang.scount.toString() + ' 份/ ',
                            style: TextStyle(
                              color: Color(0xFF0D1333),
                              fontSize: 11,
                            ),
                            children: [
                              TextSpan(
                                text: jiaocang.tcount.toString() + '份',
                                style: TextStyle(
                                  color: Color(0xFF5F6173),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '已售 ' +
                              (jiaocang.scount / jiaocang.tcount * 100)
                                  .toStringAsFixed(2) +
                              '%',
                          style: TextStyle(
                            color: Color(0xFF5F6173),
                            fontSize: 11,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.all(4),
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  '回报率',
                                  style: TextStyle(
                                    color: Color(0xFF9C9EA6),
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  '价格',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF9C9EA6),
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                    '挖矿期限',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xFF9C9EA6),
                                      fontSize: 11,
                                    ),
                                  )),
                            )
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: RichText(
                                  text: TextSpan(
                                    text: (jiaocang.rates * 100).toString(),
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
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: jiaocang.coinnumber.toString(),
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
                                          fontSize: 9,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '/份',
                                            style: TextStyle(
                                              fontSize: 11,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: RichText(
                                  textAlign: TextAlign.right,
                                  text: TextSpan(
                                    text: jiaocang.days.toString(),
                                    style: TextStyle(
                                      color: Color(0xFF0D1333),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' 天',
                                        style: TextStyle(
                                          color: Color(0xFF5F6173),
                                          fontSize: 11,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 8,
                  ),
                  Row(
                    children: [
                      jiaocang.status == 1
                          ? Expanded(
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
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '立即挖矿',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFF0F0F0),
                                      Color(0xFFDDDDDD)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    '已结束',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
      ),
    );
  }
}

class _OrderList2 extends StatefulWidget {
  @override
  _OrderList2State createState() => _OrderList2State();
}

class _OrderList2State extends State with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return waiting();
  }
}

waiting() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'images/waiting@2x.png',
          width: 185,
          height: 104,
        ),
        Container(
          margin: EdgeInsets.only(top: 13),
          child: Text(
            '敬请期待',
            style: TextStyle(
              color: Color(0xFF9C9EA6),
              fontSize: 13,
            ),
          ),
        )
      ],
    ),
  );
}

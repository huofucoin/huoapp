import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/tradecancel.dart';
import 'package:huofu/api/tradecancelall.dart';
import 'package:huofu/api/tradeorderhistory.dart';
import 'package:huofu/api/tradeordernow.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/tradeorder.dart';
import 'package:huofu/trade/detail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum TradeListStatus { current, history, all }

class TradeList extends StatefulWidget {
  final TradeListStatus status;
  final bool filter;
  final DateTime? update;
  const TradeList({
    Key? key,
    this.status = TradeListStatus.all,
    this.update,
    this.filter = false,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => TradeListState();
}

class TradeListState extends State<TradeList>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController = RefreshController();
  List<TradeOrderModel>? orders;
  int page = 1;
  int? type;
  int? leixing;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  void didUpdateWidget(covariant TradeList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.update != null && oldWidget.update != widget.update) {
      _onRefresh();
    }
  }

  void _onRefresh() {
    if (widget.status == TradeListStatus.history) {
      tradeorderhistory(1, billtype: type, leixing: leixing).then((value) {
        setState(() {
          orders = value.data;
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
    } else if (widget.status == TradeListStatus.current) {
      tradeordernow(1, billtype: type).then((value) {
        setState(() {
          orders = value.data;
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
  }

  void _onLoading() {
    if (widget.status == TradeListStatus.history) {
      tradeorderhistory(page, billtype: type, leixing: leixing).then((value) {
        setState(() {
          orders?.addAll(value.data ?? []);
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
        print(error);
        _refreshController.loadFailed();
      });
    } else if (widget.status == TradeListStatus.current) {
      tradeordernow(page, billtype: type).then((value) {
        setState(() {
          orders?.addAll(value.data ?? []);
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
        print(error);
        _refreshController.loadFailed();
      });
    }
  }

  onType() {
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
                    if (type != null) {
                      setState(() {
                        type = null;
                      });
                      Navigator.pop(context);
                      _refreshController.requestRefresh();
                      _onRefresh();
                    }
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
                        '全部',
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
                    if (type != 1) {
                      setState(() {
                        type = 1;
                      });
                      Navigator.pop(context);
                      _refreshController.requestRefresh();
                      _onRefresh();
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(top: 18, bottom: 18),
                    child: Center(
                      child: Text(
                        '买入',
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
                    if (type != 2) {
                      setState(() {
                        type = 2;
                      });
                      Navigator.pop(context);
                      _refreshController.requestRefresh();
                      _onRefresh();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 18, bottom: 18),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        '卖出',
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

  onLeixing() {
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
                    if (leixing != null) {
                      setState(() {
                        leixing = null;
                      });
                      Navigator.pop(context);
                      _refreshController.requestRefresh();
                      _onRefresh();
                    }
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
                        '全部',
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
                    if (leixing != 1) {
                      setState(() {
                        leixing = 1;
                      });
                      Navigator.pop(context);
                      _refreshController.requestRefresh();
                      _onRefresh();
                    }
                  },
                  child: Container(
                    color: Colors.white,
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
                    if (leixing != 2) {
                      setState(() {
                        leixing = 2;
                      });
                      Navigator.pop(context);
                      _refreshController.requestRefresh();
                      _onRefresh();
                    }
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
    super.build(context);
    return Container(
      color: Color(0xFFFAFAFA),
      child: Column(
        children: [
          if (widget.filter)
            Container(
              height: 48,
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
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  if (widget.status == TradeListStatus.history)
                    Text(
                      '类型：',
                      style: TextStyle(color: Color(0xFF5F6173), fontSize: 13),
                    ),
                  if (widget.status == TradeListStatus.history)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onLeixing,
                      child: Container(
                        height: 24,
                        padding: EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Color(0xFFF6F6F6),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        margin: EdgeInsets.only(right: 24),
                        child: Row(
                          children: [
                            Text(
                              leixing == 1
                                  ? '限价'
                                  : (leixing == 2 ? '市价' : '全部'),
                              style: TextStyle(
                                color: Color(0xFF5F6173),
                                fontSize: 13,
                              ),
                            ),
                            Container(
                              width: 8,
                            ),
                            Image.asset(
                              'images/arrow_down@2x.png',
                              width: 12,
                              height: 12,
                            )
                          ],
                        ),
                      ),
                    ),
                  Text(
                    '方向：',
                    style: TextStyle(color: Color(0xFF5F6173), fontSize: 13),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onType,
                    child: Container(
                      height: 24,
                      padding: EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                          color: Color(0xFFF6F6F6),
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      margin: EdgeInsets.only(right: 24),
                      child: Row(
                        children: [
                          Text(
                            type == 1 ? '买入' : (type == 2 ? '卖出' : '全部'),
                            style: TextStyle(
                              color: Color(0xFF5F6173),
                              fontSize: 13,
                            ),
                          ),
                          Container(
                            width: 8,
                          ),
                          Image.asset(
                            'images/arrow_down@2x.png',
                            width: 12,
                            height: 12,
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  if (widget.status == TradeListStatus.history)
                    Container(
                      padding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
                      child: Image.asset(
                        'images/calendar@2x.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  if (widget.status == TradeListStatus.current)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () async {
                        ResponseModel response = await tradecancelall();
                        toast(response.msg);
                      },
                      child: Container(
                        height: 24,
                        padding: EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Color(0xFF602FDA),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '全部撤单',
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
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: ClassicFooter(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: (orders ?? []).length > 0
                  ? ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Container(
                          height: 8,
                        ),
                        ...(orders ?? []).map((e) {
                          return tradeItem(context, e, widget.status);
                        }),
                      ],
                    )
                  : empty(),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

tradeItem(BuildContext context, TradeOrderModel order, TradeListStatus status) {
  return Stack(
    children: [
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Detail(id: order.id);
          }));
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 12, left: 57),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDate(
                          DateTime.fromMillisecondsSinceEpoch(
                              order.createTime * 1000),
                          ['mm', '-', 'dd', ' ', 'HH', ':', 'nn', ':', 'ss']),
                      style: TextStyle(
                        color: Color(0xFF313333),
                        fontSize: 13,
                      ),
                    ),
                    if (status == TradeListStatus.history)
                      Text(
                        order.revoked == 1
                            ? '已撤销'
                            : (order.deleted == 1
                                ? '完全成交'
                                : (order.billQuantity == order.billQuantityCopy
                                    ? '未成交'
                                    : '部分成交')),
                        style: TextStyle(
                          color: order.revoked == 1
                              ? Color(0xFF2ECEE0)
                              : (order.deleted == 1
                                  ? Color(0xFF0084FF)
                                  : (order.billQuantity ==
                                          order.billQuantityCopy
                                      ? Color(0xFF2ECEE0)
                                      : Color(0xFFFF9200))),
                          fontSize: 13,
                        ),
                      ),
                    if (status != TradeListStatus.history)
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () async {
                          ResponseModel response = await tradecancel(order.id);
                          toast(response.msg);
                        },
                        child: Text(
                          '撤销',
                          style: TextStyle(
                            color: Color(0xFF602FDA),
                            fontSize: 13,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 18),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFF6F6F6),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: '委托数量 ',
                          style: TextStyle(
                            color: Color(0xFF9C9EA6),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: order.billQuantityCopy.toString(),
                              style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [TextSpan(text: ' HFC')],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: '委托价格 ',
                          style: TextStyle(
                            color: Color(0xFF9C9EA6),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: order.billPrice.toString(),
                              style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [TextSpan(text: ' HFT')],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: '已成交量 ',
                          style: TextStyle(
                            color: Color(0xFF9C9EA6),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: order.deleted == 1
                                  ? order.billQuantityCopy.toString()
                                  : (order.billQuantityCopy -
                                          order.billQuantity)
                                      .toStringAsFixed(6),
                              style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [TextSpan(text: ' HFC')],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: '成交均价 ',
                          style: TextStyle(
                            color: Color(0xFF9C9EA6),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: order.billPrice.toString(),
                              style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [TextSpan(text: ' HFT')],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      order.billType == 0 || order.billType == 2
          ? Positioned(
              left: 5,
              top: 14,
              child: order.billType == 0
                  ? Image.asset(
                      'images/buy@2x.png',
                      width: 79,
                      height: 26,
                    )
                  : Image.asset(
                      'images/buy3@2x.png',
                      width: 79,
                      height: 26,
                    ),
            )
          : Positioned(
              left: 8,
              top: 14,
              child: order.billType == 1
                  ? Image.asset(
                      'images/sell@2x.png',
                      width: 73,
                      height: 24,
                    )
                  : Image.asset(
                      'images/sell3@2x.png',
                      width: 73,
                      height: 24,
                    ),
            )
    ],
  );
}

empty() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'images/empty@2x.png',
          width: 185,
          height: 105,
        ),
        Container(
          margin: EdgeInsets.only(top: 13),
          child: Text(
            '暂无记录',
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

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/api/tradedetail.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/model/tradechengjiao.dart';
import 'package:huofu/model/tradeorderdetail.dart';

class Detail extends StatefulWidget {
  final int id;
  const Detail({Key? key, required this.id}) : super(key: key);
  @override
  DetailState createState() => DetailState();
}

class DetailState extends State<Detail> {
  TradeOrderDetailModel? order;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _onRefresh(loading());
    });
  }

  void _onRefresh(ToastFuture t) {
    tradedetail(widget.id).then((value) {
      setState(() {
        order = value.data;
      });
      t.dismiss(showAnim: true);
    }).catchError((error) {
      t.dismiss(showAnim: true);
      toast(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF602FDA),
      appBar: AppBar(
        title: Text(
          '委托详情',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.dark,
        leading: IBackIcon(
          left: 16,
          style: 'white',
        ),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 75,
                          height: 20,
                        ),
                        order?.transbillEntity.billType == 0 ||
                                order?.transbillEntity.billType == 2
                            ? Positioned(
                                top: 0,
                                left: -3,
                                child: order?.transbillEntity.billType == 0
                                    ? Image.asset(
                                        'images/buy1@2x.png',
                                        width: 81,
                                        height: 26,
                                      )
                                    : Image.asset(
                                        'images/buy4@2x.png',
                                        width: 81,
                                        height: 26,
                                      ),
                              )
                            : Positioned(
                                top: 0,
                                left: 0,
                                child: order?.transbillEntity.billType == 1
                                    ? Image.asset(
                                        'images/sell1@2x.png',
                                        width: 75,
                                        height: 20,
                                      )
                                    : Image.asset(
                                        'images/sell4@2x.png',
                                        width: 75,
                                        height: 20,
                                      ),
                              )
                      ],
                    ),
                    Text(
                      order?.transbillEntity.revoked == 1
                          ? '已撤销'
                          : (order?.transbillEntity.deleted == 1
                              ? '完全成交'
                              : (order?.transbillEntity.billQuantity ==
                                      order?.transbillEntity.billQuantityCopy
                                  ? '未成交'
                                  : '部分成交')),
                      style: TextStyle(
                        color: Color(0xFFFF9200),
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '委托数量',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      (order?.transbillEntity.billQuantityCopy ?? 0)
                              .toString() +
                          ' HFC',
                      style: TextStyle(
                        color: Color(0xFF313333),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '已成交量',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      (order?.transbillEntity.deleted != 1
                              ? ((order?.transbillEntity.billQuantityCopy ??
                                          0) -
                                      (order?.transbillEntity.billQuantity ??
                                          0))
                                  .toStringAsFixed(6)
                              : (order?.transbillEntity.billQuantityCopy ?? 0)
                                  .toString()) +
                          ' HFC',
                      style: TextStyle(
                        color: Color(0xFF313333),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '委托价格',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      (order?.transbillEntity.billPrice ?? 0).toString() +
                          ' HFT',
                      style: TextStyle(
                        color: Color(0xFF313333),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '成交均价',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      (order?.transbillEntity.billPrice ?? 0).toString() +
                          ' HFT',
                      style: TextStyle(
                        color: Color(0xFF313333),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '委托时间',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      formatDate(
                          DateTime.fromMillisecondsSinceEpoch(
                              (order?.transbillEntity.createTime ?? 0) * 1000),
                          [mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
                      style: TextStyle(
                        color: Color(0xFF313333),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                color: Color(0xFFF6F6F6),
                height: 1,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '手续费',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      (order?.transbillEntity.sxfmoney ?? 0).toString() +
                          (order?.transbillEntity.billType == 0 ||
                                  order?.transbillEntity.billType == 2
                              ? ' HFC'
                              : ' HFT'),
                      style: TextStyle(
                        color: Color(0xFF313333),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '成交额',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      (order?.transbillEntity.deleted != 1
                              ? ((order?.transbillEntity.billQuantityCopy ??
                                          0) -
                                      (order?.transbillEntity.billQuantity ??
                                          0))
                                  .toString()
                              : (order?.transbillEntity.billQuantityCopy ?? 0)
                                  .toString()) +
                          ' HFC',
                      style: TextStyle(
                        color: Color(0xFF313333),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                color: Color(0xFFF6F6F6),
                height: 1,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '交易详情',
                      style: TextStyle(
                        color: Color(0xFF0D1333),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              ...(order?.list ?? []).map((e) {
                return item(e);
              })
            ],
          ),
        ),
      ),
    );
  }
}

item(TradeChengjiaoModel model) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Center(
                    child: Text(
                      '成交时间',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Center(
                    child: Text(
                      formatDate(model.cmcSj,
                          [mm, '-', dd, ' ', 'HH', ':', 'nn', ':', 'ss']),
                      style: TextStyle(
                        color: Color(0xFF313333),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Center(
                    child: Text(
                      '成交价格(HFT)',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Center(
                    child: Text(
                      model.cmcPrice.toString(),
                      style: TextStyle(
                        color: Color(0xFF313333),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Center(
                    child: Text(
                      '成交数量(HFC)',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Center(
                    child: Text(
                      model.cmcTransquantity.toString(),
                      style: TextStyle(
                        color: Color(0xFF313333),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        color: Color(0xFFF6F6F6),
        height: 1,
      ),
    ],
  );
}

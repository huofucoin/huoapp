import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/model/tradeprice.dart';

class KLineList1 extends StatefulWidget {
  final TradePriceModel? price;
  KLineList1({Key? key, this.price}) : super(key: key);
  @override
  State<StatefulWidget> createState() => KLineList1State();
}

class KLineList1State extends State<KLineList1> {
  List<Widget> deepOut() {
    List<String> list = (widget.price?.priceout.keys ?? ['', '', '', '', ''])
        .toList()
          ..sort((a, b) => a.compareTo(b));
    double max = 0;
    list.forEach((e) {
      max = max > (double.tryParse(widget.price?.priceout[e] ?? '0') ?? 0)
          ? max
          : (double.tryParse(widget.price?.priceout[e] ?? '0') ?? 0);
    });
    return list.map<Widget>((e) {
      return tradeItem(false, double.tryParse(e) ?? 0,
          double.tryParse(widget.price?.priceout[e] ?? '0') ?? 0, max);
    }).toList();
  }

  List<Widget> deepIn() {
    List<String> list = (widget.price?.pricein.keys ?? ['', '', '', '', ''])
        .toList()
          ..sort((a, b) => b.compareTo(a));
    double max = 0;
    list.forEach((e) {
      max = max > (double.tryParse(widget.price?.pricein[e] ?? '0') ?? 0)
          ? max
          : (double.tryParse(widget.price?.pricein[e] ?? '0') ?? 0);
    });
    return list.map<Widget>((e) {
      return tradeItem(true, double.tryParse(e) ?? 0,
          double.tryParse(widget.price?.pricein[e] ?? '0') ?? 0, max);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16),
                  width: double.infinity,
                  height: 40,
                  child: Row(
                    children: [
                      Text(
                        '买',
                        style: TextStyle(
                          color: Color(0xFF9C9EA6),
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
                ...deepIn()
              ],
            ),
          ),
          Container(
            width: 1,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 8),
                  width: double.infinity,
                  height: 40,
                  child: Row(
                    children: [
                      Text(
                        '卖',
                        style: TextStyle(
                          color: Color(0xFF9C9EA6),
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                ),
                ...deepOut()
              ],
            ),
          )
        ],
      ),
    );
  }
}

tradeItem(bool buy, double price, double count, double max) {
  max = max > 0 ? max : 1;
  return Stack(
    children: [
      Container(
        height: 31,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: buy
              ? [
                  Expanded(
                    child: Container(),
                    flex: 100 - ((count / max) * 100).truncate(),
                  ),
                  Expanded(
                    child: Container(
                      color: Color(0x1A16C9C5),
                    ),
                    flex: ((count / max) * 100).truncate(),
                  )
                ]
              : [
                  Expanded(
                    child: Container(
                      color: Color(0xFFFFE5F0),
                    ),
                    flex: ((count / max) * 100).truncate(),
                  ),
                  Expanded(
                    child: Container(),
                    flex: 100 - ((count / max) * 100).truncate(),
                  )
                ],
        ),
      ),
      Positioned(
        top: 0,
        bottom: 0,
        left: buy ? 16 : 4,
        right: buy ? 4 : 16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: buy
              ? [
                  Text(
                    count.toString(),
                    style: TextStyle(
                      color: Color(0xFF0D1333),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    price.toString(),
                    style: TextStyle(
                      color: Color(0xFF2ECEE0),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]
              : [
                  Text(
                    price.toString(),
                    style: TextStyle(
                      color: Color(0xFFEF3280),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    count.toString(),
                    style: TextStyle(
                      color: Color(0xFF0D1333),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
        ),
      ),
    ],
  );
}

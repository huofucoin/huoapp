import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/model/tradechengjiao.dart';

class KLineList2 extends StatefulWidget {
  final List<TradeChengjiaoModel> chengjiao;
  const KLineList2({Key? key, required this.chengjiao}) : super(key: key);
  @override
  State<StatefulWidget> createState() => KLineList2State();
}

class KLineList2State extends State<KLineList2> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(12),
        color: Color(0xFFFAFAFA),
        child: Table(
          children: [
            TableRow(
              children: [
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      '时间',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      '价格',
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(4),
                    child: Text(
                      '数量',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF9C9EA6),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ...widget.chengjiao.asMap().keys.map((key) {
              TradeChengjiaoModel model = widget.chengjiao[key];
              if (widget.chengjiao.length == key + 1) {
                return tradeItem(model, true);
              } else {
                TradeChengjiaoModel before = widget.chengjiao[key + 1];
                return tradeItem(model, before.cmcPrice < model.cmcPrice);
              }
            })
          ],
        ),
      ),
    );
  }
}

tradeItem(TradeChengjiaoModel model, bool buy) {
  return TableRow(
    children: [
      TableCell(
        child: Container(
          padding: EdgeInsets.all(4),
          child: Text(
            formatDate(model.cmcSj, ['HH', ':', 'nn', ':', 'ss']),
            style: TextStyle(
              color: Color(0xFF0D1333),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      TableCell(
        child: Container(
          padding: EdgeInsets.all(4),
          child: Text(
            model.cmcPrice.toString(),
            style: TextStyle(
              color: buy ? Color(0xFF2ECEE0) : Color(0xFFEF3280),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      TableCell(
        child: Container(
          padding: EdgeInsets.all(4),
          child: Text(
            model.cmcTransquantity.toString(),
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Color(0xFF0D1333),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ],
  );
}

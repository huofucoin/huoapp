import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/mine/customTabIndicator.dart';
import 'package:huofu/trade/tradeList.dart';

class TradeAll extends StatefulWidget {
  const TradeAll({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => TradeAllState();
}

class TradeAllState extends State with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('全部'),
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
              text: '当前委托',
            ),
            Tab(
              text: '历史委托',
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          TradeList(
            status: TradeListStatus.current,
            filter: true,
          ),
          TradeList(
            status: TradeListStatus.history,
            filter: true,
          )
        ],
      ),
    );
  }
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

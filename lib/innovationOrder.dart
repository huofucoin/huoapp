import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/wakuangdetail.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/model/wakuang.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InnovationOrder extends StatefulWidget {
  final int id;
  const InnovationOrder({Key? key, required this.id}) : super(key: key);
  @override
  InnovationOrderState createState() => InnovationOrderState();
}

class InnovationOrderState extends State<InnovationOrder> {
  WaKuangModel? wakuang;
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    wakuangdetail(widget.id).then((value) {
      setState(() {
        wakuang = value.data;
      });
      _refreshController.refreshCompleted();
    }).catchError((error) {
      _refreshController.refreshFailed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF602FDA),
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '订单详情',
          style: TextStyle(color: Colors.white),
        ),
        leading: IBackIcon(
          left: 16,
          style: 'white',
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: SmartRefresher(
          enablePullDown: true,
          header: WaterDropHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: Column(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    item('购买份额', (wakuang?.count ?? 0).toString() + ' 份'),
                    item('购买金额', (wakuang?.money ?? 0).toString() + ' HFC'),
                    item(
                        '管理费(' + ((wakuang?.sxfl ?? 0) * 100).toString() + '%)',
                        (wakuang?.sxf ?? 0).toString() + ' HFC'),
                    item('价格',
                        '1份=' + (wakuang?.unitprice ?? 0).toString() + ' HFC'),
                    item('回报率',
                        ((wakuang?.rates ?? 0) * 100).toString() + '%/天'),
                    item('挖矿期限', (wakuang?.days ?? 0).toString() + ' 天'),
                    item('预计总收益', (wakuang?.profit ?? 0).toString() + ' HFC'),
                    item('已产生收益', (wakuang?.yprofit ?? 0).toString() + ' HFC'),
                    item(
                        '下单时间',
                        formatDate((wakuang?.createtime ?? DateTime.now()), [
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
                        ])),
                    item(
                        '生效日',
                        formatDate((wakuang?.starttime ?? DateTime.now()), [
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
                        ])),
                    item(
                        '到期日',
                        formatDate((wakuang?.endtime ?? DateTime.now()), [
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
                        ])),
                    item('赎回方式', '到期自动赎回'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

item(String title, String subTitle) {
  return Container(
    padding: EdgeInsets.only(top: 8, bottom: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xFF9C9EA6),
            fontSize: 15,
          ),
        ),
        Text(
          subTitle,
          style: TextStyle(
            color: Color(0xFF313333),
            fontSize: 15,
          ),
        )
      ],
    ),
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KLineList3 extends StatefulWidget {
  const KLineList3({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => KLineList3State();
}

class KLineList3State extends State<KLineList3> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  'HFC,HFT简介',
                  style: TextStyle(
                    color: Color(0xFF0D1333),
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Huo Fu Coin',
                  style: TextStyle(
                    color: Color(0xFF9C9EA6),
                    fontSize: 15,
                  ),
                ),
                Text(
                  '简称HFC',
                  style: TextStyle(
                    color: Color(0xFF0D1333),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Huo Fu Token',
                  style: TextStyle(
                    color: Color(0xFF9C9EA6),
                    fontSize: 15,
                  ),
                ),
                Text(
                  '简称HFT',
                  style: TextStyle(
                    color: Color(0xFF0D1333),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  '简介',
                  style: TextStyle(
                    color: Color(0xFF0D1333),
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'HFC是火夫链上智能数字资产平台币（Huo Fu Coin）的简称，由火夫基金会发行，总量恒定3千万枚。基于火夫强大的用户基础，HFC在火夫完整的生态体系内流通。HFC将通过交易及挖矿、分享及挖矿等方式产出并通过增值付费业务、数字券商业务等消耗，为火夫商业服务项目的Token提供锁定的保证金机制，经纪业务的返佣奖励以及社区共建的市场营销奖励机制形成循环流动的经济模型。',
              style: TextStyle(
                color: Color(0xFF0D1333),
                fontSize: 15,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(
              'HFT是火夫基金会推出的基于稳定价值货币人民币（RMB）的代币，1HFT=1元，用户可以随时使用HFT与RMB进行1：1兑换。火夫基金会将严格遵守1：1准备保证金，即发行1个HFT，其银行账户就会增加1元的资金保障。',
              style: TextStyle(
                color: Color(0xFF0D1333),
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}

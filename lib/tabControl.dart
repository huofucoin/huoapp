import 'package:flutter/material.dart';
import 'package:huofu/asset.dart';
import 'package:huofu/home.dart';
import 'package:huofu/mine/mine.dart';
import 'package:huofu/order/order.dart';
import 'package:huofu/state/user.dart';
import 'package:huofu/trade/trade.dart';
import 'package:provider/provider.dart';

typedef void SwitchTabCallBack(int index);

class TabControl extends StatefulWidget {
  @override
  TabControlState createState() => TabControlState();
}

class TabControlState extends State with SingleTickerProviderStateMixin {
  TabController? tabController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this)
      ..addListener(
        () {
          if (tabController?.index.toDouble() ==
              tabController?.animation?.value) {
            if ((tabController?.index == 2 || tabController?.index == 3) &&
                !Provider.of<UserState>(context, listen: false).isLogin) {
              Navigator.of(context).pushNamed('/login');
              tabController?.animateTo(index);
            } else {
              setState(() {
                index = tabController?.index ?? 0;
              });
            }
          }
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [
          Home(
            callBack: (index) {
              tabController?.animateTo(index);
            },
          ),
          Trade(),
          Order(),
          Asset(
            callBack: (index) {
              tabController?.animateTo(index);
            },
          ),
          Mine()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -2),
              blurRadius: 8,
              spreadRadius: 0,
              color: Color(0x5CC7C3D0),
            )
          ],
        ),
        child: TabBar(
          indicatorColor: Color(0xFF602FDA),
          unselectedLabelColor: Color(0xFF0D1333),
          labelColor: Color(0xFF602FDA),
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          controller: tabController,
          tabs: [
            Tab(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      index == 0
                          ? 'images/tab1_hl@2x.png'
                          : 'images/tab1@2x.png',
                      width: 20,
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 1, bottom: 2),
                      child: Text('首页'),
                    )
                  ],
                ),
              ),
            ),
            Tab(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      index == 1
                          ? 'images/tab2_hl@2x.png'
                          : 'images/tab2@2x.png',
                      width: 20,
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 1, bottom: 2),
                      child: Text('交易'),
                    )
                  ],
                ),
              ),
            ),
            Tab(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      index == 2
                          ? 'images/tab3_hl@2x.png'
                          : 'images/tab3@2x.png',
                      width: 20,
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 1, bottom: 2),
                      child: Text('OTC'),
                    )
                  ],
                ),
              ),
            ),
            Tab(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      index == 3
                          ? 'images/tab4_hl@2x.png'
                          : 'images/tab4@2x.png',
                      width: 20,
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 1, bottom: 2),
                      child: Text('资产'),
                    )
                  ],
                ),
              ),
            ),
            Tab(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      index == 4
                          ? 'images/tab5_hl@2x.png'
                          : 'images/tab5@2x.png',
                      width: 20,
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 1, bottom: 2),
                      child: Text('我的'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

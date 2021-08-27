import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/iBackIcon.dart';

class Price extends StatefulWidget {
  @override
  PriceState createState() => PriceState();
}

class PriceState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('费率详情'),
        leading: IBackIcon(left: 16),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: 0,
                      color: Color(0x21C7C3D0))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '一、OTC交易',
                  style: TextStyle(
                    color: Color(0xFF0D1333),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(height: 16),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: settingItem(),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '购买费率：',
                        style: TextStyle(
                          color: Color(0xFF5F6173),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '免费',
                            style: TextStyle(color: Color(0xFF0D1333)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(height: 12),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: settingItem(),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '出售费率：',
                        style: TextStyle(
                          color: Color(0xFF5F6173),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '0.8%',
                            style: TextStyle(color: Color(0xFF0D1333)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: 0,
                      color: Color(0x21C7C3D0))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '二、币币交易费率',
                  style: TextStyle(
                    color: Color(0xFF0D1333),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(height: 16),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: settingItem(),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'maker费率：',
                        style: TextStyle(
                          color: Color(0xFF5F6173),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '0.15%',
                            style: TextStyle(color: Color(0xFF0D1333)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(height: 12),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      child: settingItem(),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'taker费率：',
                        style: TextStyle(
                          color: Color(0xFF5F6173),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: '0.20%',
                            style: TextStyle(color: Color(0xFF0D1333)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

settingItem() {
  return Container(
    width: 9,
    height: 9,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.5),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF0F0F0), Color(0xFFDDDDDD)],
      ),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 2),
          blurRadius: 3,
          spreadRadius: 0,
          color: Color(0x2B9B96A7),
        )
      ],
    ),
  );
}

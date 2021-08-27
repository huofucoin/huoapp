import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/iBackIcon.dart';

class Contact extends StatefulWidget {
  @override
  ContactState createState() => ContactState();
}

class ContactState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('联系我们'),
        leading: IBackIcon(left: 16),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 8,
                    spreadRadius: 0,
                    color: Color(0x21C7C3D0))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/qq@2x.png',
                        width: 24,
                        height: 24,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        width: 46,
                        child: Text(
                          'QQ',
                          style: TextStyle(
                            color: Color(0xFF0D1333),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        '3562879373',
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
                  height: 1,
                  color: Color(0xFFF6F6F6),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/wechat@2x.png',
                        width: 24,
                        height: 24,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        width: 46,
                        child: Text(
                          '微信',
                          style: TextStyle(
                            color: Color(0xFF0D1333),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        '15531465548',
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
                  height: 1,
                  color: Color(0xFFF6F6F6),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: Row(
                    children: [
                      Image.asset(
                        'images/email@2x.png',
                        width: 24,
                        height: 24,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        width: 46,
                        child: Text(
                          '邮箱',
                          style: TextStyle(
                            color: Color(0xFF0D1333),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        'help@huofu.pro',
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
            ),
          ),
        ],
      ),
    );
  }
}

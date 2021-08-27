import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/bangzhu.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/mine/helpDetail.dart';
import 'package:huofu/model/help.dart';

class Help extends StatefulWidget {
  @override
  HelpState createState() => HelpState();
}

class HelpState extends State {
  List<HelpModel> help = [];
  @override
  void initState() {
    super.initState();
    bangzhu().then((value) {
      setState(() {
        help = value.data ?? [];
      });
    }).catchError((error) {
      toast(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF602FDA),
      appBar: AppBar(
        title: Text(
          '帮助中心',
          style: TextStyle(color: Colors.white),
        ),
        brightness: Brightness.dark,
        leading: IBackIcon(
          left: 16,
          style: 'white',
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
            children: [
              ...help.asMap().keys.map((e) {
                HelpModel h = help[e];
                return Container(
                  decoration: BoxDecoration(
                    border: e > 0
                        ? Border(
                            top: BorderSide(color: Color(0xFFF6F6F6)),
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 79,
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        child: Column(
                          children: [
                            Image.network(
                              h.images,
                              width: 30,
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 4, bottom: 4),
                              child: Text(
                                h.name,
                                style: TextStyle(
                                  color: Color(0xFF0D1333),
                                  fontSize: 13,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(color: Color(0xFFF6F6F6)),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...h.articles.map((e) {
                                return GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return HelpDetail(
                                        article: e,
                                      );
                                    }));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                                    child: Text(
                                      e.title,
                                      style: TextStyle(
                                        color: Color(0xFF0D1333),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })
            ],
          ),
        ),
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

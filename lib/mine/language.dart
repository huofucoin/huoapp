import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/iBackIcon.dart';

class Language extends StatefulWidget {
  @override
  LanguageState createState() => LanguageState();
}

class LanguageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('多语言'),
        leading: IBackIcon(left: 16),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: 0,
                      color: Color(0x21C7C3D0),
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: settingItem('简体中文', true),
                  ),
                  Container(
                    height: 1,
                    color: Color(0xFFF6F6F6),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

settingItem(String title, bool selected) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: selected ? Color(0xFF602FDA) : Color(0xFF313333),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        selected
            ? Image.asset(
                'images/xuanze@2x.png',
                width: 20,
                height: 20,
              )
            : Container()
      ],
    ),
  );
}

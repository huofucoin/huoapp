import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/iBackIcon.dart';

class Security extends StatefulWidget {
  @override
  SecurityState createState() => SecurityState();
}

class SecurityState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        leading: IBackIcon(),
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(32, 20, 32, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '安全认证',
              style: TextStyle(
                color: Color(0xFF0D1333),
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '为了您的账号安全，本次登录需要进行验证；请将下方的图标移动到圆形区域内。',
              style: TextStyle(
                color: Color(0xFF0D1333),
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
                child: Container(
              child: Stack(
                children: [
                  Positioned(
                    top: 78,
                    right: 86,
                    child: Draggable(
                      data: 'guard',
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x66602FDA),
                              offset: Offset(0, 20),
                              blurRadius: 35,
                              spreadRadius: -10,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'images/guard@2x.png',
                          width: 72,
                          height: 72,
                        ),
                      ),
                      childWhenDragging: Container(),
                      feedback: Container(
                        child: Image.asset(
                          'images/guard@2x.png',
                          width: 72,
                          height: 72,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 90,
                    left: 8,
                    child: DragTarget(
                      builder: (_, __, ___) {
                        return Container(
                          child: Image.asset(
                            'images/target@2x.png',
                            width: 102,
                            height: 102,
                          ),
                        );
                      },
                      onWillAccept: (data) {
                        return true;
                      },
                      onAccept: (data) {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

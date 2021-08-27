import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

updateAlert(BuildContext context, String? url, bool force, String contents,
    String ver) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 280,
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
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFF1F1F1),
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '发现新版本',
                            style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4, bottom: 8),
                            child: Text(
                              '版本号：v' + ver,
                              style: TextStyle(
                                color: Color(0xFF5F6173),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            contents,
                            style: TextStyle(
                              color: Color(0xFF5F6173),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        if (!force)
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 56,
                                child: Center(
                                  child: Text(
                                    '知道了',
                                    style: TextStyle(
                                      color: Color(0xFF9C9EA6),
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (url != null) launch(url);
                            },
                            child: Container(
                              height: 56,
                              width: 140,
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Color(0xFFF1F1F1),
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '立即更新',
                                  style: TextStyle(
                                    color: Color(0xFF602FDA),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      );
    },
  );
}

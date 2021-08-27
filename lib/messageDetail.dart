import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/model/announcement.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MessageDetail extends StatefulWidget {
  final AnnouncementModel model;
  const MessageDetail({required this.model, Key? key}) : super(key: key);
  @override
  MessageDetailState createState() => MessageDetailState();
}

class MessageDetailState extends State<MessageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF602FDA),
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Color(0xFF602FDA),
        elevation: 0,
        title: Text(
          '公告详情',
          style: TextStyle(color: Colors.white),
        ),
        leading: IBackIcon(
          left: 16,
          style: 'white',
        ),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        child: WebView(
          initialUrl: '',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            webViewController.loadUrl(Uri.dataFromString(
              widget.model.contents,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ).toString());
          },
        ),
      ),
    );
  }
}

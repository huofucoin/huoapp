import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/model/help.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpDetail extends StatefulWidget {
  final ArticleModel article;
  const HelpDetail({required this.article, Key? key}) : super(key: key);
  @override
  HelpDetailState createState() => HelpDetailState();
}

class HelpDetailState extends State<HelpDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF602FDA),
      appBar: AppBar(
        title: Text(
          widget.article.title,
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
        child: WebView(
          initialUrl: '',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            webViewController.loadUrl(Uri.dataFromString(
              widget.article.contents,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ).toString());
          },
        ),
      ),
    );
  }
}

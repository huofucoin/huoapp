import 'dart:typed_data';
import 'dart:ui' as UI;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:huofu/api/share.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/mine/share1.dart';
import 'package:huofu/mine/share2.dart';
import 'package:huofu/mine/share3.dart';
import 'package:huofu/mine/share4.dart';
import 'package:huofu/model/share.dart';
import 'package:huofu/state/user.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Share extends StatefulWidget {
  @override
  ShareState createState() => ShareState();
}

class ShareState extends State {
  GlobalKey repaintKey = GlobalKey();
  ShareModel? shareModel;
  RefreshController _refreshController = RefreshController();

  Uint8List? img;

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    share().then((value) {
      setState(() {
        shareModel = value.data;
      });
      _refreshController.refreshCompleted();
    }).catchError((error) {
      print(error);
      _refreshController.refreshFailed();
    });
  }

  Future capturePng() async {
    try {
      RenderObject? boundary = repaintKey.currentContext?.findRenderObject();
      if (boundary is RenderRepaintBoundary) {
        UI.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData? byteData =
            await image.toByteData(format: UI.ImageByteFormat.png);
        setState(() {
          img = byteData?.buffer.asUint8List();
        });
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  void savePng() async {
    if (await Permission.storage.request().isGranted && img != null) {
      await ImageGallerySaver.saveImage(img!);
      toast('图片保存成功');
    }
  }

  void shareLinkDialog(String link) {
    var click = (String path) {
      Clipboard.setData(ClipboardData(text: link));
      launch(path);
    };
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('点击下方，复制内容分享'),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              click('weixin://');
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Image.asset(
                                    'images/share_wx.png',
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                                Text(
                                  '微信',
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              click('mqq://');
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Image.asset(
                                    'images/share_qq.png',
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                                Text(
                                  'QQ',
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              click('alipay://');
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16),
                                  child: Image.asset(
                                    'images/share_alipay.png',
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                                Text(
                                  '支付宝',
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void shareDialog() async {
    await capturePng();
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 350,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(64, 32, 64, 32),
                        child: img != null
                            ? ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                child: Image.memory(img!),
                              )
                            : null,
                      ),
                      Container(
                        child: Text('点击右上角保存图片，点击下方分享海报'),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                launch('weixin://');
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    child: Image.asset(
                                      'images/share_wx.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                  Text(
                                    '微信',
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                launch('mqq://');
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    child: Image.asset(
                                      'images/share_qq.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                  Text(
                                    'QQ',
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                launch('alipay://');
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    child: Image.asset(
                                      'images/share_alipay.png',
                                      width: 32,
                                      height: 32,
                                    ),
                                  ),
                                  Text(
                                    '支付宝',
                                    style: TextStyle(fontSize: 13),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    right: 64,
                    top: 32,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        savePng();
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Image.asset(
                          'images/download.png',
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var scale = MediaQuery.of(context).size.width / 375;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IBackIcon(
          left: 16,
          style: 'white',
        ),
      ),
      body: Consumer<UserState>(
        builder: (_, userInfo, __) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                width: 375,
                height: 598,
                child: RepaintBoundary(
                  key: repaintKey,
                  child: Stack(
                    children: [
                      Container(
                        child: Image.asset(
                          'images/link1@2x.png',
                          width: 375,
                          height: 598,
                        ),
                      ),
                      Positioned(
                        top: 85,
                        left: 27,
                        child: Image.asset(
                          'images/link2@2x.png',
                          width: 333,
                          height: 138,
                        ),
                      ),
                      Positioned(
                        top: 435,
                        left: 14,
                        child: Stack(
                          children: [
                            Image.asset(
                              'images/link3@2x.png',
                              width: 347,
                              height: 115,
                            ),
                            Positioned(
                              left: 34,
                              right: 34,
                              top: 20,
                              bottom: 26,
                              child: Container(
                                child: Row(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: QrImage(
                                        data:
                                            "http://invitation.huofu.ltd/#/share?code=" +
                                                (userInfo.userInfo?.codes ??
                                                    ""),
                                        backgroundColor: Colors.white,
                                        version: QrVersions.auto,
                                        padding: EdgeInsets.all(2),
                                      ),
                                    ),
                                    Container(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '扫码下载火夫APP',
                                            style: TextStyle(
                                              color: Color(0xFF0D1333),
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            strutStyle: StrutStyle(height: 1.5),
                                          ),
                                          Text(
                                            '一站式数字资产服务平台',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                            ),
                                            strutStyle: StrutStyle(height: 1.5),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
              ),
              SmartRefresher(
                enablePullDown: true,
                header: WaterDropHeader(),
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFF3458),
                          Color(0xFFFF8C4D),
                          Color(0xFFFFA26B),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            color: Colors.red,
                            child: AspectRatio(
                              aspectRatio: 0.928,
                              child: Image.asset(
                                'images/share@2x.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 309 * scale,
                          child: Container(
                            child: Image.asset(
                              'images/share1@2x.png',
                              width: 86,
                              height: 186,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 387 * scale),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 56,
                                    padding: EdgeInsets.only(
                                      left: 32,
                                      right: 32,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFFFFFFFF),
                                          Color(0xFFF1F1F1)
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(28),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 20),
                                            blurRadius: 35,
                                            spreadRadius: -10,
                                            color: Color(0x61C43B2C)),
                                        BoxShadow(
                                            offset: Offset(0, 1),
                                            blurRadius: 3,
                                            spreadRadius: 0,
                                            color: Color(0x14FF0000)),
                                        BoxShadow(
                                            offset: Offset(0, -1),
                                            blurRadius: 5,
                                            spreadRadius: 0,
                                            color: Color(0xFCFF7000)),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '我的邀请码',
                                          style: TextStyle(
                                            color: Color(0xFF0D1333),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 16),
                                          width: 1,
                                          height: 29,
                                          color: Color(0xFFD2D2D2),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 40, right: 40),
                                          child: Text(
                                            userInfo.userInfo?.codes ?? "",
                                            style: TextStyle(
                                              color: Color(0xFF0D1333),
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(
                                                text:
                                                    userInfo.userInfo?.codes ??
                                                        ""));
                                            toast('邀请码复制成功');
                                          },
                                          child: Image.asset(
                                            'images/share_add@2x.png',
                                            width: 25,
                                            height: 25,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Stack(
                                  children: [
                                    Image.asset('images/share2@2x.png'),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(30 * scale,
                                          67 * scale, 30 * scale, 62 * scale),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (_) {
                                                      return Share1();
                                                    }));
                                                  },
                                                  child: Column(
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          text: (shareModel
                                                                          ?.fcount ??
                                                                      0)
                                                                  .toString() +
                                                              ' ',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFED6C6C),
                                                            fontSize: 36,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: '人',
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '累计已实名好友',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF5C1313),
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          Image.asset(
                                                            'images/share_next@2x.png',
                                                            width: 14,
                                                            height: 14,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 1,
                                                height: 46.5,
                                                color: Color(0xFFDBC6C6),
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (_) {
                                                      return Share2();
                                                    }));
                                                  },
                                                  child: Column(
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          text: (shareModel
                                                                          ?.fmoney ??
                                                                      0)
                                                                  .toString() +
                                                              ' ',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFED6C6C),
                                                            fontSize: 36,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          children: [
                                                            TextSpan(
                                                              text: 'HFT',
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '累计奖励',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF5C1313),
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                          Image.asset(
                                                            'images/share_next@2x.png',
                                                            width: 14,
                                                            height: 14,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 32 * scale,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: 6,
                                                  right: 6,
                                                ),
                                                child: Image.asset(
                                                  'images/share_dot@2x.png',
                                                  width: 12,
                                                  height: 14,
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                '好友注册并完成实名认证，邀请人将获得2 HFT的奖励，被邀请人获得5 HFT的奖励；',
                                                style: TextStyle(
                                                    color: Color(0xFF441414),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ))
                                            ],
                                          ),
                                          Container(
                                            height: 32 * scale,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: 6,
                                                  right: 6,
                                                ),
                                                child: Image.asset(
                                                  'images/share_dot@2x.png',
                                                  width: 12,
                                                  height: 14,
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                '仅邀请一级好友时，邀请人将获得邀请奖励。',
                                                style: TextStyle(
                                                    color: Color(0xFF441414),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Stack(
                                  children: [
                                    Image.asset('images/share3@2x.png'),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(30 * scale,
                                          67 * scale, 30 * scale, 62 * scale),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return Share3();
                                              }));
                                            },
                                            child: Column(
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: (shareModel?.smoney ??
                                                                0)
                                                            .toString() +
                                                        ' ',
                                                    style: TextStyle(
                                                      color: Color(0xFFED6C6C),
                                                      fontSize: 36,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: 'HFT',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '好友交易奖励',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF5C1313),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      'images/share_next@2x.png',
                                                      width: 14,
                                                      height: 14,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 32 * scale,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: 6,
                                                  right: 6,
                                                ),
                                                child: Image.asset(
                                                  'images/share_dot@2x.png',
                                                  width: 12,
                                                  height: 14,
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                '好友在币币交易区的每一笔买入方向的交易（买入HFC），其直接上级将获得买入金额2‰-4‰的HFT奖励，间接上级将获得买入金额1‰的HFT奖励。',
                                                style: TextStyle(
                                                    color: Color(0xFF441414),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ))
                                            ],
                                          ),
                                          Container(
                                            height: 32 * scale,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: 6,
                                                  right: 6,
                                                ),
                                                child: Image.asset(
                                                  'images/share_dot@2x.png',
                                                  width: 12,
                                                  height: 14,
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                '团队成员持有HFC的总数量影响直接上级的奖励比例：',
                                                style: TextStyle(
                                                    color: Color(0xFF441414),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ))
                                            ],
                                          ),
                                          Container(
                                            height: 12 * scale,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 18,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                '团队持币数量1-100,000，直接上级奖励比例为2‰；\n团队持币数量100,001--1,000,000，直接上级奖励比例为3‰；\n团队持币数量1,000,001以上，直接上级奖励比例为4‰。',
                                                style: TextStyle(
                                                    color: Color(0xFF441414),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Stack(
                                  children: [
                                    Image.asset('images/share4@2x.png'),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(30 * scale,
                                          67 * scale, 30 * scale, 62 * scale),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                return Share4();
                                              }));
                                            },
                                            child: Column(
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    text: (shareModel?.tmoney ??
                                                                0)
                                                            .toString() +
                                                        ' ',
                                                    style: TextStyle(
                                                      color: Color(0xFFED6C6C),
                                                      fontSize: 36,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: 'HFC',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '好友理财奖励',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF5C1313),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      'images/share_next@2x.png',
                                                      width: 14,
                                                      height: 14,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 32 * scale,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: 6,
                                                  right: 6,
                                                ),
                                                child: Image.asset(
                                                  'images/share_dot@2x.png',
                                                  width: 12,
                                                  height: 14,
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                '好友每购买一次理财产品，其直接上级将获得投资金额2%-4%的HFC奖励，间接上级将获得投资金额1%的HFC奖励。',
                                                style: TextStyle(
                                                    color: Color(0xFF441414),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ))
                                            ],
                                          ),
                                          Container(
                                            height: 32 * scale,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: 6,
                                                  right: 6,
                                                ),
                                                child: Image.asset(
                                                  'images/share_dot@2x.png',
                                                  width: 12,
                                                  height: 14,
                                                ),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                '团队成员理财投资HFC的总业绩影响直接上级的奖励比例：',
                                                style: TextStyle(
                                                    color: Color(0xFF441414),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ))
                                            ],
                                          ),
                                          Container(
                                            height: 12 * scale,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 18,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                '团队投资业绩1-100,000，直接上级奖励比例为2%；\n团队投资业绩100,001--1,000,000，直接上级奖励比例为3%；\n团队投资业绩1,000,001以上，直接上级奖励比例为4%。',
                                                style: TextStyle(
                                                    color: Color(0xFF441414),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 40),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            shareDialog();
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFFF7B5C), Color(0xFFFF4C6C)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  color: Color(0x80FF2222),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '分享邀请海报',
                                style: TextStyle(
                                  color: Colors.white,
                                  shadows: [
                                    BoxShadow(
                                        offset: Offset(0, 2),
                                        blurRadius: 4,
                                        spreadRadius: 0,
                                        color: Color(0x80DF1F1F)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 12,
                      ),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            shareLinkDialog(
                                "http://invitation.huofu.ltd/#/share?code=" +
                                    (userInfo.userInfo?.codes ?? ""));
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFFF7B5C), Color(0xFFFF4C6C)],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  color: Color(0x80FF2222),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '复制邀请链接',
                                style: TextStyle(
                                  color: Colors.white,
                                  shadows: [
                                    BoxShadow(
                                      offset: Offset(0, 2),
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                      color: Color(0x80DF1F1F),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/mine.dart';
import 'package:huofu/api/version.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/mine/about.dart';
import 'package:huofu/mine/contact.dart';
import 'package:huofu/mine/help.dart';
import 'package:huofu/mine/language.dart';
import 'package:huofu/mine/mobileVerify.dart';
import 'package:huofu/mine/payment.dart';
import 'package:huofu/mine/price.dart';
import 'package:huofu/mine/setting.dart';
import 'package:huofu/mine/share.dart';
import 'package:huofu/mine/sign.dart';
import 'package:huofu/mine/updateAlert.dart';
import 'package:huofu/model/version.dart';
import 'package:huofu/state/user.dart';
import 'package:huofu/mine/verify.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class Mine extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State {
  VersionModel? ver;
  String v = 'Infinity';
  @override
  void initState() {
    super.initState();
    _onReload();
  }

  _onReload() {
    mine();
    version().then((value) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        v = packageInfo.buildNumber;
        ver = value.version;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF602FDA),
      body: Consumer<UserState>(
        builder: (_, userState, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 64,
              margin: EdgeInsets.fromLTRB(
                  32, 40 + MediaQuery.of(context).padding.top, 32, 40),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Image.asset(
                      userState.isLogin
                          ? 'images/head@2x.png'
                          : 'images/head_default@2x.png',
                      width: 64,
                      height: 64,
                    ),
                  ),
                  userState.isLogin
                      ? Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userState.userInfo?.username ?? '',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'UID: ' +
                                          (userState.userInfo?.userId ?? "")
                                              .toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return Sign();
                                  }));
                                },
                                child: Container(
                                  width: 56,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 2),
                                          blurRadius: 4,
                                          spreadRadius: 0,
                                          color: Color(0x4DEF3280))
                                    ],
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFFF861B6),
                                        Color(0xFFEF3280)
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      (userState.userInfo?.datas ?? "") ==
                                              formatDate(DateTime.now(),
                                                  [yyyy, '-', mm, '-', dd])
                                          ? '已签到'
                                          : '签到',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '登录或注册',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  color: Colors.white,
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ...(userState.isLogin
                        ? [
                            settingItem(
                                Image.asset(
                                  'images/setting@2x.png',
                                  width: 24,
                                  height: 24,
                                ),
                                '安全设置', () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return Setting();
                              }));
                            }),
                            settingItem(
                                Image.asset(
                                  'images/verify@2x.png',
                                  width: 24,
                                  height: 24,
                                ),
                                '身份认证', () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                if (userState.userInfo!.checks == 0) {
                                  return MobileVerify();
                                }
                                return Verify();
                              }));
                            }),
                            Container(
                              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              color: Color(0xFFF6F6F6),
                              height: 1,
                            ),
                            settingItem(
                                Image.asset(
                                  'images/invite@2x.png',
                                  width: 24,
                                  height: 24,
                                ),
                                '邀请好友', () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return Share();
                              }));
                            }),
                            settingItem(
                                Image.asset(
                                  'images/money@2x.png',
                                  width: 24,
                                  height: 24,
                                ),
                                '收款方式', () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                if (userState.userInfo!.checks == 0) {
                                  return MobileVerify();
                                } else if (userState.userInfo!.checks == 1) {
                                  return Verify();
                                }
                                return Payment();
                              }));
                            }),
                          ]
                        : []),
                    settingItem(
                        Image.asset(
                          'images/price@2x.png',
                          width: 24,
                          height: 24,
                        ),
                        '费率详情', () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Price();
                      }));
                    }),
                    settingItem(
                        Image.asset(
                          'images/language@2x.png',
                          width: 24,
                          height: 24,
                        ),
                        '多语言', () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Language();
                      }));
                    }),
                    // settingItem(
                    //     Image.asset(
                    //       'images/like@2x.png',
                    //       width: 24,
                    //       height: 24,
                    //     ),
                    //     '给火夫好评',
                    //     () {}),
                    settingItem(
                      Image.asset(
                        'images/version@2x.png',
                        width: 24,
                        height: 24,
                      ),
                      '版本',
                      () async {
                        // 网络请求最新版本号，如果需要更新则弹出对话框提示更新
                        if (ver == null) {
                          _onReload();
                          toast('正在检查新版本');
                        } else {
                          if ((int.tryParse(ver?.vercode ?? '0') ?? 0) >
                              (int.tryParse(v) ?? double.infinity)) {
                            updateAlert(context, ver?.appurl, ver?.isforce == 2,
                                ver?.contents ?? '', ver?.vername ?? v);
                          } else {
                            updateNoNeed(context);
                          }
                        }
                      },
                    ),
                    settingItem(
                        Image.asset(
                          'images/contact@2x.png',
                          width: 24,
                          height: 24,
                        ),
                        '联系我们', () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Contact();
                      }));
                    }),
                    settingItem(
                        Image.asset(
                          'images/about@2x.png',
                          width: 24,
                          height: 24,
                        ),
                        '关于我们', () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return About();
                      }));
                    }),
                    settingItem(
                        Image.asset(
                          'images/help@2x.png',
                          width: 24,
                          height: 24,
                        ),
                        '帮助中心', () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Help();
                      }));
                    }),
                    userState.isLogin
                        ? GestureDetector(
                            child: Container(
                              child: Center(
                                child: Text(
                                  '退出登录',
                                  style: TextStyle(
                                    color: Color(0xFF313333),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              margin: EdgeInsets.fromLTRB(16, 17, 16, 17),
                              height: 44,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.fromBorderSide(
                                    BorderSide(
                                        color: Color(0xFFF6F6F6),
                                        style: BorderStyle.solid,
                                        width: 1),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromARGB(54, 101, 69, 181),
                                        offset: Offset(0, 2),
                                        blurRadius: 8,
                                        spreadRadius: -2)
                                  ]),
                            ),
                            onTap: () {
                              userState.logout();
                            },
                          )
                        : Container()
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

settingItem(Image icon, String title, GestureTapCallback onTap) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: onTap,
    child: Container(
      height: 56,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        children: [
          icon,
          Container(
            width: 8,
          ),
          Expanded(
              child: Text(
            title,
            style: TextStyle(
              color: Color(0xFF313333),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          )),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(0xFFD2D2D2),
          )
        ],
      ),
    ),
  );
}

updateNoNeed(BuildContext context) {
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
                            '当前已经是最新版本',
                            style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pop(context);
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
                                  '我知道了',
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

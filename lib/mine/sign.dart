import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huofu/api/sign.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/mine/signDetail.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/userinfo.dart';
import 'package:huofu/state/user.dart';
import 'package:provider/provider.dart';

const List arr = [0.1, 0.1, 0.2, 0.2, 0.3, 0.3, 0.5];

class Sign extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
}

class _SignState extends State {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (_, userInfo, __) {
        int count = userInfo.userInfo?.conut ?? 0;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            brightness: Brightness.dark,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              '签到',
              style: TextStyle(color: Colors.white),
            ),
            leading: IBackIcon(
              left: 16,
              style: 'white',
            ),
            actions: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return SignDetail();
                  }));
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      '签到明细',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.245,
                      child: Image.asset(
                        'images/sign_bg@2x.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: MediaQuery.of(context).padding,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Container(
                      height: kToolbarHeight,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'images/head@2x.png',
                                    width: 56,
                                    height: 56,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 12, right: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '已连续签到 ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: count.toString(),
                                                  style: TextStyle(
                                                    color: Color(0xFFFF9200),
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' 天',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 4,
                                          ),
                                          Text(
                                            '明日签到可获得 +' +
                                                arr[count >= 7 ? 0 : count]
                                                    .toString() +
                                                ' HFT',
                                            style: TextStyle(
                                              color: Color(0x80FFFFFF),
                                              fontSize: 13,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      ResponseModel<UserInfoModel> data =
                                          await sign();
                                      if (data.code == 0 && data.data != null) {
                                        UserInfoModel user = data.data!;
                                        signSuccessAlert(
                                            context,
                                            (user.conut).toString(),
                                            (user.conut > 0
                                                    ? arr[user.conut - 1]
                                                    : 0)
                                                .toString());
                                      } else {
                                        toast(data.msg);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(9, 5, 9, 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          border: Border.all(
                                              color: Colors.white,
                                              width: 1,
                                              style: BorderStyle.solid)),
                                      child: Text(
                                        (userInfo.userInfo?.datas ?? "") ==
                                                formatDate(DateTime.now(),
                                                    [yyyy, '-', mm, '-', dd])
                                            ? '已签到'
                                            : '签到',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 6),
                                        blurRadius: 10,
                                        spreadRadius: 0,
                                        color: Color(0x21C7C3D0))
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    '连续签到领好礼',
                                    style: TextStyle(
                                      color: Color(0xFF0D1333),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    height: 16,
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      signItem(1, count),
                                      Expanded(
                                        flex: 4,
                                        child: Container(),
                                      ),
                                      signItem(2, count),
                                      Expanded(
                                        flex: 4,
                                        child: Container(),
                                      ),
                                      signItem(3, count),
                                      Expanded(
                                        flex: 4,
                                        child: Container(),
                                      ),
                                      signItem(4, count)
                                    ],
                                  ),
                                  Container(
                                    height: 9,
                                  ),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      signItem(5, count),
                                      Expanded(
                                        flex: 4,
                                        child: Container(),
                                      ),
                                      signItem(6, count),
                                      Expanded(
                                        flex: 4,
                                        child: Container(),
                                      ),
                                      signItem(7, count)
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 18, right: 18),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 6),
                                              blurRadius: 10,
                                              spreadRadius: 0,
                                              color: Color(0x21C7C3D0),
                                            )
                                          ]),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: 6,
                                              right: 10,
                                            ),
                                            child: Image.asset(
                                              'images/dot@2x.png',
                                              width: 13,
                                              height: 16,
                                            ),
                                          ),
                                          Text(
                                            '签到规则',
                                            style: TextStyle(
                                              color: Color(0xFF0D1333),
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: 6,
                                              left: 10,
                                            ),
                                            child: Image.asset(
                                              'images/dot@2x.png',
                                              width: 13,
                                              height: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(16, 8, 16, 24),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 6),
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                      color: Color(0x21C7C3D0),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 6,
                                            right: 2,
                                          ),
                                          child: Image.asset(
                                            'images/dot@2x.png',
                                            width: 13,
                                            height: 16,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '同一账号每天可签到1次，签到可以获得HFT，直接发放至用户可用余额；根据用户连续签到的天数，每日HFT发放的数量不同',
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 30,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 6,
                                            right: 2,
                                          ),
                                          child: Image.asset(
                                            'images/dot@2x.png',
                                            width: 13,
                                            height: 16,
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                                '连续签到规则\n第一天，赠送0.1个HFT\n第二天，赠送0.1个HFT\n第三天，赠送0.2个HFT\n第四天，赠送0.2个HFT\n第五天，赠送0.3个HFT\n第六天，赠送0.3个HFT\n第七天，赠送0.5个HFT'))
                                      ],
                                    ),
                                    Container(
                                      height: 30,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 6,
                                            right: 2,
                                          ),
                                          child: Image.asset(
                                            'images/dot@2x.png',
                                            width: 13,
                                            height: 16,
                                          ),
                                        ),
                                        Expanded(
                                            child: Text(
                                                '签到需连续，中间任意断签，则重新开始计算连续签到天数；\n7天为一个签到周期'))
                                      ],
                                    )
                                  ],
                                ),
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
        );
      },
    );
  }
}

signItem(int index, int count) {
  return Expanded(
    flex: index == 7 ? 46 : 21,
    child: index <= count
        ? Container(
            height: 92,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  spreadRadius: -10,
                  color: Color(0x80FFDC00),
                )
              ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFFB834), Color(0xFFFF40C9)]),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 21,
                    decoration: BoxDecoration(
                      color: Color(0x10523991),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        index == 7
                            ? 'HFT 大礼包'
                            : (arr[index - 1].toString() + ' HFT'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: -32,
                  right: -32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/icon_hl@2x.png',
                        width: 64,
                        height: 65,
                      ),
                      index == 7
                          ? Text(
                              'X 0.5',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 8,
                  child: Text(
                    '0' + index.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          )
        : Container(
            height: 92,
            decoration: BoxDecoration(
              color: Color(0x10523991),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 21,
                    decoration: BoxDecoration(
                      color: Color(0x10523991),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        index == 7
                            ? 'HFT 大礼包'
                            : (arr[index - 1].toString() + ' HFT'),
                        style: TextStyle(
                          color: Color(0xFF5F6173),
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: -32,
                  right: -32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/icon@2x.png',
                        width: 64,
                        height: 65,
                      ),
                      index == 7
                          ? Text(
                              'X 0.5',
                              style: TextStyle(
                                color: Color(0xFF5F6173),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 8,
                  child: Text(
                    '0' + index.toString(),
                    style: TextStyle(
                      color: Color(0xFF5F6173),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
  );
}

signSuccessAlert(BuildContext context, String days, String gift) {
  showDialog(
    context: context,
    builder: (_) {
      return Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: -100,
              right: -100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 349,
                        height: 402,
                        child: Image.asset(
                          'images/sign_alert_bg@2x.png',
                          width: 349,
                          height: 402,
                        ),
                      ),
                      Positioned(
                        top: -145,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/sign_icon@2x.png',
                              width: 342,
                              height: 344,
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -15,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Image.asset(
                                  'images/sign_close@2x.png',
                                  width: 23,
                                  height: 23,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 120,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Text(
                              '恭喜签到成功',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '已连续签到' + days + '天',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 258,
                        left: 120,
                        right: 75,
                        child: Container(
                          height: 33,
                          child: Center(
                            child: Text(
                              '获得 ' + gift + ' HFT',
                              style: TextStyle(
                                color: Color(0xFFFF9200),
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
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
        ),
      );
    },
  );
}

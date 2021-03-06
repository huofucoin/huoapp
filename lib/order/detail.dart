import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/api/ordercancel.dart';
import 'package:huofu/api/orderconfirm.dart';
import 'package:huofu/api/orderdetail.dart';
import 'package:huofu/api/orderpay.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton3.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/model/order.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/order/list.dart';
import 'package:huofu/order/orderConfirm.dart';

class Detail extends StatefulWidget {
  final int orderid;
  const Detail({required this.orderid, Key? key}) : super(key: key);
  @override
  DetailState createState() => DetailState();
}

class DetailState extends State<Detail> {
  bool buy = true;
  String count = '';
  int payment = 0;
  OrderModel? order;
  Timer? timer;
  int second = 900000;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateTimer(order?.createtime);
    });
    _reload();
  }

  void _reload() {
    orderdetail(widget.orderid).then((value) {
      setState(() {
        order = value.data;
      });
    }).catchError((error) {
      toast(error.toString());
    });
  }

  void updateTimer(DateTime? createTime) {
    if (createTime != null) {
      int s = DateTime.now().millisecondsSinceEpoch -
          createTime.millisecondsSinceEpoch;
      setState(() {
        second = s > 900000 ? 0 : 900000 - s;
      });
      if (second == 0 || !isBuyOrder()) {
        _reload();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  int status() {
    return order?.status ?? 0;
  }

  bool isBuyOrder() {
    return (order?.ordertype ?? 1) == 1;
  }

  List<Color> backgroundColor(int status) {
    switch (status) {
      case 2:
        return [Color(0xFF995CEF), Color(0xFF602FDA)];
      case 3:
      case 4:
      case 5:
        return [Color(0xFF5BE9F2), Color(0xFF42DAE8), Color(0xFF2ECEE0)];
      case 1:
      case 6:
      default:
        return [Color(0xFFFFC400), Color(0xFFFF9200)];
    }
  }

  List<Widget> payInfo(int paytype) {
    List<Widget> items = [
      Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isBuyOrder() ? '??????????????????' : '??????????????????',
              style: textStyle(),
            ),
            Text(
              paytype == 2 ? '??????' : (paytype == 3 ? '?????????' : '?????????'),
              style: textStyle(),
            )
          ],
        ),
      ),
      if (isBuyOrder())
        Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '??????',
                style: textStyle1,
              ),
              Row(
                children: [
                  Text(
                    order?.username ?? '',
                    style: textStyle2,
                  ),
                  Container(
                    width: 9,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: order?.username ?? ''));
                      toast('????????????');
                    },
                    child: Image.asset(
                      'images/share_add_hl@2x.png',
                      width: 15,
                      height: 15,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
    ];
    switch (paytype) {
      case 1:
        items.addAll([
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '????????????',
                  style: textStyle1,
                ),
                Row(
                  children: [
                    Text(
                      order?.cardnumber ?? '',
                      style: textStyle2,
                    ),
                    Container(
                      width: 9,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: order?.cardnumber ?? ''));
                        toast('????????????');
                      },
                      child: Image.asset(
                        'images/share_add_hl@2x.png',
                        width: 15,
                        height: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '????????????',
                  style: textStyle1,
                ),
                Row(
                  children: [
                    Text(
                      order?.bankname ?? '',
                      style: textStyle2,
                    ),
                    Container(
                      width: 9,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: order?.bankname ?? ''));
                        toast('????????????');
                      },
                      child: Image.asset(
                        'images/share_add_hl@2x.png',
                        width: 15,
                        height: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '????????????',
                  style: textStyle1,
                ),
                Row(
                  children: [
                    Text(
                      order?.batchbank ?? '',
                      style: textStyle2,
                    ),
                    Container(
                      width: 9,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: order?.batchbank ?? ''));
                        toast('????????????');
                      },
                      child: Image.asset(
                        'images/share_add_hl@2x.png',
                        width: 15,
                        height: 15,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ]);
        break;
      case 2:
      case 3:
        items.addAll(
          [
            Container(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '??????',
                    style: textStyle1,
                  ),
                  Row(
                    children: [
                      Text(
                        order?.numbers ?? '',
                        style: textStyle2,
                      ),
                      Container(
                        width: 9,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: order?.numbers ?? ''));
                          toast('????????????');
                        },
                        child: Image.asset(
                          'images/share_add_hl@2x.png',
                          width: 15,
                          height: 15,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '?????????',
                  style: textStyle1,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FractionallySizedBox(
                              widthFactor: 0.65,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(order?.images ?? ''),
                              ),
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: EdgeInsets.all(18),
                                child: Image.asset(
                                  'images/sign_close@2x.png',
                                  width: 23,
                                  height: 23,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                    child: Image.asset(
                      'images/qrcode@2x.png',
                      width: 15,
                      height: 15,
                    ),
                  ),
                )
              ],
            ),
          ],
        );
        break;
    }
    items.addAll([
      if (isBuyOrder())
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFF6F6F6),
          ),
          child: Column(
            children: [
              Text(
                '????????????',
                style: textStyle(fontSize: 15),
              ),
              Container(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '* ',
                    style: textStyle3,
                  ),
                  Expanded(
                    child: Text(
                      '????????????????????????????????????????????????????????????????????????????????????????????????',
                      style: textStyle3,
                    ),
                  )
                ],
              ),
              Container(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '* ',
                    style: textStyle3,
                  ),
                  Expanded(
                    child: Text(
                      '??????????????????????????????????????????????????????????????????????????????????????????????????????',
                      style: textStyle3,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      Container(
        height: 16,
      ),
      Text(
        '????????????',
        style: textStyle(),
      ),
      Container(
        height: 8,
      ),
    ]);
    return items;
  }

  Widget header(int status) {
    switch (status) {
      case 2:
        return Container(
          margin: EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: Row(
            children: [
              Image.asset(
                'images/done@2x.png',
                width: 32,
                height: 32,
              ),
              Container(
                width: 16,
              ),
              Text(
                '?????????',
                style: TextStyle(
                  shadows: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: Color(0xB2602FDA),
                    )
                  ],
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        );
      case 3:
        return Container(
          margin: EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: Row(
            children: [
              Image.asset(
                'images/alert@2x.png',
                width: 32,
                height: 32,
              ),
              Container(
                width: 16,
              ),
              Text(
                '???????????????',
                style: TextStyle(
                  shadows: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: Color(0x8A1CAABB),
                    )
                  ],
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        );
      case 4:
        return Container(
          margin: EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: Row(
            children: [
              Image.asset(
                'images/alert@2x.png',
                width: 32,
                height: 32,
              ),
              Container(
                width: 16,
              ),
              Text(
                '????????????',
                style: TextStyle(
                  shadows: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: Color(0x8A1CAABB),
                    )
                  ],
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        );
      case 5:
        return Container(
          margin: EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: Row(
            children: [
              Image.asset(
                'images/alert@2x.png',
                width: 32,
                height: 32,
              ),
              Container(
                width: 16,
              ),
              Text(
                '????????????',
                style: TextStyle(
                  shadows: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 0,
                      color: Color(0x8A1CAABB),
                    )
                  ],
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        );
      case 1:
        return Container(
          margin: EdgeInsets.fromLTRB(32, 16, 32, 16),
          height: 64,
          child: Row(
            children: [
              Image.asset(
                'images/wait@2x.png',
                width: 64,
                height: 64,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isBuyOrder() ? '?????????' : '???????????????',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        isBuyOrder()
                            ? ('?????? ' +
                                formatDate(
                                    DateTime.fromMillisecondsSinceEpoch(second),
                                    ['nn', ':', 'ss']) +
                                ' ??????????????????')
                            : formatDate(
                                    DateTime.fromMillisecondsSinceEpoch(second),
                                    ['nn', ':', 'ss']) +
                                ' ???????????????????????????',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case 6:
        return Container(
          margin: EdgeInsets.fromLTRB(32, 16, 32, 16),
          height: 64,
          child: Row(
            children: [
              Image.asset(
                'images/wait@2x.png',
                width: 64,
                height: 64,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isBuyOrder() ? '??????????????????' : '?????????',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        isBuyOrder()
                            ? '??????????????????????????????????????????????????????????????????'
                            : '??????????????????????????????????????????',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        return Container();
    }
  }

  Widget footer(int status) {
    if (isBuyOrder() && status == 1) {
      return Container(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -2),
              blurRadius: 8,
              spreadRadius: 0,
              color: Color(0xFFC7C3D0),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: IButton3(
                type: '??????',
                label: RichText(
                  text: TextSpan(
                    text: '???????????? ',
                    style: TextStyle(
                      color: Color(0xFF313333),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: formatDate(
                            DateTime.fromMillisecondsSinceEpoch(second),
                            ['nn', ':', 'ss']),
                        style: TextStyle(
                          color: Color(0xFF602FDA),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                fieldCallBack: () async {
                  loading();
                  ResponseModel<OrderModel> response =
                      await ordercancel(order?.id ?? 0);
                  ToastManager().dismissAll(showAnim: true);
                  if (response.code == 0 && response.data != null) {
                    setState(() {
                      order = response.data;
                    });
                  } else {
                    toast(response.msg);
                  }
                },
              ),
            ),
            Container(
              width: 13,
            ),
            Expanded(
              child: IButton3(
                label: Text(
                  '?????????????????????',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                fieldCallBack: () async {
                  loading();
                  ResponseModel<OrderModel> response =
                      await orderpay(order?.id ?? 0);
                  ToastManager().dismissAll(showAnim: true);
                  if (response.code == 0 && response.data != null) {
                    setState(() {
                      order = response.data;
                    });
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (_) {
                      return OrderList();
                    }));
                  } else {
                    toast(response.msg);
                  }
                },
              ),
            ),
          ],
        ),
      );
    }
    if (!isBuyOrder() && status == 6) {
      return Container(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -2),
              blurRadius: 8,
              spreadRadius: 0,
              color: Color(0xFFC7C3D0),
            )
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: IButton3(
                label: Text(
                  '?????????????????????',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                fieldCallBack: () async {
                  String? zjpassword = await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) {
                    return OrderConfirm();
                  }));
                  if (zjpassword != null) {
                    loading();
                    ResponseModel<OrderModel> response =
                        await orderconfirm(order?.id ?? 0, zjpassword);
                    ToastManager().dismissAll(showAnim: true);
                    if (response.code == 0 && response.data != null) {
                      setState(() {
                        order = response.data;
                      });
                    } else {
                      toast(response.msg);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }

  Widget body(int status) {
    List<Widget> items = [];
    switch (status) {
      case 1:
      case 6:
        items.add(Container(
          padding: EdgeInsets.only(bottom: 20),
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFF6F6F6),
                style: BorderStyle.solid,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '??? ' + (order?.money ?? 0.00).toString(),
                style: TextStyle(
                  color: Color(0xFF0D1333),
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Clipboard.setData(
                      ClipboardData(text: (order?.money ?? 0.00).toString()));
                  toast('????????????');
                },
                child: Image.asset(
                  'images/share_add_hl@2x.png',
                  width: 25,
                  height: 25,
                ),
              ),
            ],
          ),
        ));
        break;
      case 2:
      case 3:
      case 4:
      case 5:
        items.add(
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '????????????',
                  style: textStyle1,
                ),
                Text(
                  (order?.money ?? 0).toString() + ' CNY',
                  style: TextStyle(
                    color: Color(0xFF602FDA),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        );
    }
    switch (status) {
      case 1:
      case 6:
        items.addAll(payInfo(order?.paytype ?? 1));
        break;
    }
    if (!isBuyOrder()) {
      switch (status) {
        case 1:
        case 6:
          items.add(Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '????????????',
                  style: textStyle1,
                ),
                Text(
                  (order?.buyname ?? ''),
                  style: textStyle2,
                )
              ],
            ),
          ));
          break;
      }
    }
    items.addAll([
      Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '??????',
              style: textStyle1,
            ),
            Text(
              '???' + (order?.unitmoney ?? 0.00).toString(),
              style: textStyle2,
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '????????????',
              style: textStyle1,
            ),
            Text(
              (order?.count ?? 0).toString() + ' HFT',
              style: textStyle2,
            )
          ],
        ),
      ),
    ]);
    if (!isBuyOrder()) {
      items.add(Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '?????????(0.8%)',
              style: textStyle1,
            ),
            Text(
              (order?.sxfmoney ?? 0).toString() + ' HFT',
              style: textStyle2,
            )
          ],
        ),
      ));
    }
    switch (status) {
      case 1:
      case 6:
        items.add(Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '????????????',
                style: textStyle1,
              ),
              Text(
                (order?.money ?? 0).toString() + ' CNY',
                style: textStyle2,
              )
            ],
          ),
        ));
        break;
    }
    items.addAll([
      Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '????????????',
              style: textStyle1,
            ),
            Text(
              formatDate(order?.createtime.toLocal() ?? DateTime.now(), [
                'yyyy',
                '-',
                'mm',
                '-',
                'dd',
                ' ',
                'HH',
                ':',
                'nn',
                ':',
                'ss'
              ]),
              style: textStyle2,
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '????????????',
              style: textStyle1,
            ),
            Text(
              order?.ordernumber ?? '',
              style: textStyle2,
            )
          ],
        ),
      )
    ]);
    switch (status) {
      case 2:
        items.addAll([
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '????????????',
                  style: textStyle1,
                ),
                Text(
                  formatDate(order?.paytime?.toLocal() ?? DateTime.now(), [
                    'yyyy',
                    '-',
                    'mm',
                    '-',
                    'dd',
                    ' ',
                    'HH',
                    ':',
                    'nn',
                    ':',
                    'ss'
                  ]),
                  style: textStyle2,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '????????????',
                  style: textStyle1,
                ),
                Text(
                  formatDate(order?.successtime?.toLocal() ?? DateTime.now(), [
                    'yyyy',
                    '-',
                    'mm',
                    '-',
                    'dd',
                    ' ',
                    'HH',
                    ':',
                    'nn',
                    ':',
                    'ss'
                  ]),
                  style: textStyle2,
                )
              ],
            ),
          )
        ]);
        break;
      case 3:
      case 4:
      case 5:
        items.add(Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '????????????',
                style: textStyle1,
              ),
              Text(
                formatDate(order?.cancletime?.toLocal() ?? DateTime.now(), [
                  'yyyy',
                  '-',
                  'mm',
                  '-',
                  'dd',
                  ' ',
                  'HH',
                  ':',
                  'nn',
                  ':',
                  'ss'
                ]),
                style: textStyle2,
              )
            ],
          ),
        ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          isBuyOrder() ? '????????????' : '????????????',
          style: TextStyle(color: Colors.white),
        ),
        leading: IBackIcon(
          left: 16,
          style: 'white',
        ),
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + kToolbarHeight),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: backgroundColor(status()),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header(status()),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                          child: body(status()),
                        ),
                      ),
                    ),
                    footer(status())
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

textStyle({double fontSize = 17}) {
  return TextStyle(
    color: Color(0xFF0D1333),
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
  );
}

const textStyle1 = TextStyle(
  color: Color(0xFF9C9EA6),
  fontSize: 15,
  fontWeight: FontWeight.w400,
);

const textStyle2 = TextStyle(
  color: Color(0xFF313333),
  fontSize: 15,
  fontWeight: FontWeight.w400,
);

const textStyle3 = TextStyle(
  color: Color(0xFF5F6173),
  fontSize: 13,
  fontWeight: FontWeight.w400,
);

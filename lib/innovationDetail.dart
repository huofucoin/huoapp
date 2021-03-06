import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huofu/api/jiaocangdetail.dart';
import 'package:huofu/api/jiaocangprofit.dart';
import 'package:huofu/api/jiaocangsxf.dart';
import 'package:huofu/api/wakuang.dart';
import 'package:huofu/api/zichan.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/iTextField.dart';
import 'package:huofu/innovationOrder.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/model/jiaocang.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/wakuang.dart';
import 'package:huofu/model/zichan.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InnovationDetail extends StatefulWidget {
  final int id;
  const InnovationDetail({Key? key, required this.id}) : super(key: key);
  @override
  _InnovationDetailState createState() => _InnovationDetailState();
}

class _InnovationDetailState extends State<InnovationDetail> {
  String count = '';
  String sxf = '';
  String profit = '';

  JiaoCangModel? jiaocang;
  ZiChanModel? zichans;
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  void _onRefresh() {
    zichan().then((value) {
      value.data?.forEach((e) {
        if (e.coinName == 'HFC') {
          setState(() {
            zichans = e;
          });
        }
      });
    });
    jiaocangdetail(widget.id).then((value) {
      setState(() {
        jiaocang = value.data;
      });
      _refreshController.refreshCompleted();
    }).catchError((error) {
      _refreshController.refreshFailed();
    });
  }

  void onCreateOrder() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 44),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 8, bottom: 17),
                          child: Text(
                            '????????????',
                            style: TextStyle(
                              color: Color(0xFF0D1333),
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFEDE6FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '????????????',
                                  style: TextStyle(
                                    color: Color(0xFFAF97EC),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Container(
                                  width: 10,
                                ),
                                Text(
                                  ((double.tryParse(count) ?? 0) *
                                              (jiaocang?.coinnumber ?? 0))
                                          .toString() +
                                      ' HFC',
                                  style: TextStyle(
                                    color: Color(0xFF602FDA),
                                    fontSize: 26,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 24),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFF6F6F6),
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '????????????',
                                      style: TextStyle(
                                        color: Color(0xFF9C9EA6),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      (count.length > 0 ? count : '--') + ' ???',
                                      style: TextStyle(
                                        color: Color(0xFF0D1333),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFF6F6F6),
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '?????????',
                                      style: TextStyle(
                                        color: Color(0xFF9C9EA6),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      (double.tryParse(sxf)?.toString() ??
                                              '--') +
                                          ' HFC',
                                      style: TextStyle(
                                        color: Color(0xFF0D1333),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFFF6F6F6),
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '???????????????',
                                      style: TextStyle(
                                        color: Color(0xFF9C9EA6),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      (double.tryParse(profit)?.toString() ??
                                              '--') +
                                          ' HFC',
                                      style: TextStyle(
                                        color: Color(0xFF0D1333),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '?????????',
                                      style: TextStyle(
                                        color: Color(0xFF9C9EA6),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      formatDate(
                                              DateTime.now()
                                                  .add(Duration(days: 1)),
                                              [
                                                'yyyy',
                                                '-',
                                                'mm',
                                                '-',
                                                'dd',
                                              ]) +
                                          ' 00:00:00',
                                      style: TextStyle(
                                        color: Color(0xFF0D1333),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '?????????',
                                      style: TextStyle(
                                        color: Color(0xFF9C9EA6),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      formatDate(
                                              DateTime.now().add(Duration(
                                                  days: 1 +
                                                      (jiaocang?.days ?? 0))),
                                              [
                                                'yyyy',
                                                '-',
                                                'mm',
                                                '-',
                                                'dd',
                                              ]) +
                                          ' 00:00:00',
                                      style: TextStyle(
                                        color: Color(0xFF0D1333),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 8,
                                  bottom: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '????????????',
                                      style: TextStyle(
                                        color: Color(0xFF9C9EA6),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '??????????????????',
                                      style: TextStyle(
                                        color: Color(0xFF0D1333),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IButton2(
                          labelText: '??????',
                          enable: true,
                          fieldCallBack: () async {
                            Navigator.of(context).pop();
                            loading();
                            ResponseModel<WaKuangModel> response =
                                await wakuang(jiaocang?.id ?? 0,
                                    int.tryParse(count) ?? 0);
                            toast(response.code == 0 ? '????????????' : response.msg);
                            if (response.code == 0) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (_) {
                                return InnovationOrder(
                                    id: response.data?.id ?? 0);
                              }));
                            }
                          },
                        )
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'images/close@2x.png',
                          width: 28,
                          height: 28,
                        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF602FDA),
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '????????????',
          style: TextStyle(color: Colors.white),
        ),
        leading: IBackIcon(
          left: 16,
          style: 'white',
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Stack(
              children: [
                Positioned(
                  top: -1880,
                  left: MediaQuery.of(context).size.width / 2 - 1000,
                  child: ClipOval(
                    child: Container(
                      width: 2000,
                      height: 2000,
                      color: Color(0xFF602FDA),
                    ),
                  ),
                )
              ],
            ),
          ),
          SmartRefresher(
            enablePullDown: true,
            header: WaterDropHeader(),
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2),
                          blurRadius: 8,
                          spreadRadius: -2,
                          color: Color(0x366545B5),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Table(
                          children: [
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    child: Text(
                                      '?????????',
                                      style: TextStyle(
                                        color: Color(0xFF9C9EA6),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    child: Text(
                                      '??????',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF9C9EA6),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                      child: Text(
                                    '????????????',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xFF9C9EA6),
                                      fontSize: 11,
                                    ),
                                  )),
                                )
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 8),
                                    child: RichText(
                                      text: TextSpan(
                                        text: ((jiaocang?.rates ?? 0) * 100)
                                            .toString(),
                                        style: TextStyle(
                                          color: Color(0xFF602FDA),
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' %/???',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 8),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: (jiaocang?.coinnumber ?? 0)
                                            .toString(),
                                        style: TextStyle(
                                          color: Color(0xFF0D1333),
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' HFC',
                                            style: TextStyle(
                                              color: Color(0xFF5F6173),
                                              fontSize: 9,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '/???',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 8),
                                    child: RichText(
                                      textAlign: TextAlign.right,
                                      text: TextSpan(
                                        text: (jiaocang?.days ?? 0).toString(),
                                        style: TextStyle(
                                          color: Color(0xFF0D1333),
                                          fontSize: 19,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: ' ???',
                                            style: TextStyle(
                                              color: Color(0xFF5F6173),
                                              fontSize: 11,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          height: 18,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Color(0xFFEDE6FF),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFFEDE6FF),
                                      offset: Offset(0, 1),
                                      blurRadius: 2,
                                      spreadRadius: 0),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: (jiaocang?.scount ?? 0) /
                                    (jiaocang?.tcount ?? 100),
                                heightFactor: 1,
                                child: Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFF602FDA),
                                        Color(0xFF995CEF)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.red,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xA8602FDA),
                                        offset: Offset(0, 2),
                                        blurRadius: 3,
                                        spreadRadius: -1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: (jiaocang?.scount ?? 0).toString() +
                                      ' ???/ ',
                                  style: TextStyle(
                                    color: Color(0xFF0D1333),
                                    fontSize: 11,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: (jiaocang?.tcount ?? 0).toString() +
                                          '???',
                                      style: TextStyle(
                                        color: Color(0xFF5F6173),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '?????? ' +
                                    ((jiaocang?.scount ?? 0) /
                                            (jiaocang?.tcount ?? 100) *
                                            100)
                                        .toStringAsFixed(2) +
                                    '%',
                                style: TextStyle(
                                  color: Color(0xFF5F6173),
                                  fontSize: 11,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          child: Text(
                            '????????????',
                            style: TextStyle(
                              color: Color(0xFF0D1333),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '?????????' +
                                  (zichans?.balance ?? 0).toString() +
                                  ' HFC',
                              style: TextStyle(
                                color: Color(0xFF5F6173),
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              '??????' +
                                  ((zichans?.balance ?? 0) ~/
                                          (jiaocang?.coinnumber ?? 1))
                                      .toString() +
                                  '???',
                              style: TextStyle(
                                color: Color(0xFF5F6173),
                                fontSize: 11,
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 8,
                        ),
                        ITextFiled(
                          value: count,
                          fieldCallBack: (content) {
                            setState(() {
                              count = content;
                            });
                            jiaocangsxf(jiaocang?.id ?? 0,
                                    int.tryParse(content) ?? 0)
                                .then((value) {
                              if (count == content) {
                                setState(() {
                                  sxf = (value.data?.sxf ?? '').toString();
                                });
                              }
                            });
                            jiaocangprofit(jiaocang?.id ?? 0,
                                    int.tryParse(content) ?? 0)
                                .then((value) {
                              profit = (value.data?.profit ?? '').toString();
                            });
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+'))
                          ],
                          shadow: 'gray',
                          labelText:
                              (jiaocang?.smallcount ?? 0).toString() + ' ??????',
                          suffix: Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Text(
                              '???',
                              style: TextStyle(
                                color: Color(0xFF0D1333),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            '??? ' +
                                ((double.tryParse(count) ?? 0) *
                                        (jiaocang?.coinnumber ?? 0))
                                    .toString() +
                                ' HFC',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF313333),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16, bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '?????????(' +
                                    ((jiaocang?.sxf ?? 0) * 100).toString() +
                                    '%)',
                                style: TextStyle(
                                  color: Color(0xFF9C9EA6),
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                (double.tryParse(sxf)?.toString() ?? '--') +
                                    ' HFC',
                                style: TextStyle(
                                  color: Color(0xFF313333),
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6, bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '???????????????',
                                style: TextStyle(
                                  color: Color(0xFF9C9EA6),
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                (double.tryParse(profit)?.toString() ?? '--') +
                                    ' HFC',
                                style: TextStyle(
                                  color: Color(0xFF313333),
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6, bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '??????????????????',
                                style: TextStyle(
                                  color: Color(0xFF9C9EA6),
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                (jiaocang?.smallcount ?? 0).toString() + ' ???',
                                style: TextStyle(
                                  color: Color(0xFF313333),
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6, bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '??????????????????',
                                style: TextStyle(
                                  color: Color(0xFF9C9EA6),
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                (jiaocang?.maxcount ?? 0).toString() + ' ???',
                                style: TextStyle(
                                  color: Color(0xFF313333),
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6, bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '?????????',
                                style: TextStyle(
                                  color: Color(0xFF9C9EA6),
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                formatDate(
                                        DateTime.now().add(Duration(days: 1)), [
                                      'yyyy',
                                      '-',
                                      'mm',
                                      '-',
                                      'dd',
                                    ]) +
                                    ' 00:00:00',
                                style: TextStyle(
                                  color: Color(0xFF313333),
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6, bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '?????????',
                                style: TextStyle(
                                  color: Color(0xFF9C9EA6),
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                formatDate(
                                        DateTime.now().add(Duration(
                                            days: 1 + (jiaocang?.days ?? 0))),
                                        [
                                          'yyyy',
                                          '-',
                                          'mm',
                                          '-',
                                          'dd',
                                        ]) +
                                    ' 00:00:00',
                                style: TextStyle(
                                  color: Color(0xFF313333),
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6, bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '????????????',
                                style: TextStyle(
                                  color: Color(0xFF9C9EA6),
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                '??????????????????',
                                style: TextStyle(
                                  color: Color(0xFF313333),
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16, bottom: 12),
                          child: Text(
                            '????????????',
                            style: TextStyle(
                              color: Color(0xFF313333),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 24),
                          child: Text(
                            jiaocang?.productname ?? '',
                            style: TextStyle(
                              color: Color(0xFF0D1333),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16, bottom: 12),
                          child: Text(
                            '????????????',
                            style: TextStyle(
                              color: Color(0xFF313333),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            jiaocang?.orgtions ?? '',
                            style: TextStyle(
                              color: Color(0xFF0D1333),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 16, bottom: 12),
                          child: Text(
                            '????????????',
                            style: TextStyle(
                              color: Color(0xFF313333),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 24),
                          child: Text(
                            '1?????????????????????????????????????????????????????????????????????????????????????????????\n2?????????????????????????????????????????????????????????????????????????????????\n3???????????????????????????????????????????????????????????????????????????????????????????????????????????????\n4???????????????????????????????????????????????????????????????????????????????????????????????????',
                            style: TextStyle(
                              color: Color(0xFF0D1333),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        IButton2(
                          labelText: '????????????',
                          enable: true,
                          fieldCallBack: () {
                            if ((double.tryParse(count) ?? 0) <
                                (jiaocang?.smallcount ?? double.infinity)) {
                              toast('????????????' +
                                  (jiaocang?.smallcount ?? '--').toString() +
                                  '???');
                              return;
                            }
                            onCreateOrder();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

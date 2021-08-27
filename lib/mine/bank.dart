import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/api/auth1detail.dart';
import 'package:huofu/api/bankdelete.dart';
import 'package:huofu/api/bankdetail.dart';
import 'package:huofu/api/bankedit.dart';
import 'package:huofu/api/bankupdate.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/iTextField.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/mine/paymentVerify.dart';
import 'package:huofu/model/response.dart';

class Bank extends StatefulWidget {
  @override
  BankState createState() => BankState();
}

class BankState extends State {
  bool isAdd = true;
  bool edit = false;
  int? id;
  String name = '';
  String number = '';
  String bank = '';
  String branch = '';
  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  _onRefresh() {
    auth1detail().then((response) {
      if (response.data != null) {
        setState(() {
          name = response.data?.username ?? '';
        });
      } else {
        toast('A1未认证');
      }
    }).catchError((error) {
      toast(error.toString());
    });
    bankdetail().then((response) {
      setState(() {
        isAdd = response.bank == null;
        id = response.bank?.id;
        number = response.bank?.cardnumber ?? '';
        bank = response.bank?.bankname ?? '';
        branch = response.bank?.fetchbank ?? '';
      });
    }).catchError((error) {
      setState(() {
        isAdd = true;
      });
    });
  }

  onMoreAction() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      edit = true;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8)),
                    ),
                    padding: EdgeInsets.only(top: 18, bottom: 18),
                    child: Center(
                      child: Text(
                        '修改',
                        style: TextStyle(
                          color: Color(0xFF313333),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Color(0xFFF6F6F6),
                height: 1,
              ),
              Container(
                child: GestureDetector(
                  onTap: () async {
                    loading();
                    var data = await bankdelete(id.toString());
                    toast(data.data['msg'] ?? "");
                    setState(() {
                      isAdd = true;
                      edit = false;
                      id = null;
                      number = '';
                      bank = '';
                      branch = '';
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 18, bottom: 18),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        '删除',
                        style: TextStyle(
                          color: Color(0xFF313333),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 18, bottom: 18),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        '取消',
                        style: TextStyle(
                          color: Color(0xFF313333),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
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
      appBar: AppBar(
        title: Text(isAdd ? '添加银行卡' : (edit ? '编辑银行卡' : '银行卡')),
        leading: IBackIcon(left: 16),
        actions: [
          if (!isAdd)
            GestureDetector(
              onTap: onMoreAction,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
              ),
            )
        ],
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              children: [
                ITextFiled(
                  value: name,
                  enable: false,
                  prefix: Container(
                    width: 92,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      '姓名',
                      style: TextStyle(
                        color: Color(0xFF313333),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  labelText: '请输入姓名',
                ),
                Container(
                  height: 16,
                ),
                ITextFiled(
                  value: number,
                  enable: isAdd || edit,
                  prefix: Container(
                    width: 92,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      '银行卡号',
                      style: TextStyle(
                        color: Color(0xFF313333),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  labelText: '请输入银行卡号',
                  fieldCallBack: (context) {
                    setState(() {
                      number = context;
                    });
                  },
                ),
                Container(
                  height: 16,
                ),
                ITextFiled(
                  value: bank,
                  enable: isAdd || edit,
                  prefix: Container(
                    width: 92,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      '银行名称',
                      style: TextStyle(
                        color: Color(0xFF313333),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  labelText: '请输入银行名称',
                  fieldCallBack: (context) {
                    setState(() {
                      bank = context;
                    });
                  },
                ),
                Container(
                  height: 16,
                ),
                ITextFiled(
                  value: branch,
                  enable: isAdd || edit,
                  prefix: Container(
                    width: 92,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      '开户支行',
                      style: TextStyle(
                        color: Color(0xFF313333),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  labelText: '请输入开户支行',
                  fieldCallBack: (context) {
                    setState(() {
                      branch = context;
                    });
                  },
                ),
                Container(
                  height: 16,
                ),
                Text(
                  '温馨提示：当您出售数字货币时，您选择的收款方式将向买方展示，请确认信息填写准确无误。',
                  style: TextStyle(
                    color: Color(0xFFACACAC),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          if (isAdd || edit)
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: IButton2(
                labelText: edit ? '修改' : '确认',
                enable:
                    number.length > 0 && bank.length > 0 && branch.length > 0,
                fieldCallBack: () async {
                  var vcode = await Navigator.push(context,
                      MaterialPageRoute(builder: (_) {
                    return PaymentVerify(
                      type: 7,
                    );
                  }));
                  if (vcode != null) {
                    if (number.length == 0) {
                      toast('请输入银行卡号');
                      return;
                    }
                    if (bank.length == 0) {
                      toast('请输入银行名称');
                      return;
                    }
                    if (branch.length == 0) {
                      toast('请输入开户支行');
                      return;
                    }
                    loading();
                    ResponseModel data;
                    if (isAdd) {
                      data = await bankedit(number, bank, branch, vcode);
                    } else {
                      data = await bankupdate(
                          id.toString(), number, bank, branch, vcode);
                    }
                    toast(data.msg);
                    if (data.code == 0) {
                      Navigator.pop(context);
                    }
                  }
                },
              ),
            )
        ],
      ),
    );
  }
}

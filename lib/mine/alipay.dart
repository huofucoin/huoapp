import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/api/alipaydelete.dart';
import 'package:huofu/api/alipaydetail.dart';
import 'package:huofu/api/alipayedit.dart';
import 'package:huofu/api/alipayupdate.dart';
import 'package:huofu/api/auth1detail.dart';
import 'package:huofu/api/upload.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/iTextField.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/mine/paymentVerify.dart';
import 'package:huofu/model/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Alipay extends StatefulWidget {
  @override
  AlipayState createState() => AlipayState();
}

class AlipayState extends State {
  bool isAdd = true;
  bool edit = false;
  String number = '';
  String image = '';
  String name = '';
  int? id;

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
    alipaydetail().then((response) {
      setState(() {
        isAdd = response.zfb == null;
        id = response.zfb?.id;
        number = response.zfb?.numbers ?? '';
        image = response.zfb?.images ?? '';
      });
    }).catchError((error) {
      setState(() {
        isAdd = true;
      });
    });
  }

  onUpload(PickedFile file) async {
    Directory temp = await getTemporaryDirectory();
    File? img = await FlutterImageCompress.compressAndGetFile(
        file.path, temp.path + '/alipay.jpg',
        quality: 80);
    if (img != null) {
      loading();
      var body = await upload(img.path);
      if (body.data['url'] != null) {
        setState(() {
          image = body.data['url'];
        });
      }
      ToastManager().dismissAll(showAnim: true);
    }
  }

  onActionSheet() {
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
                    var file = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    if (file != null) {
                      Navigator.pop(context);
                      this.onUpload(file);
                    }
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
                        '从相册中选择',
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
                    var file = await ImagePicker()
                        .getImage(source: ImageSource.camera);
                    if (file != null) {
                      Navigator.pop(context);
                      this.onUpload(file);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 18, bottom: 18),
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        '拍照',
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
                    var data = await alipaydelete(id.toString());
                    toast(data.data['msg'] ?? "");
                    setState(() {
                      isAdd = true;
                      edit = false;
                      id = null;
                      number = '';
                      image = '';
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
        title: Text(isAdd ? '添加支付宝' : (edit ? '编辑支付宝' : '支付宝')),
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
                    width: 108,
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
                    width: 108,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Text(
                      '支付宝账号',
                      style: TextStyle(
                        color: Color(0xFF313333),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  labelText: '请输入支付宝账号',
                  fieldCallBack: (context) {
                    setState(() {
                      number = context;
                    });
                  },
                ),
                Container(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 8,
                        spreadRadius: 0,
                        color: Color(0x21C7C3D0),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '收款二维码',
                            style: TextStyle(
                              color: Color(0xFF313333),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          (isAdd || edit) && image.length > 0
                              ? GestureDetector(
                                  onTap: () {
                                    this.onActionSheet();
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'images/reload@2x.png',
                                        width: 14,
                                        height: 14,
                                      ),
                                      Container(
                                        width: 2,
                                      ),
                                      Text(
                                        '重新上传',
                                        style: TextStyle(
                                          color: Color(0xFF602FDA),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  width: 0,
                                )
                        ],
                      ),
                      Container(
                        height: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (isAdd || edit) {
                            this.onActionSheet();
                          }
                        },
                        child: Stack(
                          children: [
                            Image.asset('images/scan@2x.png'),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: image.length > 0
                                    ? Container(
                                        padding: EdgeInsets.all(16),
                                        child: Image.network(image),
                                      )
                                    : Image.asset(
                                        'images/add@2x.png',
                                        width: 47,
                                        height: 47,
                                      ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
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
                enable: number.length > 0 && image.length > 0,
                fieldCallBack: () async {
                  var vcode = await Navigator.push(context,
                      MaterialPageRoute(builder: (_) {
                    return PaymentVerify(
                      type: 9,
                    );
                  }));
                  if (vcode != null) {
                    if (number.length == 0) {
                      toast('请输入支付宝账号');
                      return;
                    }
                    if (image.length == 0) {
                      toast('请上传收款二维码');
                      return;
                    }
                    loading();
                    ResponseModel data;
                    if (isAdd) {
                      data = await alipayedit(number, image, vcode);
                    } else {
                      data = await alipayupdate(
                          id.toString(), number, image, vcode);
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

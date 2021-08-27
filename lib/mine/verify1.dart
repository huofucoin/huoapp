import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/api/auth1detail.dart';
import 'package:huofu/api/auth1edit.dart';
import 'package:huofu/api/auth1update.dart';
import 'package:huofu/api/upload.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/iTextField.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/model/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Verify1 extends StatefulWidget {
  @override
  Verify1State createState() => Verify1State();
}

class Verify1State extends State {
  String id = '';
  String name = '';
  String number = '';
  bool isFront = true;
  String front = '';
  String back = '';
  int status = 1;

  @override
  void initState() {
    super.initState();
    auth1detail().then((response) {
      setState(() {
        id = (response.data?.id ?? '').toString();
        name = response.data?.username ?? '';
        number = response.data?.cardnumber ?? '';
        front = response.data?.frontimage ?? '';
        back = response.data?.backimage ?? '';
        status = response.data?.status ?? 0;
      });
    }).catchError((error) {
      toast(error.toString());
    });
  }

  onUpload(PickedFile file) async {
    Directory temp = await getTemporaryDirectory();
    File? image = await FlutterImageCompress.compressAndGetFile(file.path,
        temp.path + '/verify_' + (isFront ? 'front' : 'back') + '.jpg',
        quality: 80);
    if (image != null) {
      loading();
      var body = await upload(image.path);
      if (body.data['url'] != null) {
        if (isFront) {
          setState(() {
            front = body.data['url'];
          });
        } else {
          setState(() {
            back = body.data['url'];
          });
        }
      }
      ToastManager().dismissAll(showAnim: true);
    }
  }

  onActionSheet(bool position) {
    setState(() {
      isFront = position;
    });
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
                    PickedFile? file = await ImagePicker()
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
                    PickedFile? file = await ImagePicker()
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('一级认证'),
        leading: IBackIcon(left: 16),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 90),
            child: Column(
              children: [
                ITextFiled(
                  value: name,
                  enable: status == 0 || status == 3,
                  prefix: Container(
                    padding: EdgeInsets.only(left: 16),
                    width: 90,
                    child: Text(
                      '姓名',
                      style: TextStyle(
                          color: Color(0xFF313333),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  labelText: '请输入您的姓名',
                  fieldCallBack: (content) {
                    setState(() {
                      name = content;
                    });
                  },
                ),
                Container(
                  height: 16,
                ),
                ITextFiled(
                  value: number,
                  enable: status == 0 || status == 3,
                  prefix: Container(
                    padding: EdgeInsets.only(left: 16),
                    width: 90,
                    child: Text(
                      '证件号码',
                      style: TextStyle(
                          color: Color(0xFF313333),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  labelText: '请输入您的证件号码',
                  fieldCallBack: (content) {
                    setState(() {
                      number = content;
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
                          color: Color(0x21C7C3D0))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '请上传身份证正反面',
                        style: TextStyle(
                          color: Color(0xFF313333),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (status == 0 || status == 3) {
                            this.onActionSheet(false);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 16),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFFF0F0FA),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '头像面',
                                    style: TextStyle(
                                      color: Color(0xFF313333),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    height: 8,
                                  ),
                                  Text(
                                    '上传您身份证头像面',
                                    style: TextStyle(
                                      color: Color(0xFF9C9EA6),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              back.length > 0
                                  ? Image.network(
                                      back,
                                      width: 165,
                                      height: 110,
                                    )
                                  : Image.asset(
                                      'images/s1@2x.png',
                                      width: 165,
                                      height: 110,
                                    )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (status == 0 || status == 3) {
                            this.onActionSheet(true);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 16),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFFF0F0FA),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '国徽面',
                                    style: TextStyle(
                                      color: Color(0xFF313333),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    height: 8,
                                  ),
                                  Text(
                                    '上传您身份证国徽面',
                                    style: TextStyle(
                                      color: Color(0xFF9C9EA6),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              front.length > 0
                                  ? Image.network(
                                      front,
                                      width: 165,
                                      height: 110,
                                    )
                                  : Image.asset(
                                      'images/s2@2x.png',
                                      width: 165,
                                      height: 110,
                                    )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 16,
                      ),
                      Text(
                        '· 确保照片无水印，无污渍，信息清晰，头像完整\n· 照片内容真实有效，不得做任何修改，证件必须在有效期内\n· 支持jpg/png格式，大小在5M内',
                        style: TextStyle(
                            color: Color(0xFF9C9EA6),
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          if (status == 0 || status == 3)
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: IButton2(
                labelText: '确认',
                enable: name.length > 0 &&
                    number.length > 0 &&
                    front.length > 0 &&
                    back.length > 0,
                fieldCallBack: () async {
                  if (name.length == 0) {
                    toast('请输入您的姓名');
                    return;
                  }
                  if (number.length == 0) {
                    toast('请输入您的证件号码');
                    return;
                  }
                  if (front.length == 0) {
                    toast('请上传您身份证国徽面');
                    return;
                  }
                  if (back.length == 0) {
                    toast('请上传您身份证头像面');
                    return;
                  }
                  ResponseModel data;
                  if (id.length > 0) {
                    data = await auth1update(id, name, number, front, back);
                  } else {
                    data = await auth1edit(name, number, front, back);
                  }
                  if (data.code == 0) {
                    Navigator.pop(context);
                  }
                  toast(data.msg);
                },
              ),
            )
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:huofu/api/auth2detail.dart';
import 'package:huofu/api/auth2edit.dart';
import 'package:huofu/api/auth2update.dart';
import 'package:huofu/api/upload.dart';
import 'package:huofu/iBackIcon.dart';
import 'package:huofu/iButton2.dart';
import 'package:huofu/loading.dart';
import 'package:huofu/model/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Verify2 extends StatefulWidget {
  @override
  Verify2State createState() => Verify2State();
}

class Verify2State extends State {
  String id = '';
  String image = '';
  int status = 1;

  @override
  void initState() {
    super.initState();
    auth2detail().then((response) {
      setState(() {
        id = (response.data?.id ?? '').toString();
        image = response.data?.images ?? '';
        status = response.data?.status ?? 0;
      });
    }).catchError((error) {
      toast(error.toString());
    });
  }

  onUpload(PickedFile file) async {
    Directory temp = await getTemporaryDirectory();
    File? img = await FlutterImageCompress.compressAndGetFile(
        file.path, temp.path + '/verify_2.jpg',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('二级认证'),
        leading: IBackIcon(left: 16),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Container(
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
                    '请上传手持身份证的正面照片',
                    style: TextStyle(
                      color: Color(0xFF313333),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (status == 0 || status == 3) {
                        this.onActionSheet();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 16, bottom: 16),
                      child: image.length > 0
                          ? Image.network(
                              image,
                              width: 311,
                              height: 269,
                            )
                          : Image.asset(
                              'images/s3@2x.png',
                              width: 311,
                              height: 269,
                            ),
                    ),
                  ),
                  Text(
                    '· 确保照片无水印，无污渍，信息清晰，头像完整\n· 照片内容真实有效，不得做任何修改，证件必须在有效期内\n· 支持jpg/png格式，大小在5M内',
                    style: TextStyle(
                      color: Color(0xFF9C9EA6),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
          if (status == 0 || status == 3)
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: IButton2(
                labelText: '确认',
                enable: image.length > 0,
                fieldCallBack: () async {
                  if (image.length == 0) {
                    toast('请上传手持证件照');
                    return;
                  }
                  ResponseModel data;
                  if (id.length > 0) {
                    data = await auth2update(id, image);
                  } else {
                    data = await auth2edit(image);
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

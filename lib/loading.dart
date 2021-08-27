import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

ToastFuture loading() {
  return showToastWidget(
    Container(
      color: Color(0x80000000),
      child: Center(
        child: Container(
          width: 120,
          height: 120,
          padding: EdgeInsets.only(
            top: 24,
            bottom: 18,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xFF5F6173),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  backgroundColor: Color(0xFF7B7B7B),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              Text(
                '正在加载',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    ),
    isIgnoring: false,
    isHideKeyboard: true,
    duration: Duration(seconds: 3600),
    position: StyledToastPosition.center,
  );
}

toast(String text) {
  showToast(text, isHideKeyboard: true);
}

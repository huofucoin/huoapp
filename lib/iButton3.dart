import 'package:flutter/material.dart';

typedef void IButton2CallBack();

class IButton3 extends StatefulWidget {
  final Widget? label;
  final IButton2CallBack? fieldCallBack;
  final String type;
  const IButton3({
    Key? key,
    this.label,
    this.fieldCallBack,
    this.type = '实心',
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return IButton3State();
  }
}

class IButton3State extends State<IButton3> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.fieldCallBack!();
      },
      child: Container(
        height: 44,
        decoration: widget.type == '空心'
            ? BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFF602FDA),
                  width: 1,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(29)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x366545B5),
                    offset: Offset(0, 2),
                    blurRadius: 8,
                    spreadRadius: -2,
                  ),
                ],
              )
            : BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF995CEF), Color(0xFF602FDA)],
                    tileMode: TileMode.repeated),
                borderRadius: BorderRadius.all(Radius.circular(29)),
              ),
        child: Center(
          child: widget.label == null ? Container() : widget.label,
        ),
      ),
    );
  }
}

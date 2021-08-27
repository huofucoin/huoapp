import 'package:flutter/material.dart';

typedef void IButton2CallBack();

class IButton2 extends StatefulWidget {
  final String labelText;
  final bool enable;
  final double height;
  final IButton2CallBack? fieldCallBack;
  final double fontSize;
  final bool fontShadow;
  const IButton2({
    Key? key,
    this.labelText = '',
    this.height = 58,
    this.enable = false,
    this.fieldCallBack,
    this.fontSize = 24,
    this.fontShadow = true,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return IButton2State();
  }
}

class IButton2State extends State<IButton2> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        widget.fieldCallBack?.call();
      },
      child: Container(
        height: widget.height,
        decoration: widget.enable
            ? BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF995CEF), Color(0xFF602FDA)],
                    tileMode: TileMode.repeated),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xA8602FDA),
                    offset: Offset(0, 20),
                    blurRadius: 37,
                    spreadRadius: -19,
                  ),
                ],
              )
            : BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFF0F0F0), Color(0xFFDDDDDD)],
                    tileMode: TileMode.repeated),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(97, 155, 150, 167),
                    offset: Offset(0, 20),
                    blurRadius: 35,
                    spreadRadius: -10,
                  ),
                ],
              ),
        child: Center(
          child: Text(
            widget.labelText,
            style: TextStyle(
              color: Colors.white,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w600,
              shadows: widget.fontShadow
                  ? [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: Color(0xFFD2D2D2),
                      )
                    ]
                  : [],
            ),
          ),
        ),
      ),
    );
  }
}

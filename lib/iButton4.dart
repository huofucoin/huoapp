import 'package:flutter/material.dart';

typedef void IButton2CallBack();

class IButton4 extends StatefulWidget {
  final bool enable;
  final IButton2CallBack? fieldCallBack;
  const IButton4({
    Key? key,
    this.enable = false,
    this.fieldCallBack,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return IButton4State();
  }
}

class IButton4State extends State<IButton4> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        widget.fieldCallBack!();
      },
      child: Container(
        width: 72,
        height: 72,
        child: widget.enable
            ? Image.asset('images/next_hl@2x.png')
            : Image.asset('images/next@2x.png'),
        decoration: widget.enable
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xA8602FDA),
                    offset: Offset(0, 20),
                    blurRadius: 35,
                    spreadRadius: -10,
                  ),
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(36),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(97, 155, 150, 167),
                    offset: Offset(0, 20),
                    blurRadius: 35,
                    spreadRadius: -10,
                  ),
                ],
              ),
      ),
    );
  }
}

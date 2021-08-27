import 'package:flutter/material.dart';

typedef void IButtonCallBack(bool select);

class IButton extends StatefulWidget {
  final String labelText;
  final IButtonCallBack? fieldCallBack;
  final bool selected;
  final double borderRadius;
  final Border? border;
  const IButton({
    Key? key,
    this.labelText = '',
    this.selected = false,
    this.fieldCallBack,
    this.borderRadius = 2,
    this.border,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return IButtonState();
  }
}

class IButtonState extends State<IButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.fieldCallBack!(!widget.selected);
      },
      child: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 11, 16, 11),
              decoration: BoxDecoration(
                border: widget.border == null
                    ? Border.all(width: 0)
                    : widget.border,
                color: widget.selected ? Color(0xFFEDE6FF) : Colors.white,
                borderRadius: BorderRadius.circular(widget.borderRadius),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 8,
                    spreadRadius: 0,
                    color:
                        widget.selected ? Color(0x66EDE6FF) : Color(0x21C7C3D0),
                  )
                ],
              ),
              child: Center(
                child: Text(
                  widget.labelText,
                  style: TextStyle(
                    color:
                        widget.selected ? Color(0xFF602FDA) : Color(0xFF0D1333),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            widget.selected
                ? Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      width: 26,
                      height: 16,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(widget.borderRadius),
                          ),
                        ),
                        image: DecorationImage(
                          image: AssetImage('images/share_corner@2x.png'),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class IBackIcon extends StatelessWidget {
  final double left;
  final String style;
  const IBackIcon({this.left = 32, this.style = 'black', Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(this.left, 0, 0, 0),
        child: Row(
          children: [
            Image.asset(
              this.style == 'white'
                  ? 'images/back@2x.png'
                  : 'images/back_hl@2x.png',
              width: 24, height: 24,
              // fit: BoxFit.contain
            )
          ],
        ),
      ),
    );
  }
}

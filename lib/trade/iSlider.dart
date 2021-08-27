import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void ISliderCallBack(double value);

class ISlider extends StatefulWidget {
  final double value;
  final ISliderCallBack? fieldCallBack;
  const ISlider({Key? key, this.value = 0, this.fieldCallBack})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => ISliderState();
}

class ISliderState extends State<ISlider> {
  double offset = 0;
  bool dragging = false;
  @override
  Widget build(BuildContext context) {
    int left = min(100, max(0, ((widget.value + offset) * 100).toInt()));
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapUp: (tap) {
        double width = context.size?.width ?? 0;
        if (width > 0) {
          widget.fieldCallBack?.call(tap.localPosition.dx / width);
        }
      },
      child: Container(
        height: 24,
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: Color(0xFFF6F6F6),
                    ),
                  ),
                ),
                Expanded(flex: 2, child: Container()),
                Expanded(
                  flex: 38,
                  child: Container(
                    height: 2,
                    color: Color(0xFFF6F6F6),
                  ),
                ),
                Expanded(flex: 2, child: Container()),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: Color(0xFFF6F6F6),
                    ),
                  ),
                ),
                Expanded(flex: 2, child: Container()),
                Expanded(
                  flex: 38,
                  child: Container(
                    height: 2,
                    color: Color(0xFFF6F6F6),
                  ),
                ),
                Expanded(flex: 2, child: Container()),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: Color(0xFFF6F6F6),
                    ),
                  ),
                ),
                Expanded(flex: 2, child: Container()),
                Expanded(
                  flex: 38,
                  child: Container(
                    height: 2,
                    color: Color(0xFFF6F6F6),
                  ),
                ),
                Expanded(flex: 2, child: Container()),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: Color(0xFFF6F6F6),
                    ),
                  ),
                ),
                Expanded(flex: 2, child: Container()),
                Expanded(
                  flex: 38,
                  child: Container(
                    height: 2,
                    color: Color(0xFFF6F6F6),
                  ),
                ),
                Expanded(flex: 2, child: Container()),
                Expanded(
                  flex: 4,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: Color(0xFFF6F6F6),
                    ),
                  ),
                ),
              ],
            ),
            ClipPath(
              clipper: SliderClipper(width: left / 100),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Color(0xFF2ECEE0),
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 38,
                    child: Container(
                      height: 2,
                      color: Color(0xFF2ECEE0),
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Color(0xFF2ECEE0),
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 38,
                    child: Container(
                      height: 2,
                      color: Color(0xFF2ECEE0),
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Color(0xFF2ECEE0),
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 38,
                    child: Container(
                      height: 2,
                      color: Color(0xFF2ECEE0),
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Color(0xFF2ECEE0),
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 38,
                    child: Container(
                      height: 2,
                      color: Color(0xFF2ECEE0),
                    ),
                  ),
                  Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Color(0xFF2ECEE0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: left,
                  child: Container(),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onHorizontalDragCancel: () {
                    widget.fieldCallBack?.call(widget.value);
                    setState(() {
                      dragging = false;
                    });
                  },
                  onHorizontalDragEnd: (detail) {
                    double width = context.size?.width ?? 0;
                    if (width > 0) {
                      widget.fieldCallBack?.call(min(
                          max(max(min(widget.value, 1), 0) + offset, 0), 1));
                      setState(() {
                        offset = 0;
                      });
                    }
                    setState(() {
                      dragging = false;
                    });
                  },
                  onHorizontalDragDown: (detail) {
                    setState(() {
                      dragging = true;
                    });
                  },
                  onHorizontalDragStart: (detail) {
                    double width = context.size?.width ?? 0;
                    if (width > 0) {
                      setState(() {
                        offset = detail.localPosition.dx / width;
                      });
                    }
                    setState(() {
                      dragging = true;
                    });
                  },
                  onHorizontalDragUpdate: (detail) {
                    double width = context.size?.width ?? 0;
                    if (width > 0) {
                      setState(() {
                        offset = detail.localPosition.dx / width;
                      });
                    }
                    setState(() {
                      dragging = true;
                    });
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        child: Image.asset(
                          'images/slider@2x.png',
                          width: 19,
                          height: 24,
                        ),
                      ),
                      Positioned(
                        left: -22.5,
                        top: 16,
                        child: Stack(
                          children: [
                            Container(
                              child: Image.asset(
                                'images/slider_bg@2x.png',
                                width: 64,
                                height: 51,
                              ),
                            ),
                            Positioned(
                              top: 15,
                              bottom: 6,
                              left: 8,
                              right: 8,
                              child: Center(
                                child: Text(
                                  left.toString() + '%',
                                  style: TextStyle(
                                    color: Color(0xFF0D1333),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 100 - left,
                  child: Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SliderClipper extends CustomClipper<Path> {
  final double width;
  const SliderClipper({required this.width});

  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * width, 0);
    path.lineTo(size.width * width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

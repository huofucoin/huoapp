import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/iBackIcon.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        brightness: Brightness.dark,
        leading: IBackIcon(
          left: 16,
          style: 'white',
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 750 / 2854,
              child: Image.asset('images/intro_01.jpg'),
            ),
            AspectRatio(
              aspectRatio: 750 / 3428,
              child: Image.asset('images/intro_02.jpg'),
            ),
            AspectRatio(
              aspectRatio: 750 / 3446,
              child: Image.asset('images/intro_03.jpg'),
            ),
            AspectRatio(
              aspectRatio: 750 / 2498,
              child: Image.asset('images/intro_04.jpg'),
            ),
            AspectRatio(
              aspectRatio: 750 / 4724,
              child: Image.asset('images/intro_05.jpg'),
            )
          ],
        ),
      ),
    );
  }
}

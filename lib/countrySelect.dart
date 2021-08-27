import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/iTextField.dart';

class CountrySelectBar extends StatefulWidget {
  final ITextFieldCallBack? fieldCallBack;
  final String prefix;
  const CountrySelectBar({Key? key, this.fieldCallBack, this.prefix = ''})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CountrySelectBarState();
  }
}

class CountrySelectBarState extends State<CountrySelectBar> {
  String prefix = '+86';
  @override
  void initState() {
    super.initState();
    prefix = widget.prefix;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () async {
      //   var country =
      //       await Navigator.push(context, MaterialPageRoute(builder: (_) {
      //     return CountrySelect();
      //   }));
      //   if (country != null) {
      //     prefix = country;
      //     if (widget.fieldCallBack != null) {
      //       widget.fieldCallBack(country);
      //     }
      //   }
      // },
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: Row(
          children: [
            Text(
              prefix,
              style: TextStyle(
                color: Color(0xFF313333),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.keyboard_arrow_down_rounded),
            Container(
              width: 1,
              height: 26,
              color: Color(0xFFDDDDDD),
            )
          ],
        ),
      ),
    );
  }
}

class CountrySelect extends StatefulWidget {
  @override
  CountrySelectState createState() => CountrySelectState();
}

class CountrySelectState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context, '用户选择的国家');
                });
          },
        ),
        backgroundColor: Color(0xFF602FDA),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFF602FDA),
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Text('用户协议')],
          ),
        ),
      ),
    );
  }
}

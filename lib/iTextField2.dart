import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void ITextFieldCallBack(String content);

class ITextFiled2 extends StatefulWidget {
  final bool enable;
  final int fixed;
  final String? labelText;
  final ITextFieldCallBack? fieldCallBack;
  final String? value;
  final List<TextInputFormatter>? inputFormatters;
  const ITextFiled2({
    Key? key,
    this.value,
    this.labelText,
    this.fieldCallBack,
    this.inputFormatters,
    required this.fixed,
    this.enable = true,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ITextFiled2State();
  }
}

class ITextFiled2State extends State<ITextFiled2> {
  String _inputText = '';

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.value ?? _inputText,
        selection: TextSelection.fromPosition(
          TextPosition(
            affinity: TextAffinity.downstream,
            offset: widget.value?.length ?? _inputText.length,
          ),
        ),
      ),
    );
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFF6F6F6),
            width: 1,
            style: BorderStyle.solid,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                enabled: widget.enable,
                inputFormatters: widget.inputFormatters,
                style: TextStyle(
                  color: Color(0xFF313333),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                cursorColor: Color(0xFF602FDA),
                controller: _controller,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  setState(() {
                    _inputText = value;
                    widget.fieldCallBack?.call(_inputText);
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 8, right: 8),
                  labelStyle: TextStyle(
                    color: Color(0xFF9C9EA6),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  labelText: widget.labelText,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.solid,
                      color: Colors.white,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.solid,
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.solid,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (widget.enable)
                  widget.fieldCallBack?.call(max(
                          (double.tryParse(widget.value ?? _inputText) ?? 0) -
                              1 / pow(10, widget.fixed),
                          0)
                      .toStringAsFixed(widget.fixed));
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Color(0xFFF6F6F6),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'images/subtract@2x.png',
                    width: 12,
                    height: 12,
                  ),
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (widget.enable)
                  widget.fieldCallBack?.call(
                      ((double.tryParse(widget.value ?? _inputText) ?? 0) +
                              1 / pow(10, widget.fixed))
                          .toStringAsFixed(widget.fixed));
              },
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Color(0xFFF6F6F6),
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'images/plus@2x.png',
                    width: 12,
                    height: 12,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

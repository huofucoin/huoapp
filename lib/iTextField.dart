import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef void ITextFieldCallBack(String content);

class ITextFiled extends StatefulWidget {
  final TextInputType keyboardType;
  final String? labelText;
  final bool obscureText;
  final Widget? prefix;
  final ITextFieldCallBack? fieldCallBack;
  final Widget? suffix;
  final String? value;
  final String? shadow;
  final bool enable;
  final List<TextInputFormatter>? inputFormatters;
  const ITextFiled({
    Key? key,
    this.value,
    this.labelText,
    this.prefix,
    this.fieldCallBack,
    this.shadow,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffix,
    this.enable = true,
    this.inputFormatters,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ITextFiledState();
  }
}

class ITextFiledState extends State<ITextFiled> {
  String _inputText = '';
  FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  bool _hidePassword = true;
  TextEditingController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.value ?? '',
        selection: TextSelection.fromPosition(
          TextPosition(
            affinity: TextAffinity.downstream,
            offset: widget.value?.length ?? 0,
          ),
        ),
      ),
    );
    _controller?.addListener(() {
      setState(() {
        _inputText = _controller?.value.text ?? '';
        widget.fieldCallBack?.call(_inputText);
      });
    });
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void didUpdateWidget(covariant ITextFiled oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((oldWidget.value == null || oldWidget.value == '') &&
        oldWidget.value != widget.value) {
      _controller?.value =
          _controller?.value.copyWith(text: widget.value ?? '') ??
              TextEditingValue(text: widget.value ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(color: Colors.white, width: 1, style: BorderStyle.solid),
        boxShadow: widget.shadow == 'grey'
            ? [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0,
                  color: Color(0xFFC7C3D0),
                )
              ]
            : _hasFocus
                ? [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: -2,
                      color: Color.fromARGB(38, 101, 69, 181),
                    ),
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      spreadRadius: 0,
                      color: Color.fromARGB(69, 96, 47, 218),
                    ),
                    BoxShadow(
                      offset: Offset(0, -1),
                      blurRadius: 3,
                      spreadRadius: 0,
                      color: Color.fromARGB(71, 96, 47, 218),
                    )
                  ]
                : [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: -2,
                      color: Color.fromARGB(54, 101, 69, 181),
                    )
                  ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            child: widget.prefix,
          ),
          Expanded(
            child: TextField(
              enabled: widget.enable,
              inputFormatters: widget.inputFormatters,
              style: TextStyle(
                color: Color(0xFF313333),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              focusNode: _focusNode,
              cursorColor: Color(0xFF602FDA),
              controller: _controller,
              obscureText: widget.obscureText && _hidePassword,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Color(0xFF9C9EA6),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                labelText: widget.labelText,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (widget.value ?? _inputText).isNotEmpty && widget.enable
                        ? Container(
                            width: 30.0,
                            height: 40.0,
                            child: GestureDetector(
                              child: Center(
                                child: Image.asset(
                                  'images/clear@2x.png',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              onTap: () {
                                _controller?.clear();
                              },
                            ),
                          )
                        : Container(
                            width: 0,
                          ),
                    widget.obscureText
                        ? (_hidePassword
                            ? Container(
                                width: 30.0,
                                height: 40.0,
                                child: GestureDetector(
                                  child: Center(
                                    child: Image.asset(
                                      'images/hide@2x.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _hidePassword = false;
                                    });
                                  },
                                ),
                              )
                            : Container(
                                width: 30.0,
                                height: 40.0,
                                child: GestureDetector(
                                  child: Center(
                                    child: Image.asset(
                                      'images/show@2x.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _hidePassword = true;
                                    });
                                  },
                                ),
                              ))
                        : Container(
                            width: 0,
                          )
                  ],
                ),
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
          Container(
            child: widget.suffix,
          )
        ],
      ),
    );
  }
}

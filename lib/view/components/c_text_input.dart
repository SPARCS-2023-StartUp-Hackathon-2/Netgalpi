import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CTextInput extends StatefulWidget {
  CTextInput(
      {Key? key,
      this.title,
      required this.placeholder,
      this.controller,
      this.errorText,
      this.isError = false,
      this.obscureText = false,
      this.onlyAlphabetAndNumber = false})
      : super(key: key);
  String? title;
  final String placeholder;
  TextEditingController? controller;
  final bool obscureText;
  String? errorText;
  bool isError;
  bool onlyAlphabetAndNumber;

  @override
  State<CTextInput> createState() => _CTextInputState();
}

class _CTextInputState extends State<CTextInput> {
  _CTextInputState();

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (widget.title != null)
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title!,
            style: const TextStyle(
                fontSize: 16, color: Color.fromARGB(255, 105, 105, 105)),
          ),
        ),
      CupertinoTextField(
        placeholder: widget.placeholder,
        obscureText: widget.obscureText,
        padding: const EdgeInsets.all(12),
        inputFormatters: widget.onlyAlphabetAndNumber
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))
              ]
            : null,
        controller: widget.controller,
        style: const TextStyle(fontSize: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 80, 80, 80),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      if (widget.isError && widget.errorText != null)
        SizedBox(
          height: 2,
        ),
      if (widget.isError && widget.errorText != null)
        Align(
          alignment: Alignment.centerLeft,
          child: Text(widget.errorText!,
              style: const TextStyle(fontSize: 14, color: Colors.red)),
        ),
      const SizedBox(
        height: 8,
      ),
    ]);
  }
}

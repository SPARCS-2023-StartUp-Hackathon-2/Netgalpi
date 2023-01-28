import 'package:flutter/material.dart';
import 'package:netgalpi/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final String title, hintText, helpinfo;
  final String? Function(String?) validatorFn;
  final String? Function(String?)? onChangedFn;
  final Function(String?) onSavedFn;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool obscureText, showLabel;

  CustomTextFormField({
    required this.title,
    required this.hintText,
    required this.validatorFn,
    required this.onSavedFn,
    this.helpinfo = '',
    this.initialValue = '',
    this.keyboardType,
    this.onChangedFn,
    this.obscureText = false,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (showLabel)
            ? Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: gray700,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Flexible(
                      child: SizedBox(height: 0),
                      fit: FlexFit.tight,
                    ),
                    Text(
                      helpinfo,
                      style: TextStyle(
                        color: gray200,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              )
            : SizedBox.shrink(),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: gray100,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: gray100,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: gray100,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
          keyboardType: keyboardType,
          obscureText: obscureText,
          initialValue: initialValue,
          validator: validatorFn,
          onSaved: onSavedFn,
          onChanged: onChangedFn,
        ),
      ],
    );
  }
}

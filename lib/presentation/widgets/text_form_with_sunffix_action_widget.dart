import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFormWithSuffixActionWidget extends StatefulWidget {
  final TextEditingController? textEditingController;
  final Key? filedKey;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSave;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final double? borderRadius;
  final Icon? startIcon;
  final Border? inputBorder;
  final Color? inputColor;
  final Icon? suffixIcon;
  final VoidCallback? handleOnTapSuffixIcon;


  const TextFormWithSuffixActionWidget(
      {super.key,
        this.textEditingController,
        this.filedKey,
        this.hintText,
        this.labelText,
        this.helperText,
        this.onSave,
        this.validator,
        this.onFieldSubmitted,
        this.inputType,
        this.borderRadius,
        this.startIcon,
        this.inputBorder,
        this.inputColor,
        this.suffixIcon,
        this.handleOnTapSuffixIcon
      });

  @override
  State<TextFormWithSuffixActionWidget> createState() => _TextFormWithSuffixActionWidgetState();
}

class _TextFormWithSuffixActionWidgetState extends State<TextFormWithSuffixActionWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
          border: widget.inputBorder ?? const Border(
              bottom: BorderSide(
                  width: 0.1,
                  color: Colors.transparent
              )
          ),
          color: widget.inputColor ?? secondaryColor.withOpacity(0.35),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 5)),
      child: TextFormField(
        style: const TextStyle(color: primaryColor),
        controller: widget.textEditingController,
        keyboardType: widget.inputType,
        key: widget.filedKey,
        onSaved: widget.onSave,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
              top: 12, bottom: 10, left: widget.startIcon == null ? 10 : -20),
          hintText: widget.hintText,
          icon: widget.startIcon != null
              ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: widget.startIcon)
              : const SizedBox.shrink(),
          hintStyle: const TextStyle(color: secondaryColor),
          suffixIcon: GestureDetector(
            onTap: () {
              widget.handleOnTapSuffixIcon!();
            },
            child:
            widget.suffixIcon ?? const Text(""),
          ),
        ),
      ),
    );
  }
}

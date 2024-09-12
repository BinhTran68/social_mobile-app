import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_app/consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? textEditingController;
  final Key? filedKey;
  final bool? isPasswordField;
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
  final double height;
   const FormContainerWidget(
      {super.key,
      this.textEditingController,
      this.filedKey,
      this.isPasswordField,
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
        this.height = 55,
        this.inputColor});

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height,
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
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onSaved: widget.onSave,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
              top: 10, bottom: 10, left: widget.startIcon == null ? 5 : -20),
          hintText: widget.hintText,
          icon: widget.startIcon != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: widget.startIcon)
              : const SizedBox.shrink(),
          hintStyle: const TextStyle(color: secondaryColor),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: widget.isPasswordField == true
                ? Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: _obscureText == false ? blueColor : secondaryColor,
                  )
                : Text(""),
          ),
        ),
      ),
    );
  }
}

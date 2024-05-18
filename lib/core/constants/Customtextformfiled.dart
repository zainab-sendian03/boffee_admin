import 'package:flutter/material.dart';
import 'functions/validInput.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final int min;
  final int max;
  final bool visPassword;
  final bool showVisPasswordToggle;
  final void Function()? onTapIcon;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.min,
    required this.max,
    this.visPassword = true,
    this.showVisPasswordToggle = false,
    this.onTapIcon,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _visPassword;

  @override
  void initState() {
    super.initState();
    _visPassword = widget.visPassword;
  }

  void _handleTapIcon() {
    if (widget.onTapIcon != null) {
      widget.onTapIcon!();
    }

    setState(() {
      _visPassword = !_visPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (valid) => validinput(valid!, widget.max, widget.min),
      obscureText: _visPassword,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          errorMaxLines: 2,
          suffixIcon: widget.showVisPasswordToggle
              ? IconButton(
                  icon: Icon(
                    _visPassword ? Icons.visibility_off : Icons.visibility,
                    color: Color(0xFFDBC3AB),
                    size: 21,
                  ),
                  onPressed: _handleTapIcon,
                )
              : null,
          border: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFDBC3AB))),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFDBC3AB))),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 207, 206, 205), fontSize: 17)),
    );
  }
}

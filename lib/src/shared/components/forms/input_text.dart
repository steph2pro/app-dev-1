import 'package:flutter/material.dart';

enum InputType { text, phone, email, number, password }

class InputText extends StatefulWidget {
  final String label;
  final String placeholder;
  // final double height;
  final int maxLines;
  final double width;
  final InputType type;
  final bool desable;
  final Function(String) onInputChanged;
  final TextEditingController? controller;
  final String defaultValue;

  const InputText({
    Key? key,
    this.label = "",
    this.placeholder = "",
    // this.height = 59,
    this.maxLines = 1,
    this.width = double.infinity,
    this.type = InputType.text,
    this.desable = false,
    required this.onInputChanged,
    this.controller,
    this.defaultValue = "",
  }) : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late TextEditingController _controller;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.defaultValue);
    _controller.addListener(() {
      widget.onInputChanged(_controller.text);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  TextInputType _getKeyboardType() {
    switch (widget.type) {
      case InputType.phone:
        return TextInputType.phone;
      case InputType.email:
        return TextInputType.emailAddress;
      case InputType.number:
        return TextInputType.number;
      case InputType.password:
        return TextInputType.visiblePassword;
      case InputType.text:
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: widget.width,
      // height: widget.height,
      child: TextField(
        controller: _controller,
        keyboardType: _getKeyboardType(),
        enabled: !widget.desable,
        maxLines: widget.maxLines,
        obscureText: widget.type == InputType.password ? _obscureText : false,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
              width: 0.5,
            ),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          hintText: widget.placeholder,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
          ),
          suffixIcon: widget.type == InputType.password
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}

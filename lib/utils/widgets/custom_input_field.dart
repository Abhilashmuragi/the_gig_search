import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final bool suffixIcon;
  final bool obscureText;
  final bool prefixIcon;
  final TextEditingController? controller;

  const CustomInputField(
      {Key? key,
      this.labelText = "",
      this.hintText = "",
      this.validator,
      this.controller,
      this.suffixIcon = false,
      this.obscureText = false,
      this.prefixIcon = true})
      : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  //
  bool _obscureText = true;
  final FocusNode _myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 3, bottom: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.labelText,
              style: GoogleFonts.poppins().copyWith(fontSize: 14, fontWeight: FontWeight.bold, height: 1),
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: widget.controller,
            focusNode: _myFocusNode,
            obscureText: (widget.obscureText && _obscureText),
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon
                  ? (widget.labelText == "Email")
                      ? Icon(
                          Icons.email_outlined,
                          color: _myFocusNode.hasFocus ? Colors.black : Colors.black,
                        )
                      : Icon(
                          Icons.lock_outline_rounded,
                          color: _myFocusNode.hasFocus ? Colors.black : Colors.black,
                        )
                  : null,
              labelStyle: TextStyle(color: _myFocusNode.hasFocus ? Colors.black : Colors.black),
              disabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
              focusColor: Colors.black,
              focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1.0)),
              errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1.0)),
              isDense: true,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.remove_red_eye : Icons.visibility_off_outlined,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              suffixIconConstraints: const BoxConstraints(maxHeight: 33),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}

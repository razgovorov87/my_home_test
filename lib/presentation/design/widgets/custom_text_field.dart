import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.height,
    this.initFocus = false,
    this.error,
    this.scrollPadding = const EdgeInsets.all(20),
    this.obscureText = false,
  });

  final TextEditingController? controller;
  final String? label;
  final Function(String value)? onChanged;
  final TextInputType keyboardType;
  final double? height;
  final bool initFocus;
  final String? error;
  final EdgeInsets scrollPadding;
  final bool obscureText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final ValueNotifier<bool> _isFocusedNotifier = ValueNotifier<bool>(false);
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusListener);
    if (widget.initFocus) {
      _focusNode.requestFocus();
    }
  }

  void _focusListener() {
    if (_isFocusedNotifier.value != _focusNode.hasFocus) {
      _isFocusedNotifier.value = _focusNode.hasFocus;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    _focusNode.dispose();
    _isFocusedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isFocusedNotifier,
      builder: (BuildContext context, bool isFocus, Widget? child) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AnimatedContainer(
            alignment: widget.height != null ? Alignment.center : null,
            height: widget.height,
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            decoration: BoxDecoration(
              color: widget.error != null ? const Color(0xFFFDA29B) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: widget.error != null ? const Color(0xFFF04438) : const Color(0xFF116EEF)),
            ),
            child: TextField(
              controller: widget.controller,
              onChanged: widget.onChanged,
              focusNode: _focusNode,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(
                color: Color(0xFF151617),
              ),
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              scrollPadding: widget.scrollPadding,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                labelText: widget.label,
                labelStyle: TextStyle(
                  fontSize: 17,
                  height: 22 / 17,
                  color: widget.error != null ? const Color(0xFFF04438) : const Color(0xFFB2BDCC),
                ),
                floatingLabelStyle: TextStyle(
                  fontSize: 17,
                  height: 22 / 17,
                  color: widget.error != null ? const Color(0xFFF04438) : const Color(0xFF525B70),
                ),
              ),
            ),
          ),
          if (widget.error != null) ...<Widget>[
            const SizedBox(height: 4),
            Text(
              widget.error!,
              style: const TextStyle(
                fontSize: 12,
                height: 16 / 12,
                color: Color(0xFFF04438),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

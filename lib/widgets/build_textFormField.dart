import 'package:flutter/material.dart';

class Build_textFormField extends StatelessWidget {
  const Build_textFormField({
    super.key,
    required FocusNode focusNode,
    required bool isFocused,
  }) : _focusNode = focusNode, _isFocused = isFocused;

  final FocusNode _focusNode;
  final bool _isFocused;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      decoration: InputDecoration(
        prefixIcon: _isFocused
            ? null
            : Icon(
                Icons.search_outlined,
                color: Colors.black,
              ),
        suffixIcon: Icon(
          Icons.filter_1_outlined,
          color: Colors.black,
        ),
        hintText: 'Search here...',
        hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.5)), //fade away hint
        border: InputBorder.none,
      ),
    );
  }
}

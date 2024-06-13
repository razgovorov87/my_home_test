import 'package:flutter/material.dart';

class AppTapUnfocus extends StatelessWidget {
  const AppTapUnfocus({
    super.key,
    required this.child,
    this.onFocusLost,
  });

  final Widget child;
  final void Function()? onFocusLost;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusScope.of(context).focusedChild?.unfocus();
          onFocusLost?.call();
        }
      },
      child: child,
    );
  }
}

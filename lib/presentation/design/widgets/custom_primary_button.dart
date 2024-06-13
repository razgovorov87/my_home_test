import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../app_tap_animate.dart';

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isDisabled = false,
    this.isLoading = false,
    this.bgColor,
    this.textColor,
  });

  final VoidCallback onTap;
  final String text;
  final bool isDisabled;
  final bool isLoading;
  final Color? bgColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isDisabled || isLoading,
      child: AppTapAnimate(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: !isDisabled ? bgColor ?? const Color(0xFF116EEF) : const Color(0xFF14240F),
          ),
          alignment: Alignment.center,
          child: isLoading
              ? SpinKitThreeBounce(
                  size: 18,
                  color: textColor ?? Colors.white,
                )
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    height: 22 / 17,
                    color: textColor ?? Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}

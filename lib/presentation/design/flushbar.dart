import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showErrorFlushbar(
  BuildContext context, {
  required String message,
}) {
  Flushbar<void>(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    message: message,
    backgroundColor: const Color(0xFFF04438),
    flushbarPosition: FlushbarPosition.TOP,
    duration: const Duration(seconds: 5),
    icon: const Icon(
      Icons.error,
      color: Colors.white,
    ),
    borderRadius: BorderRadius.circular(12),
  ).show(context);
}

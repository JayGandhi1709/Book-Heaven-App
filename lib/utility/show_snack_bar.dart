import 'package:flutter/material.dart';
import 'package:get/get.dart';

final bgColor = {
  'success': Colors.green,
  'error': Colors.red,
  'warning': Colors.yellow,
  'info': Colors.transparent,
};

final txtColor = {
  'success': Colors.white,
  'error': Colors.white,
  'warning': Colors.black,
  'info': Colors.white,
};

final icons = {
  'success': Icons.check_circle,
  'error': Icons.error,
  'warning': Icons.warning,
  'info': Icons.info,
};

enum MsgType {
  success,
  error,
  warning,
  info,
}

// enum for MsgType with String value
extension MsgTypeExtension on MsgType {
  String get value {
    switch (this) {
      case MsgType.success:
        return 'success';
      case MsgType.error:
        return 'error';
      case MsgType.warning:
        return 'warning';
      case MsgType.info:
        return "info";
      default:
        return '';
    }
  }
}

void showSnackBar(String message, MsgType type,
    {title, showCloseIcon = false}) {
  Get.snackbar(
    title ?? MsgTypeExtension(type).value,
    message,
    backgroundColor: bgColor[MsgTypeExtension(type).value],
    colorText: txtColor[MsgTypeExtension(type).value],
    borderRadius: 20,
    duration: const Duration(seconds: 3),
    icon: Icon(
      icons[MsgTypeExtension(type).value],
      color: txtColor[MsgTypeExtension(type).value],
    ),
    barBlur: 100,
    isDismissible: showCloseIcon,
    dismissDirection: DismissDirection.up,
  );
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<void> checkMicPermission({
    required BuildContext context,
    Function? onGranted,
    Function? onDenied,
    Function? onPermanentlyDenied,
  }) async {
    var status = await Permission.microphone.request();
    switch (status) {
      case PermissionStatus.granted:
        onGranted?.call();
        return;
      case PermissionStatus.denied:
        onDenied?.call();
        return;
      case PermissionStatus.permanentlyDenied:
        onPermanentlyDenied?.call();
        return;
      default:
        return;
    }
  }
}

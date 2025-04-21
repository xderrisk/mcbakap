import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;

class PermissionService {
  Future<bool> checkPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.manageExternalStorage.status;
      return status.isGranted;
    }
    return true;
  }

  Future<bool> requestPermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.manageExternalStorage.request();
      return status.isGranted;
    }
    return true;
  }
}
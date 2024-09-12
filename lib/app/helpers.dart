import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class Helpers {

  static String getFormattedDateTime() {
    final DateTime now = DateTime.now();
    String twoDigit(int value) {
      return value.toString().padLeft(2, '0');
    }
    return '${now.year}_${twoDigit(now.month)}_${twoDigit(now.day)}_${twoDigit(now.hour)}_${twoDigit(now.minute)}_${twoDigit(now.second)}';
  }


  static Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  static Future<AndroidDeviceInfo> checkAndroidInfo () async {
    final plugin = DeviceInfoPlugin();
    final android = await plugin.androidInfo;
    return android;
  }

  static Future<void> requestPermissionMediaLibrary() async {
    final permitted = await Permission.mediaLibrary.request().isGranted &&
        await Permission.photos.request().isGranted;

    print("permitted $permitted");

  }


}
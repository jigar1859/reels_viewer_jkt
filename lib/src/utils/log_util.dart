import 'dart:developer';

class LogUtil {
  static debugLog({String tag = 'reels_viewer_jkt', required dynamic value}) {
    log("TAG $tag : ${value.toString()}");
  }
}

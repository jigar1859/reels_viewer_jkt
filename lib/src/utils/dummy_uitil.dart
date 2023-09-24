import 'dart:developer';

class LogUtil {
  static debugLog({String tag = 'ShortVideosApp', required dynamic value}) {
    log("TAG $tag : ${value.toString()}");
  }
}

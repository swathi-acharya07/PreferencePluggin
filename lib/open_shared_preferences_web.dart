// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'open_shared_preferences_platform_interface.dart';

/// A web implementation of the OpenSharedPreferencesPlatform of the OpenSharedPreferences plugin.
class OpenSharedPreferencesWeb extends OpenSharedPreferencesPlatform {
  /// Constructs a OpenSharedPreferencesWeb
  OpenSharedPreferencesWeb();

  static void registerWith(Registrar registrar) {
    OpenSharedPreferencesPlatform.instance = OpenSharedPreferencesWeb();
  }

  @override
  Future saveData({required Object object, required String key}) async {
    html.window.localStorage[key] = object.toString();
  }

  @override
  Future getInt({required String key}) async {
    if (html.window.localStorage.containsKey(key)) {
      return int.parse(html.window.localStorage[key] ?? "");
    } else {
      return 0;
    }
  }

  @override
  Future getString({required String key}) async {
    if (html.window.localStorage.containsKey(key)) {
      return html.window.localStorage[key] ?? "";
    } else {
      return "";
    }
  }

  @override
  Future getBool({required String key}) async {
    if (html.window.localStorage.containsKey(key)) {
      return (html.window.localStorage[key] ?? "false").parseBool();
    } else {
      return false;
    }
  }

  @override
  Future getDouble({required String key}) async {
    if (html.window.localStorage.containsKey(key)) {
      return double.parse(html.window.localStorage[key] ?? "");
    } else {
      return 0.0;
    }
  }

  // @override
  // Future getFloat({required String key}) async {
  //   return html.window.localStorage[key];
  // }

  @override
  Future getLong({required String key}) async {
    if (html.window.localStorage.containsKey(key)) {
      return html.window.localStorage[key] ?? "";
    } else {
      return "";
    }
  }

  @override
  Future removeAll() async {
    html.window.localStorage.clear();
  }

  @override
  Future remove({required String key}) async {
    html.window.localStorage.remove(key);
  }

  @override
  Future<bool> contain({required String key}) async {
    return html.window.localStorage.containsKey(key);
  }
}

extension BoolParsing on String {
  bool parseBool() {
    if (toLowerCase() == 'true') {
      return true;
    } else if (toLowerCase() == 'false') {
      return false;
    }
    throw '"$this" can not be parsed to boolean.';
  }
}

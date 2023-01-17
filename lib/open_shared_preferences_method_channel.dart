import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'open_shared_preferences_platform_interface.dart';

enum PreferencesConstants {
  save,
  getInt,
  getString,
  getBool,
  getDouble,
  getLong,
  removeAll,
  remove,
  contains,
  key,
  value,
}

/// An implementation of [OpenSharedPreferencesPlatform] that uses method channels.
class MethodChannelOpenSharedPreferences extends OpenSharedPreferencesPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final _channel = const MethodChannel('open_shared_preferences');

  @override
  Future<void> saveData({required Object object, required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.save.name, {
      PreferencesConstants.key.name: key,
      PreferencesConstants.value.name: object
    });
  }

  @override
  Future<int> getInt({required String key}) async {
    return await _channel.invokeMethod(
        PreferencesConstants.getInt.name, {PreferencesConstants.key.name: key});
  }

  @override
  Future<String> getString({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.getString.name,
        {PreferencesConstants.key.name: key});
  }

  @override
  Future<bool> getBool({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.getBool.name,
        {PreferencesConstants.key.name: key});
  }

  @override
  Future<double> getDouble({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.getDouble.name,
        {PreferencesConstants.key.name: key});
  }

  // @override
  // Future getFloat({required String key}) async {
  //   return await _channel.invokeMethod('getFloat', {"key": key});
  // }

  @override
  Future getLong({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.getLong.name,
        {PreferencesConstants.key.name: key});
  }

  @override
  Future removeAll() async {
    return await _channel.invokeMapMethod(PreferencesConstants.removeAll.name);
  }

  @override
  Future remove({required String key}) async {
    return await _channel.invokeMethod(
        PreferencesConstants.remove.name, {PreferencesConstants.key.name: key});
  }

  @override
  Future<bool> contains({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.contains.name,
        {PreferencesConstants.key.name: key});
  }
}

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
  removePermanentDataKeys,
}

const keyPrefix = "open_money.";
const permanentKey = "open_money_premanent.";

/// An implementation of [OpenSharedPreferencesPlatform] that uses method channels.
class MethodChannelOpenSharedPreferences extends OpenSharedPreferencesPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final _channel = const MethodChannel('open_shared_preferences');

  @override
  Future<void> saveData({required Object object, required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.save.name, {
      PreferencesConstants.key.name: keyPrefix + key,
      PreferencesConstants.value.name: object
    });
  }

  @override
  Future<int> getInt({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.getInt.name,
        {PreferencesConstants.key.name: keyPrefix + key});
  }

  @override
  Future<String> getString({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.getString.name,
        {PreferencesConstants.key.name: keyPrefix + key});
  }

  @override
  Future<bool> getBool({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.getBool.name,
        {PreferencesConstants.key.name: keyPrefix + key});
  }

  @override
  Future<double> getDouble({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.getDouble.name,
        {PreferencesConstants.key.name: keyPrefix + key});
  }

  // @override
  // Future getFloat({required String key}) async {
  //   return await _channel.invokeMethod('getFloat', {"key": key});
  // }

  @override
  Future getLong({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.getLong.name,
        {PreferencesConstants.key.name: keyPrefix + key});
  }

  @override
  Future removeAll() async {
    return await _channel.invokeMapMethod(PreferencesConstants.removeAll.name);
  }

  @override
  Future remove({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.remove.name,
        {PreferencesConstants.key.name: keyPrefix + key});
  }

  @override
  Future<bool> contain({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.contains.name,
        {PreferencesConstants.key.name: keyPrefix + key});
  }
}

class PermanentMethodChannelOpenSharedPreferences
    extends PermanentOpenSharedPreferencesPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final _channel = const MethodChannel('open_shared_preferences');

  @override
  Future saveData({required Object object, required String key}) async {
    await _channel.invokeMethod(PreferencesConstants.save.name, {
      PreferencesConstants.key.name: permanentKey + key,
      PreferencesConstants.value.name: object
    });
  }

  @override
  Future getInt({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.getInt.name,
        {PreferencesConstants.key.name: permanentKey + key});
  }

  @override
  Future getString({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.getString.name,
        {PreferencesConstants.key.name: permanentKey + key});
  }

  @override
  Future getBool({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.getBool.name,
        {PreferencesConstants.key.name: permanentKey + key});
  }

  @override
  Future getDouble({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.getDouble.name,
        {PreferencesConstants.key.name: permanentKey + key});
  }

  // @override
  // Future getFloat({required String key}) async {
  //   return await _channel.invokeMethod('getFloat', {"key": key});
  // }

  @override
  Future getLong({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.getLong.name,
        {PreferencesConstants.key.name: permanentKey + key});
  }

  @override
  Future removeAll() async {
    await _channel
        .invokeMapMethod(PreferencesConstants.removePermanentDataKeys.name);
  }

  @override
  Future remove({required String key}) async {
    await _channel.invokeMethod(PreferencesConstants.remove.name,
        {PreferencesConstants.key.name: permanentKey + key});
  }

  @override
  Future<bool> contain({required String key}) async {
    return await _channel.invokeMethod(PreferencesConstants.contains.name,
        {PreferencesConstants.key.name: permanentKey + key});
  }
}

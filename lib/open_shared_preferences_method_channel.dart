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
  isPersistant,
}

const keyPrefix = "open_money.";
const permanentKey = "open_money_permanent.";

/// An implementation of [OpenSharedPreferencesPlatform] that uses method channels.
class MethodChannelOpenSharedPreferences extends OpenSharedPreferencesPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final _channel = const MethodChannel('open_shared_preferences');

  @override
  Future saveData({
    required Object object,
    required String key,
    bool isPersistedData = false,
  }) async {
    await _channel.invokeMethod(PreferencesConstants.save.name, {
      PreferencesConstants.key.name:
          isPersistedData == true ? permanentKey + key : keyPrefix + key,
      PreferencesConstants.value.name: object,
      PreferencesConstants.isPersistant.name: isPersistedData,
    });
  }

  @override
  Future<int> getInt({
    required String key,
    bool isPersistedData = false,
  }) async {
    return await _channel.invokeMethod(PreferencesConstants.getInt.name, {
      PreferencesConstants.key.name:
          isPersistedData == true ? permanentKey + key : keyPrefix + key,
      PreferencesConstants.isPersistant.name: isPersistedData,
    });
  }

  @override
  Future<String> getString({
    required String key,
    bool isPersistedData = false,
  }) async {
    return await _channel.invokeMethod(PreferencesConstants.getString.name, {
      PreferencesConstants.key.name:
          isPersistedData == true ? permanentKey + key : keyPrefix + key,
      PreferencesConstants.isPersistant.name: isPersistedData,
    });
  }

  @override
  Future<bool> getBool({
    required String key,
    bool isPersistedData = false,
  }) async {
    return await _channel.invokeMethod(PreferencesConstants.getBool.name, {
      PreferencesConstants.key.name:
          isPersistedData == true ? permanentKey + key : keyPrefix + key,
      PreferencesConstants.isPersistant.name: isPersistedData,
    });
  }

  @override
  Future<double> getDouble({
    required String key,
    bool isPersistedData = false,
  }) async {
    return await _channel.invokeMethod(PreferencesConstants.getDouble.name, {
      PreferencesConstants.key.name:
          isPersistedData == true ? permanentKey + key : keyPrefix + key,
      PreferencesConstants.isPersistant.name: isPersistedData,
    });
  }

  // @override
  // Future getFloat({required String key}) async {
  //   return await _channel.invokeMethod('getFloat', {"key": key});
  // }

  @override
  Future getLong({
    required String key,
    bool isPersistedData = false,
  }) async {
    return await _channel.invokeMethod(PreferencesConstants.getLong.name, {
      PreferencesConstants.key.name:
          isPersistedData == true ? permanentKey + key : keyPrefix + key,
      PreferencesConstants.isPersistant.name: isPersistedData,
    });
  }

  @override
  Future removeAll({bool isPersistedData = false}) async {
    isPersistedData == true
        ? await _channel.invokeMapMethod(
            PreferencesConstants.removePermanentDataKeys.name,
            {PreferencesConstants.isPersistant.name: isPersistedData})
        : await _channel.invokeMapMethod(PreferencesConstants.removeAll.name,
            {PreferencesConstants.isPersistant.name: isPersistedData});
  }

  @override
  Future remove({
    required String key,
    bool isPersistedData = false,
  }) async {
    await _channel.invokeMethod(PreferencesConstants.remove.name, {
      PreferencesConstants.key.name:
          isPersistedData == true ? permanentKey + key : keyPrefix + key,
      PreferencesConstants.isPersistant.name: isPersistedData,
    });
  }

  @override
  Future<bool> contain({
    required String key,
    bool isPersistedData = false,
  }) async {
    return await _channel.invokeMethod(PreferencesConstants.contains.name, {
      PreferencesConstants.key.name:
          isPersistedData == true ? permanentKey + key : keyPrefix + key,
      PreferencesConstants.isPersistant.name: isPersistedData,
    });
  }
}

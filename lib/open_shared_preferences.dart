import 'open_shared_preferences_platform_interface.dart';

class OpenSharedPreferences {
  Future saveData({
    required Object object,
    required String key,
    bool isPersistedData = false,
  }) async {
    return await OpenSharedPreferencesPlatform.instance
        .saveData(object: object, key: key, isPersistedData: isPersistedData);
  }

  Future<int> getInt({
    required String key,
    bool isPersistedData = false,
  }) async {
    return await OpenSharedPreferencesPlatform.instance
        .getInt(key: key, isPersistedData: isPersistedData);
  }

  Future<String> getString({
    required String key,
    bool isPersistedData = false,
  }) async {
    return await OpenSharedPreferencesPlatform.instance
        .getString(key: key, isPersistedData: isPersistedData);
  }

  Future<bool> getBool({
    required String key,
    bool isPersistedData = false,
  }) async {
    return await OpenSharedPreferencesPlatform.instance
        .getBool(key: key, isPersistedData: isPersistedData);
  }

  Future<double> getDouble({
    required String key,
    bool isPersistedData = false,
  }) async {
    return await OpenSharedPreferencesPlatform.instance
        .getDouble(key: key, isPersistedData: isPersistedData);
  }

  // Future getFloat({required String key}) async {
  //   return await OpenSharedPreferencesPlatform.instance.getFloat(key: key);
  // }

  Future getLong({
    required String key,
    bool isPersistedData = false,
  }) async {
    return await OpenSharedPreferencesPlatform.instance
        .getLong(key: key, isPersistedData: isPersistedData);
  }

  Future removeAll({bool isPersistedData = false}) async {
    await OpenSharedPreferencesPlatform.instance
        .removeAll(isPersistedData: isPersistedData);
  }

  Future remove({
    required String key,
    bool isPersistedData = false,
  }) async {
    await OpenSharedPreferencesPlatform.instance
        .remove(key: key, isPersistedData: isPersistedData);
  }

  Future<bool> contain({
    required String key,
    bool isPersistedData = false,
  }) async {
    return await OpenSharedPreferencesPlatform.instance
        .contain(key: key, isPersistedData: isPersistedData);
  }
}

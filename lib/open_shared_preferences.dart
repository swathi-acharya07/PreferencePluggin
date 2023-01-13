import 'open_shared_preferences_platform_interface.dart';

class OpenSharedPreferences {
  Future saveData({required Object object, required String key}) async {
    return OpenSharedPreferencesPlatform.instance
        .saveData(object: object, key: key);
  }

  Future getInt({required String key}) async {
    return await OpenSharedPreferencesPlatform.instance.getInt(key: key);
  }

  Future getString({required String key}) async {
    return await OpenSharedPreferencesPlatform.instance.getString(key: key);
  }

  Future getBool({required String key}) async {
    return await OpenSharedPreferencesPlatform.instance.getBool(key: key);
  }

  Future getDouble({required String key}) async {
    return await OpenSharedPreferencesPlatform.instance.getDouble(key: key);
  }

  // Future getFloat({required String key}) async {
  //   return await OpenSharedPreferencesPlatform.instance.getFloat(key: key);
  // }

  Future getLong({required String key}) async {
    return await OpenSharedPreferencesPlatform.instance.getLong(key: key);
  }

  Future removeAll() async {
    await OpenSharedPreferencesPlatform.instance.removeAll();
  }

  Future remove({required String key}) async {
    await OpenSharedPreferencesPlatform.instance.remove(key: key);
  }

  Future<bool> contain({required String key}) async {
    return await OpenSharedPreferencesPlatform.instance.contain(key: key);
  }
}

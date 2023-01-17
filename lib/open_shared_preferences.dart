import 'open_shared_preferences_platform_interface.dart';

class OpenSharedPreferences {
  Future<void> saveData({required Object object, required String key}) async {
    return await OpenSharedPreferencesPlatform.instance
        .saveData(object: object, key: key);
  }

  Future<int> getInt({required String key}) async {
    return await OpenSharedPreferencesPlatform.instance.getInt(key: key);
  }

  Future<String> getString({required String key}) async {
    return await OpenSharedPreferencesPlatform.instance.getString(key: key);
  }

  Future<bool> getBool({required String key}) async {
    return await OpenSharedPreferencesPlatform.instance.getBool(key: key);
  }

  Future<double> getDouble({required String key}) async {
    return await OpenSharedPreferencesPlatform.instance.getDouble(key: key);
  }

  // Future getFloat({required String key}) async {
  //   return await OpenSharedPreferencesPlatform.instance.getFloat(key: key);
  // }

  Future getLong({required String key}) async {
    return await OpenSharedPreferencesPlatform.instance.getLong(key: key);
  }

  Future<void> removeAll() async {
    return await OpenSharedPreferencesPlatform.instance.removeAll();
  }

  Future<void> remove({required String key}) async {
    return await OpenSharedPreferencesPlatform.instance.remove(key: key);
  }

  Future<bool> contain({required String key}) async {
    return await OpenSharedPreferencesPlatform.instance.contains(key: key);
  }
}

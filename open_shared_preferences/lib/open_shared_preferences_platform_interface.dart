import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'open_shared_preferences_method_channel.dart';

abstract class OpenSharedPreferencesPlatform extends PlatformInterface {
  /// Constructs a OpenSharedPreferencesPlatform.
  OpenSharedPreferencesPlatform() : super(token: _token);

  static final Object _token = Object();

  static OpenSharedPreferencesPlatform _instance =
      MethodChannelOpenSharedPreferences();

  /// The default instance of [OpenSharedPreferencesPlatform] to use.
  ///
  /// Defaults to [MethodChannelOpenSharedPreferences].
  static OpenSharedPreferencesPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OpenSharedPreferencesPlatform] when
  /// they register themselves.
  static set instance(OpenSharedPreferencesPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future saveData({required Object object, required String key}) async {
    throw ("Unimplemented method");
  }

  Future getInt({required String key}) async {
    throw ("Unimplemented method");
  }

  Future getString({required String key}) async {
    throw ("Unimplemented method");
  }

  Future getBool({required String key}) async {
    throw ("Unimplemented method");
  }

  Future getDouble({required String key}) async {
    throw ("Unimplemented method");
  }

  // Future getFloat({required String key}) async {
  //   throw ("Unimplemented method");
  // }

  Future getLong({required String key}) async {
    throw ("Unimplemented method");
  }

  Future removeAll() async {
    throw ("Unimplemented method");
  }

  Future remove({required String key}) async {
    throw ("Unimplemented method");
  }

  Future contain({required String key}) async {
    throw ("Unimplemented method");
  }
}

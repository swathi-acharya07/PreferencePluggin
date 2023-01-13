import 'package:flutter_test/flutter_test.dart';
import 'package:open_shared_preferences/open_shared_preferences.dart';
import 'package:open_shared_preferences/open_shared_preferences_platform_interface.dart';
import 'package:open_shared_preferences/open_shared_preferences_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockOpenSharedPreferencesPlatform
    with MockPlatformInterfaceMixin
    implements OpenSharedPreferencesPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future contain({required String key}) {
    throw UnimplementedError();
  }

  @override
  Future getBool({required String key}) {
    throw UnimplementedError();
  }

  @override
  Future getDouble({required String key}) {
    throw UnimplementedError();
  }

  @override
  Future getInt({required String key}) {
    throw UnimplementedError();
  }

  @override
  Future getLong({required String key}) {
    throw UnimplementedError();
  }

  @override
  Future getString({required String key}) {
    throw UnimplementedError();
  }

  @override
  Future remove({required String key}) {
    throw UnimplementedError();
  }

  @override
  Future removeAll() {
    throw UnimplementedError();
  }

  @override
  Future saveData({required Object object, required String key}) {
    throw UnimplementedError();
  }
}

void main() {
  final OpenSharedPreferencesPlatform initialPlatform =
      OpenSharedPreferencesPlatform.instance;

  test('$MethodChannelOpenSharedPreferences is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelOpenSharedPreferences>());
  });

  test('getPlatformVersion', () async {
    OpenSharedPreferences openSharedPreferencesPlugin = OpenSharedPreferences();
    MockOpenSharedPreferencesPlatform fakePlatform =
        MockOpenSharedPreferencesPlatform();
    OpenSharedPreferencesPlatform.instance = fakePlatform;

    // expect(await openSharedPreferencesPlugin.getPlatformVersion(), '42');
  });
}

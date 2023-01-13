import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_shared_preferences/open_shared_preferences_method_channel.dart';

void main() {
  MethodChannelOpenSharedPreferences platform =
      MethodChannelOpenSharedPreferences();
  const MethodChannel channel = MethodChannel('open_shared_preferences');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await platform.getPlatformVersion(), '42');
  });
}

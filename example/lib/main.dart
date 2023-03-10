import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:open_shared_preferences/open_shared_preferences.dart';
import 'package:open_shared_preferences/open_shared_preferences_method_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _openSharedPreferencesPlugin = OpenSharedPreferences();

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          // await _openSharedPreferencesPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> saveData() async {
    OpenSharedPreferences()
        .saveData(object: "swathi", key: "swat", isPersistedData: false);
    OpenSharedPreferences().saveData(
        object: "askjbajshdvabsd", key: "qwerty", isPersistedData: true);
    OpenSharedPreferences()
        .saveData(object: "smruthi", key: "123", isPersistedData: true);
  }

  Future<void> getData() async {
    bool val = await OpenSharedPreferences().contain(key: "abc");
    debugPrint(val.toString());
    bool val2 = await OpenSharedPreferences().contain(key: "abcc");
    debugPrint(val2.toString());
    var val3 = await OpenSharedPreferences()
        .getString(key: "qwerty", isPersistedData: true);
    debugPrint(val3.toString());
    OpenSharedPreferences().removeAll(isPersistedData: true);
    var val4 = await OpenSharedPreferences()
        .getString(key: "qwerty", isPersistedData: true);
    debugPrint(val4.toString());
    var val5 = await OpenSharedPreferences()
        .getString(key: "swat", isPersistedData: false);
    debugPrint(val5.toString());
    OpenSharedPreferences().removeAll(isPersistedData: false);
    var val6 = await OpenSharedPreferences()
        .getString(key: "swat", isPersistedData: false);
    debugPrint(val6.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            TextButton(
              onPressed: () async {
                await saveData();
              },
              child: const Text('Save Data'),
            ),
            const SizedBox(
              height: 100,
            ),
            TextButton(
              onPressed: () async {
                await getData();
              },
              child: const Text('Get Data'),
            ),
          ],
        ),
      ),
    );
  }
}

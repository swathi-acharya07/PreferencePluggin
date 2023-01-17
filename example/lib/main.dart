import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:open_shared_preferences/open_shared_preferences.dart';

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
    await OpenSharedPreferences()
        .saveData(object: true, key: "open_money.abcccc");
    await OpenSharedPreferences().saveData(object: 10, key: "open_money.abc");
    await OpenSharedPreferences()
        .saveData(object: 100.20, key: "open_money.abcc");
    await OpenSharedPreferences()
        .saveData(object: "swathi", key: "open_money.abccc");
  }

  Future<void> getData() async {
    await OpenSharedPreferences().remove(key: "open_money.abc");
    bool val = await OpenSharedPreferences().contain(key: "open_money.abc");
    bool val2 = await OpenSharedPreferences().contain(key: "open_money.def");
    debugPrint(val.toString());
    debugPrint(val2.toString());
    int valuInt = await OpenSharedPreferences().getInt(key: "open_money.abc");
    debugPrint(valuInt.toString());
    double valueDouble =
        await OpenSharedPreferences().getDouble(key: "open_money.abcc");
    debugPrint(valueDouble.toString());
    String valueString =
        await OpenSharedPreferences().getString(key: "open_money.abccc");
    debugPrint(valueString.toString());
    bool valueBool =
        await OpenSharedPreferences().getBool(key: "open_money.abcccc");
    debugPrint(valueBool.toString());
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

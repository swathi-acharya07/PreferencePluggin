import Flutter
import UIKit
import Foundation

struct Constants {
    static let value = "value"
    static let key = "key"
    static let save = "save"
    static let getInt = "getInt"
    static let getDouble = "getDouble"
    static let getBool = "getBool"
    static let getString = "getString"
    static let getFloat = "getFloat"
    static let getLong = "getLong"
    static let remove = "remove"
    static let removeAll = "removeAll"
    static let removePermanentDataKeys = "removePermanentDataKeys"
    static let contains = "contains"
    static let keyPrefix = "open_money."
    static let permanentKeyPrefix = "open_money_premanent."
}

public class SwiftOpenSharedPreferencesPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "open_shared_preferences", binaryMessenger: registrar.messenger())
    let instance = SwiftOpenSharedPreferencesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if let args = call.arguments as? [String: Any] {
        if (call.method == Constants.save) {
          save(value: args[Constants.value], key: args[Constants.key] as! String)
        } else if (call.method == Constants.getInt) {
          result(getInt(key: args[Constants.key] as! String))
        } else if (call.method == Constants.getString) {
          result(getString(key: args[Constants.key] as! String))
        } else if (call.method == Constants.getBool) {
          result(getBool(key: args[Constants.key] as! String))
        } else if (call.method == Constants.getDouble) {
          result(getDouble(key: args[Constants.key] as! String))
        } else if (call.method == Constants.getFloat) {
          result(getFloat(key: args[Constants.key] as! String))
        } else if (call.method == Constants.getLong) {
          result(getDouble(key: args[Constants.key] as! String))
        } else if (call.method == Constants.remove) {
          UserDefaults.standard.removeObject(forKey: args[Constants.key] as! String)
        } else if (call.method == Constants.contains) {
          result(UserDefaults.standard.valueExists(key: args[Constants.key] as! String))
        }
      } else {
        if (call.method == Constants.removeAll) {
          removeAllKeys()
        } else if (call.method == Constants.removePermanentDataKeys) {
          removeAllPermanentKeys()
        }
      }
  }

  func save(value: Any?, key: String) {
      UserDefaults.standard.set(value, forKey: key)
    }

    func getObject(key: String) -> [String: Any] {
      return UserDefaults.standard.value(forKey: key) as? [String: Any] ?? [:]
    }

    func getInt(key: String) -> Int {
      return UserDefaults.standard.value(forKey: key) as? Int ?? 0
    }

    func getString(key: String) -> String {
      return UserDefaults.standard.value(forKey: key) as? String ?? ""
    }

    func getBool(key: String) -> Bool {
      return UserDefaults.standard.value(forKey: key) as? Bool ??  false
    }

    func getDouble(key: String) -> Double {
      return UserDefaults.standard.value(forKey: key) as? Double ?? 0.0
    }

    func getFloat(key: String) -> Float {
      return UserDefaults.standard.value(forKey: key) as? Float ?? 0.0
    }

    func removeAllKeys() {
      UserDefaults.standard.removeAll()
    }

    func removeAllPermanentKeys() {
      UserDefaults.standard.removeAllPermanentData()
    }
}
extension UserDefaults {
  static let standard = UserDefaults.standard

  func valueExists(key: String) -> Bool {
    return object(forKey: key) != nil
  }

  func getAllKeys() -> [String] {
    var userKeys = [String]()
    var includedPrefixes = [Constants.keyPrefix]

    let defaultKeys = UserDefaults.standard.dictionaryRepresentation()
    let keys = defaultKeys.keys.filter { key in
      for prefix in includedPrefixes {
        if key.hasPrefix(prefix) {
          return true
        }
      }
      return false
    }
    for key in keys {
      if let value = defaultKeys[key] {
        print("\(key) = \(value)")
        userKeys.append(key)
      }
    }
    return userKeys
  }

    func getAllPermanentKeys() -> [String] {
    var userKeys = [String]()
    var includedPrefixes = [Constants.permanentKeyPrefix]

    let defaultKeys = UserDefaults.standard.dictionaryRepresentation()
    let keys = defaultKeys.keys.filter { key in
      for prefix in includedPrefixes {
        if key.hasPrefix(prefix) {
          return true
        }
      }
      return false
    }
    for key in keys {
      if let value = defaultKeys[key] {
        print("\(key) = \(value)")
        userKeys.append(key)
      }
    }
    return userKeys
  }

  func removeAll() {
    let keys = getAllKeys()
    for userKey in keys {
      UserDefaults.standard.removeObject(forKey: userKey)
    }
  }

  func removeAllPermanentData() {
    let keys = getAllPermanentKeys()
    for userKey in keys {
      UserDefaults.standard.removeObject(forKey: userKey)
    }
  }
}

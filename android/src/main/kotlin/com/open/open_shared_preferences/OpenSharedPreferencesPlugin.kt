package com.open.open_shared_preferences
import androidx.annotation.NonNull
import android.os.Handler
import android.os.Looper
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

const val value = "value"
const val key = "key"
const val save = "save"
const val getInt = "getInt"
const val getDouble = "getDouble"
const val getBool = "getBool"
const val getString = "getString"
const val getFloat = "getFloat"
const val getLong = "getLong"
const val remove = "remove"
const val removeAll = "removeAll"
const val contains = "contains"

/** OpenSharedPreferencesPlugin */
class OpenSharedPreferencesPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var mActivityPluginBinding: ActivityPluginBinding? = null
  private val mUIThreadHandler: Handler = Handler(Looper.getMainLooper())

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "open_shared_preferences")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    var prefs = Prefs.with(mActivityPluginBinding!!.activity)

    var value: Any? = call.argument<Any?>(value)
    var key: String? = if(call.argument<String?>(key)!= null) call.argument<String?>(key) else ""

    if (call.method == save) {
      var type: VariableType = value!!.getType()
      if (type == VariableType.STRING) {
        prefs.save(key!!, value.toString())
      } else if (type == VariableType.INT) {
        prefs.save(key!!, value as Int)
      } else if (type == VariableType.BOOL) {
        prefs.save(key!!, value as Boolean)
      } else if (type == VariableType.DOUBLE) {
        prefs.save(key!!, value as Double)
      } else if (type == VariableType.FLOAT) {
        prefs.save(key!!, value as Float)
      } else if (type == VariableType.LONG) {
        prefs.save(key!!, value as Long)
      }
      result.success(true)
    } else if (call.method == getInt) {
      result.success(prefs.getInt(key!!, 0))
    } else if (call.method == getDouble) {
      result.success(prefs.getDouble(key!!, 0.0))
    } else if (call.method == getBool) {
      result.success(prefs.getBoolean(key!!, false))
    } else if (call.method == getString) {
      result.success(prefs.getString(key!!, ""))
    } else if (call.method == getFloat) {
      result.success(prefs.getFloat(key!!, 0.0F))
    } else if (call.method == getLong) {
      result.success(prefs.getLong(key!!, 0))
    } else if (call.method == remove) {
      prefs.remove(key!!)
      result.success(true)
    } else if (call.method == removeAll) {
      prefs.removeAll()
      result.success(true)
    } else if (call.method == contains) {
      result.success(prefs.contains(key!!))
    } else {
      result.notImplemented()
    }
  }

enum class VariableType {
    INT, STRING, BOOL, DOUBLE, FLOAT, LONG
  }

  fun Any.getType(): VariableType {
    return when (this) {
        is Int -> VariableType.INT
        is String -> VariableType.STRING
        is Boolean -> VariableType.BOOL
        is Double -> VariableType.DOUBLE
        is Float -> VariableType.FLOAT
        is Long -> VariableType.LONG
        else -> VariableType.STRING
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    mActivityPluginBinding = binding
  }

  override fun onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity()
  }}

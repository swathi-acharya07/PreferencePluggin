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
const val isPersistant = "isPersistant"
const val removePermanentDataKeys = "removePermanentDataKeys"

/** OpenSharedPreferencesPlugin */
class OpenSharedPreferencesPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var mActivityPluginBinding: ActivityPluginBinding? = null
    private val mUIThreadHandler: Handler = Handler(Looper.getMainLooper())

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "open_shared_preferences")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        var prefs = Prefs.with(mActivityPluginBinding!!.activity)
        var permanentPrefs = PermanentPrefs.with(mActivityPluginBinding!!.activity)

        var value: Any? = call.argument<Any?>(value)
        var key: String? = if (call.argument<String?>(key) != null) call.argument<String?>(key) else ""
        var isPersistant: Boolean? = call.argument<Boolean?>(isPersistant)

        if (call.method == save) {
            var type: VariableType = value!!.getType()
            if (type == VariableType.STRING) {
                if (isPersistant == true) {
                    permanentPrefs.save(key!!, value.toString())
                } else {
                    prefs.save(key!!, value.toString())
                }
            } else if (type == VariableType.INT) {
                if (isPersistant == true) {
                    permanentPrefs.save(key!!, value as Int)
                } else {
                    prefs.save(key!!, value as Int)
                }
            } else if (type == VariableType.BOOL) {
                if (isPersistant == true) {
                    permanentPrefs.save(key!!, value as Boolean)
                } else {
                    prefs.save(key!!, value as Boolean)
                }
            } else if (type == VariableType.DOUBLE) {
                if (isPersistant == true) {
                    permanentPrefs.save(key!!, value as Double)
                } else {
                    prefs.save(key!!, value as Double)
                }
            } else if (type == VariableType.FLOAT) {
                if (isPersistant == true) {
                    permanentPrefs.save(key!!, value as Float)
                } else {
                    prefs.save(key!!, value as Float)
                }
            } else if (type == VariableType.LONG) {
                if (isPersistant == true) {
                    permanentPrefs.save(key!!, value as Long)
                } else {
                    prefs.save(key!!, value as Long)
                }
            }
        } else if (call.method == getInt) {
            if (isPersistant == true) {
                result.success(permanentPrefs.getInt(key!!, 0))
            } else {
                result.success(prefs.getInt(key!!, 0))
            }
        } else if (call.method == getDouble) {
            if (isPersistant == true) {
                result.success(permanentPrefs.getDouble(key!!, 0.0))
            } else {
                result.success(prefs.getDouble(key!!, 0.0))
            }
        } else if (call.method == getBool) {
            if (isPersistant == true) {
                result.success(permanentPrefs.getBoolean(key!!, false))
            } else {
                result.success(prefs.getBoolean(key!!, false))
            }
        } else if (call.method == getString) {
            if (isPersistant == true) {
                result.success(permanentPrefs.getString(key!!, ""))
            } else {
                result.success(prefs.getString(key!!, ""))
            }
        } else if (call.method == getFloat) {
            if (isPersistant == true) {
                result.success(permanentPrefs.getFloat(key!!, 0.0F))
            } else {
                result.success(prefs.getFloat(key!!, 0.0F))
            }
        } else if (call.method == getLong) {
            if (isPersistant == true) {
                result.success(permanentPrefs.getLong(key!!, 0))
            } else {
                result.success(prefs.getLong(key!!, 0))
            }
        } else if (call.method == remove) {
            if (isPersistant == true) {
                result.success(permanentPrefs.remove(key!!))
            } else {
                result.success(prefs.remove(key!!))
            }
        } else if (call.method == removeAll) {
            prefs.removeAll()
        } else if (call.method == removePermanentDataKeys) {
            permanentPrefs.removeAll()
        } else if (call.method == contains) {
            if (isPersistant == true) {
                result.success(permanentPrefs.contains(key!!))
            } else {
                result.success(prefs.contains(key!!))
            }
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
    }
}

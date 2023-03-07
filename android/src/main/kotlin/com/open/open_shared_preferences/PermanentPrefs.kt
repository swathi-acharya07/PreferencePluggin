package com.open.open_shared_preferences
import android.content.Context
import android.content.SharedPreferences
import androidx.core.content.edit
import androidx.security.crypto.EncryptedSharedPreferences
import androidx.security.crypto.MasterKeys
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken


class PermanentPrefs internal constructor(context: Context) {
    internal var typeOfObject = object : TypeToken<Any>() {

    }.type

    val all: Map<String, *>
        get() = preferences.all

    init {
        preferences = context.getSharedPreferences(TAG, Context.MODE_PRIVATE)
        editor = preferences.edit()
    }

    fun save(key: String, value: Boolean) {
        editor.putBoolean(key, value).apply()
    }

    fun save(key: String, value: String) {
        editor.putString(key, value).apply()
    }

    fun save(key: String, value: Int) {
        editor.putInt(key, value).apply()
    }

    fun save(key: String, value: Float) {
        editor.putFloat(key, value).apply()
    }

    fun save(key: String, value: Double) {
        editor.putFloat(key, value.toFloat()).apply()
    }

    fun save(key: String, value: Long) {
        editor.putLong(key, value).apply()
    }

    fun save(key: String, value: Set<String>) {
        editor.putStringSet(key, value).apply()
    }

    fun getBoolean(key: String, defValue: Boolean): Boolean {
        return preferences.getBoolean(key, defValue)
    }

    fun getString(key: String, defValue: String?): String? {
        return preferences.getString(key, defValue)
    }

    fun getInt(key: String, defValue: Int): Int {
        return preferences.getInt(key, defValue)
    }

    fun getFloat(key: String, defValue: Float): Float {
        return preferences.getFloat(key, defValue)
    }

    fun getDouble(key: String, defValue: Double): Double {
        return preferences.getFloat(key, defValue.toFloat()).toDouble()
    }

    fun getLong(key: String, defValue: Long): Long {
        return preferences.getLong(key, defValue)
    }

    fun getStringSet(key: String, defValue: Set<String>): Set<String>? {
        return preferences.getStringSet(key, defValue)
    }

    fun remove(key: String) {
        editor.remove(key).apply()
    }

    fun removeAll() {
        try
        {
            editor.clear()
            editor.apply()
        }
        catch(e: Exception)
        {
            e.printStackTrace()
        }
       
    }

    operator fun contains(key: String): Boolean {
        return if (preferences.contains(key)) {
            true
        } else false
    }

    private class Builder(context: Context?) {

        private val context: Context

        init {
            if (context == null) {
                throw IllegalArgumentException("Context must not be null.")
            }
            this.context = context.applicationContext
        }

        /**
         * Method that creates an instance of PermanentPrefs
         *
         * @return an instance of PermanentPrefs
         */
        fun build(): PermanentPrefs {
            return PermanentPrefs(context)
        }
    }

    companion object {

        private val TAG = "PermanentPrefs"

        internal var singleton: PermanentPrefs? = null

        internal lateinit var preferences: SharedPreferences

        internal lateinit var editor: SharedPreferences.Editor

        private val GSON = Gson()

        fun with(context: Context): PermanentPrefs {
            if (singleton == null) {
                singleton = Builder(context).build()
            }
            return singleton as PermanentPrefs
        }
    }
}
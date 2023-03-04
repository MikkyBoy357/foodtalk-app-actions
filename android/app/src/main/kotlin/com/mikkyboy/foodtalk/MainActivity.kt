package com.mikkyboy.foodtalk

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity(), MethodChannel.MethodCallHandler {
    private val BATTERY_CHANNEL = "mikkyboy.com/battery"
    private val ASSISTANT_CHANNEL = "mikkyboy.com/assistantChannel"

    private lateinit var batteryChannel: MethodChannel
    private lateinit var assistantChannel: MethodChannel

    // App Actions
    private val TAG = "FoodTalk"
    private var KEY = ""
    private var NAME = ""

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        // Logging for troubleshooting purposes
        logIntent(intent)

        val widgetChannel =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, WidgetHelper.CHANNEL)
        widgetChannel.setMethodCallHandler(this)


        // =========> Battery <=========
        batteryChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BATTERY_CHANNEL)

        // Receive data from Flutter
        batteryChannel.setMethodCallHandler { call, result ->
            if (call.method!!.contentEquals("getBatteryLevel")) {
                val arguments: Map<String, String>? = call.arguments()
                val name = arguments?.get("name")

                val batteryLevel = getBatteryLevel()

                result.success(batteryLevel)
            }
        }

        assistantChannel =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ASSISTANT_CHANNEL)

        // CHECK AND SEND INTENT DATA TO FLUTTER
        assistantChannel.setMethodCallHandler { call, result ->
            // Logging for troubleshooting purposes
            logIntent(intent)

            if (call.method!!.contentEquals("checkForIntent")) {
                val arguments: Map<String, String>? = call.arguments()
                val name = arguments?.get("name")

                val intentData: Map<String, String> = mapOf("key" to KEY, "name" to NAME)

                result.success(intentData)
            }
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "initialize" -> {
                if (call.arguments == null) return
                WidgetHelper.setHandle(this, call.arguments as Long)
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val iFilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            val batteryStatus: Intent? = context.registerReceiver(null, iFilter)
            val level = batteryStatus?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
            val scale = batteryStatus?.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
            val batteryPct = level!! / scale!!.toDouble()
            batteryLevel = (batteryPct * 100).toInt()
        }
        println("====> MyBattery <====")
        return batteryLevel
    }

    fun logIntent(intent: Intent) {
        KEY = ""
        NAME = ""
        val bundle: Bundle = intent.extras ?: return

        Log.d(TAG, "======= logIntent ========= %s")
        Log.d(TAG, "Logging intent data start")

        bundle.keySet().forEach { key ->
            Log.d("YO", "[$key=${bundle.get(key)}]")
//            KEY = bundle.keySet().first()
//            NAME = "${bundle.get(bundle.keySet().first())}"
            println("key => $key")
            if (key == "get_thing") {
                KEY = "$key"
                NAME = "${bundle.get(key)}"
            } else if (key == "open_app") {
                KEY = "$key"
                NAME = "${bundle.get(key)}"
            } else if (key == "name") {
                KEY = "$key"
                NAME = "${bundle.get(key)}"
            }
            println("LOL_KEY => $KEY")
            println("LOL_NAME => $NAME")
        }

        Log.d(TAG, "Logging intent data complete")
    }
}


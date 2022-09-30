package com.mikkyboy.foodtalk

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.widget.RemoteViews
import com.google.assistant.appactions.widgets.AppActionsWidgetExtension
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.view.FlutterCallbackInformation
import io.flutter.view.FlutterMain

class CustomAppWidgetProvider : AppWidgetProvider(), MethodChannel.Result {

    private val TAG = "TimTim"

    var KEY = ""
    var NAME = ""

    companion object {
        private var channel: MethodChannel? = null;
    }

    private var context: Context? = null

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        this.context = context

        initializeFlutter()


        for (appWidgetId in appWidgetIds) {
            // Get Query data from Google Assitant
            val paramsQueryData: Map<String, Any?> =
                extractQueryData(context, appWidgetManager, appWidgetId)
            var foodName: String = ""

            println("paramsQueryData => $paramsQueryData")
            if (paramsQueryData.isNotEmpty()) {
                foodName = paramsQueryData["name"] as String
            }
            println("foodName => $foodName")

            updateWidget("Waiting for value", "WAITING", "WAITING", appWidgetId, context)

            // Pass over the id so we can update it later...
            channel?.invokeMethod(foodName, appWidgetId, this)
        }

        // Perform this loop procedure for each App Widget that belongs to this provider
        appWidgetIds.forEach { appWidgetId ->
            // Create an Intent to launch ExampleActivity
            val pendingIntentApp: PendingIntent = Intent(context, MainActivity::class.java)
                .let { intent ->
                    PendingIntent.getActivity(context, 0, intent, 0)
                }

            val pendingIntentSettings: PendingIntent = Intent(context, MainActivity::class.java)
                .let { intent ->
                    PendingIntent.getActivity(context, 0, intent, 0)
                }

            // Get the layout for the App Widget and attach an on-click listener
            // to the button
            val views: RemoteViews = RemoteViews(
                context.packageName,
                R.layout.widget_layout
            ).apply {
                setOnClickPendingIntent(R.id.btnDeliveryStatus, pendingIntentApp)
                setOnClickPendingIntent(R.id.btnDeliveryStatus, pendingIntentSettings)
            }

            // Tell the AppWidgetManager to perform an update on the current app widget
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    private fun initializeFlutter() {
        if (context == null) {
            Log.e(TAG, "Context is null")
            return
        }
        if (channel == null) {
            FlutterMain.startInitialization(context!!)
            FlutterMain.ensureInitializationComplete(context!!, arrayOf())

            val handle = WidgetHelper.getRawHandle(context!!)
            if (handle == WidgetHelper.NO_HANDLE) {
                Log.w(TAG, "Couldn't update widget because there is no handle stored!")
                return
            }

            val callbackInfo = FlutterCallbackInformation.lookupCallbackInformation(handle)
            // You could also use a hard coded value to save you from all
            // the hassle with SharedPreferences, but alas when running your
            // app in release mode this would fail.
            val entryPointFunctionName = callbackInfo.callbackName

            // Instantiate a FlutterEngine.
            val engine = FlutterEngine(context!!.applicationContext)
            val entryPoint =
                DartExecutor.DartEntrypoint(FlutterMain.findAppBundlePath(), entryPointFunctionName)
            engine.dartExecutor.executeDartEntrypoint(entryPoint)

            // Register Plugins when in background. When there
            // is already an engine running, this will be ignored (although there will be some
            // warnings in the log).
            GeneratedPluginRegistrant.registerWith(engine)

            channel = MethodChannel(engine.dartExecutor.binaryMessenger, WidgetHelper.CHANNEL)
        }
    }

    override fun success(result: Any?) {
        Log.d(TAG, "success $result")

        val args = result as HashMap<*, *>
        val id = args["id"] as Int
        val value = args["value"] as Double
        val name = args["name"] as String
        val deliveryStatus = args["deliveryStatus"] as String

        updateWidget("onDart $value", name, deliveryStatus, id, context!!)
    }

    override fun notImplemented() {
        Log.d(TAG, "notImplemented")
    }

    override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
        Log.d(TAG, "onError $errorCode")
        Log.d(TAG, "onErrorMessage $errorMessage")
        Log.d(TAG, "onErrorDetails $errorDetails")
    }

    override fun onDisabled(context: Context?) {
        super.onDisabled(context)
        channel = null
    }
}


internal fun updateWidget(
    text: String,
    name: String,
    deliveryStatus: String,
    appWidgetId: Int,
    context: Context
) {
    val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {
        setTextViewText(R.id.tvCurrentFood, name)
        setTextViewText(R.id.btnDeliveryStatus, deliveryStatus)
    }

    val manager = AppWidgetManager.getInstance(context)
    manager.updateAppWidget(appWidgetId, views)
//    views.setTextViewText(R.id.text2, currentFood.codeName)
}

fun extractQueryData(
    context: Context,
    appWidgetManager: AppWidgetManager,
    appWidgetId: Int
): Map<String, Any?> {
    // AppActionsWidgetExtension
    val optionsBundle: Bundle = appWidgetManager.getAppWidgetOptions(appWidgetId)
    val bii: String =
        optionsBundle.getString(AppActionsWidgetExtension.EXTRA_APP_ACTIONS_BII) ?: ""
    val params: Bundle? =
        optionsBundle.getBundle(AppActionsWidgetExtension.EXTRA_APP_ACTIONS_PARAMS)

    if (params != null && params.containsKey(("name"))) {
        val orderName: String? = params.getString("name")
        println("ORDER NAME => $orderName")
        println("BII => $bii")
        println("PARAMS => $params")
    } else {
        println("ORDER NAME => EMPTY")
        println("BII => ${AppActionsWidgetExtension.EXTRA_APP_ACTIONS_BII}")
        println("BII => $bii")
        println("PARAMS => $params")
    }

    println("<==== YO ====>")

    // PARAMS
    var queryData: Map<String, Any?> = mapOf("name" to "", "orderDate" to "")
    var paramKeys: ArrayList<String> = ArrayList<String>()
    var paramName: String = ""
    var paramDate: String = ""

//    // Physical Device
//    if (params != null) {
//        params.keySet().forEach { key ->
//            println("KEYSET => $key")
//            paramKeys.add(key.toString())
//        }
//        println("KeySet => ${params.keySet()}")
//        println("paramKeys => $paramKeys")
//        if (paramKeys.contains("name")) {
//            paramName = params.get("name") as String
//        }
//        if (paramKeys.contains("orderDate")) {
//            paramDate = params.get("orderDate") as String
//        }
//    }

    // Emulator
    optionsBundle.keySet().forEach { key ->
        Log.d("YO", "[$key=${optionsBundle.get(key)}]")
        CustomAppWidgetProvider().KEY = optionsBundle.keySet().first()
        CustomAppWidgetProvider().NAME = "${optionsBundle.get(optionsBundle.keySet().first())}"
        println("MEH KEY => $key")
        println("MEH => ${CustomAppWidgetProvider().KEY}")
        println("MEH => ${CustomAppWidgetProvider().NAME}")


        val myBundle: Bundle = optionsBundle.get("app_actions_params") as Bundle
        println("=======> ParamBundle <==")
        paramKeys.clear()
        myBundle.keySet().forEach { key ->
            println("KEYSET => $key")
            paramKeys.add(key.toString())
        }
        println("KeySet => ${myBundle.keySet()}")
        println("paramKeys => $paramKeys")
        if (paramKeys.contains("name")) {
            paramName = myBundle.get("name") as String
        }
        println("ParamName => $paramName")
        if (paramKeys.contains("orderDate")) {
            paramDate = myBundle.get("orderDate") as String
        }
        println("ParamDate => $paramDate")


//        println("=======> ParamBundle <==")
//        val paramKey: String = myBundle.keySet().first()
//        println("ParamKey => $paramKey")
//        paramName = myBundle.get(paramKey) as String
//        println("ParamName => $paramName")

    }

    queryData = mapOf("name" to "$paramName", "orderDate" to "$paramDate")
    return queryData
    // AppActionsWidgetExtension
}
package com.example.map_builder

import android.graphics.Rect
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import com.microsoft.device.display.DisplayMask

class MainActivity : FlutterActivity() {
    private val CHANNEL = "duosdk.microsoft.dev"

    fun isDualScreenDevice(): Boolean {
        val feature = "com.microsoft.device.display.displaymask"
        val pm = this.packageManager
        return pm.hasSystemFeature(feature)
    }

    fun isAppSpanned(): Boolean {
        val displayMask = DisplayMask.fromResourcesRectApproximation(this)
        val boundings = displayMask.boundingRects
        val first = boundings.get(0)
        val rootView = this.window.decorView.rootView
        val drawingRect = android.graphics.Rect()
        rootView.getDrawingRect(drawingRect)
        Log.d("TAG drawing rect", drawingRect.toString())

        return first.intersect(drawingRect)
    }

    fun getDisplayMask(): HashMap<String, Int> {
        val displayMask = DisplayMask.fromResourcesRect(context)
        val bounding: List<Rect> = displayMask.boundingRects
        val res = HashMap<String, Int>()
        res["width"] = 0
        res["height"] = 0
        if (bounding.isNotEmpty()){
            res["width"] = bounding[0].right - bounding[0].left
            res["height"] = bounding[0].bottom - bounding[0].top
            res["x"] = bounding[0].left
            res["y"] = bounding[0].top
            Log.d("TAG display mask", displayMask.toString())
        }
        return res
    }

    fun getDrawingScreenSize(): HashMap<String, Int> {
        val rootView = this.window.decorView.rootView
        val drawingRect = android.graphics.Rect()
        rootView.getDrawingRect(drawingRect)
        val res = HashMap<String, Int>()
        res["width"] = drawingRect.right - drawingRect.left
        res["height"] = drawingRect.bottom - drawingRect.top
        return res
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->

            if (!isDualScreenDevice()) {
                result.success(false)
            } else {
                try {
                    if (call.method == "isDualScreenDevice") {
                        if (isDualScreenDevice()) {
                            result.success(true)
                        } else {
                            result.success(false)
                        }
                    } else if (call.method == "isAppSpanned") {
                        if (isAppSpanned()) {
                            result.success(true)
                        } else {
                            result.success(false)
                        }
                    } else if (call.method == "getDisplayMask") {
                        result.success(getDisplayMask())

                    }else if (call.method == "getDrawingScreenSize"){
                        result.success(getDrawingScreenSize())

                    }
                    else {
                        result.notImplemented()
                    }
                } catch (e: Exception) {
                    result.success(false)
                }
            }
        }
    }

}

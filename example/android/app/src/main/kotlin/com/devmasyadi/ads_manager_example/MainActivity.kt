package com.devmasyadi.ads_manager_example

import android.graphics.Color
import android.view.LayoutInflater
import android.widget.Button
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine.plugins.add(GoogleMobileAdsPlugin())
        super.configureFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            "nativeAdmob",
            NativeAdmobFactory(this.layoutInflater)
        );
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "nativeAdmob");
    }
}

/**
 * my_native_ad.xml can be found at
 * //github.com/googleads/googleads-mobile-flutter/tree/master/packages/google_mobile_ads/example/android/app/src/main/res/layout
 */
internal class NativeAdmobFactory(private val layoutInflater: LayoutInflater) :
    GoogleMobileAdsPlugin.NativeAdFactory {
    override fun createNativeAd(
        nativeAd: NativeAd?,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val adView = layoutInflater.inflate(R.layout.my_native_ad, null) as NativeAdView
        val headlineView = adView.findViewById<TextView>(R.id.ad_headline)
        val bodyView = adView.findViewById<TextView>(R.id.ad_body)
        nativeAd?.let {
            it.icon?.let { icon ->
                adView.findViewById<ImageView>(R.id.ad_app_icon).setImageDrawable(icon.drawable)
            }
            it.mediaContent?.let { mediaContent ->
                adView.findViewById<MediaView>(R.id.ad_media).setMediaContent(mediaContent)
            }
            it.callToAction?.let { callAction ->
                adView.findViewById<Button>(R.id.ad_call_to_action)?.let { btnAction ->
                    btnAction.setTextColor(Color.WHITE)
                    btnAction.setBackgroundColor(Color.BLUE)
                    btnAction.text = callAction
                }
            }
            adView.findViewById<TextView>(R.id.ad_advertiser).text = it.advertiser
            headlineView.text = nativeAd.headline
            bodyView.text = nativeAd.body
            adView.setNativeAd(nativeAd)
            adView.bodyView = bodyView
            adView.headlineView = headlineView
        }
        return adView
    }
}
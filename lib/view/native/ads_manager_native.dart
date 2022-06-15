import 'package:ads_manager/config_ads_manager.dart';
import 'package:applovin_max/applovin_max_native_view.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum TypeNative { small, medium }

class AdsManagerNativeView extends StatefulWidget {
  final TypeNative? typeNative;
  final ConfigAdsManager configAdsManager;
  const AdsManagerNativeView(
      {Key? key, required this.configAdsManager, this.typeNative})
      : super(key: key);

  @override
  State<AdsManagerNativeView> createState() => _AdsManagerNativeViewState();
}

class _AdsManagerNativeViewState extends State<AdsManagerNativeView> {
  // COMPLETE: Add NativeAd instance
  late NativeAd _ad;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    // COMPLETE: Create a NativeAd instance
    _ad = NativeAd(
      adUnitId: widget.configAdsManager.admobNativeId ?? "",
      factoryId: 'nativeAdmob',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    // COMPLETE: Load an ad
    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.configAdsManager.isShowNative == true) {
      if (widget.configAdsManager.typeAdsNative == TypeAds.admob) {
        final AdWidget adWidget = AdWidget(ad: _ad);
        final Container adContainer = Container(
          alignment: Alignment.center,
          child: adWidget,
          width: double.infinity,
          height: 150,
        );
        if (_isAdLoaded)
          return adContainer;
        else
          return Container();
      } else {
        var size = widget.typeNative == TypeNative.small
            ? NativeAdType.small
            : NativeAdType.medium;
        return ApplovinMaxNativeView(
          size: size,
        );
      }
    } else {
      return Container();
    }
  }
}

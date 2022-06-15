import 'package:ads_manager/config_ads_manager.dart';
import 'package:ads_manager/listener.dart';
import 'package:ads_manager/network/admob/admob_ads.dart';
import 'package:ads_manager/network/applovin/applovin_ads.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ads_manager_platform_interface.dart';

/// An implementation of [AdsManagerPlatform] that uses method channels.
class MethodChannelAdsManager extends AdsManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ads_manager');

  final AdmobAds admobAds = AdmobAds();
  final ApplovinAds applovinAds  = ApplovinAds();
  late ConfigAdsManager _configAdsManager;

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  initSdk({AdsMangerInitListener? adsMangerInitListener}) {
      admobAds.initSdk();
      applovinAds.initSdk((isInitialized) => adsMangerInitListener);
  }
  
  @override
  setConfigAds(ConfigAdsManager configAdsManager) {
    _configAdsManager = configAdsManager;
    admobAds.setConfigAds(configAdsManager);
    applovinAds.setConfigAds(configAdsManager);
  }
  
  @override
  showInterstitialAd() {
    if(_configAdsManager.isShowAds == true && _configAdsManager.isShowInterstitial == true) {
        if(_configAdsManager.typeAdsInterstitial == TypeAds.admob) {
            admobAds.showInterstitialAd();
        }
        else if (_configAdsManager.typeAdsInterstitial == TypeAds.applovin) {
            applovinAds.showInterstitialAd();
        }
    }
  }
  
  @override
  showRewardedAd({AdsManagerRewardsListner? adsManagerRewardsListner}) {
  if(_configAdsManager.isShowAds == true && _configAdsManager.isShowReward == true) {
        if(_configAdsManager.typeAdsReward == TypeAds.admob) {
            admobAds.showRewardedAd(adsManagerRewardsListner);
        }
        else if (_configAdsManager.typeAdsReward == TypeAds.applovin) {
            applovinAds.showRewardedAd(adsManagerRewardsListner);
        }
    }
  }
  
}

import 'package:ads_manager/config_ads_manager.dart';
import 'package:ads_manager/listener.dart';
import 'package:applovin_max/applovin_max_method_channel.dart';
import 'package:applovin_max/applovin_max_platform_interface.dart';

class ApplovinAds {
  late ConfigAdsManager configAdsManager;

  AdsManagerRewardsListner? adsManagerRewardsListner;

  _listener(AppLovinAdListener? appLovinAdListener) {
    if (appLovinAdListener == AppLovinAdListener.onUserRewarded) {
      if (adsManagerRewardsListner != null) adsManagerRewardsListner!(true);
    }
  }

  initSdk(AdsMangerInitListener? adsMangerInitListener) {
    ApplovinMaxPlatform.instance
        .initSdk((isInitialized) => adsMangerInitListener);
  }

  setConfigAds(ConfigAdsManager configAdsManager) {
    this.configAdsManager = configAdsManager;
    ApplovinMaxPlatform.instance.setAdUnit(
        configAdsManager.applovinBannerId,
        configAdsManager.applovinInterstitial,
        configAdsManager.applovinNativeId,
        configAdsManager.applovinRewardsAdsId);
    if (configAdsManager.isShowAds == true) {
      if (_isValidShowInterstitial()) {
        ApplovinMaxPlatform.instance
            .createInterstitial(appLovinListener: _listener);
      }
      if (_isValidShowRewards()) {
        ApplovinMaxPlatform.instance.createRewards(appLovinListener: _listener);
      }
    }
  }

  _isValidShowInterstitial() {
    return configAdsManager.isShowInterstitial == true &&
        configAdsManager.typeAdsInterstitial == TypeAds.applovin &&
        configAdsManager.applovinInterstitial != null;
  }

  _isValidShowRewards() {
    return configAdsManager.isShowReward == true &&
        configAdsManager.typeAdsReward == TypeAds.applovin &&
        configAdsManager.applovinRewardsAdsId != null;
  }

  showInterstitialAd() {
    if (_isValidShowInterstitial())
      ApplovinMaxPlatform.instance.showInterstitial();
  }

  showRewardedAd(AdsManagerRewardsListner? adsManagerRewardsListner) {
    this.adsManagerRewardsListner = adsManagerRewardsListner;
    if (_isValidShowRewards()) ApplovinMaxPlatform.instance.showRewards();
  }
}

import 'package:ads_manager/config_ads_manager.dart';
import 'package:ads_manager/listener.dart';

import 'ads_manager_platform_interface.dart';

class AdsManager {
  Future<String?> getPlatformVersion() {
    return AdsManagerPlatform.instance.getPlatformVersion();
  }

  initSdk({AdsMangerInitListener? adsMangerInitListener}) =>
      AdsManagerPlatform.instance
          .initSdk(adsMangerInitListener: adsMangerInitListener);

  setConfigAds(ConfigAdsManager configAdsManager) =>
      AdsManagerPlatform.instance.setConfigAds(configAdsManager);

  showInterstitialAd() => AdsManagerPlatform.instance.showInterstitialAd();

  showRewardedAd({AdsManagerRewardsListner? adsManagerRewardsListner}) =>
      AdsManagerPlatform.instance
          .showRewardedAd(adsManagerRewardsListner: adsManagerRewardsListner);
}

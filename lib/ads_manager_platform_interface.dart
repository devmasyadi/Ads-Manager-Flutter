import 'package:ads_manager/config_ads_manager.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ads_manager_method_channel.dart';
import 'listener.dart';

abstract class AdsManagerPlatform extends PlatformInterface {
  /// Constructs a AdsManagerPlatform.
  AdsManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static AdsManagerPlatform _instance = MethodChannelAdsManager();

  /// The default instance of [AdsManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelAdsManager].
  static AdsManagerPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AdsManagerPlatform] when
  /// they register themselves.
  static set instance(AdsManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  initSdk({AdsMangerInitListener? adsMangerInitListener}) {
    throw UnimplementedError('initSdk() has not been implemented.');
  }
  setConfigAds(ConfigAdsManager configAdsManager) {
    throw UnimplementedError('setConfigAds() has not been implemented.');
  }
  showInterstitialAd(){
    throw UnimplementedError('showInterstitialAd() has not been implemented.');
  }
  showRewardedAd({AdsManagerRewardsListner? adsManagerRewardsListner}){
    throw UnimplementedError('showRewardedAd() has not been implemented.');
  }
}

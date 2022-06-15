enum TypeAds { admob, applovin }

class ConfigAdsManager {
  final bool? isShowAds;
  final bool? isShowBanner;
  final bool? isShowInterstitial;
  final bool? isShowNative;
  final bool? isShowReward;
  final TypeAds? typeAdsBanner;
  final TypeAds? typeAdsInterstitial;
  final TypeAds? typeAdsNative;
  final TypeAds? typeAdsReward;
  //admob
  final List<String>? testDevices;
  final String? admobBannerId;
  final String? admobInterstitial;
  final String? admobNativeId;
  final String? admobRewardsAdsId;
  //applovin
  final String? applovinBannerId;
  final String? applovinInterstitial;
  final String? applovinNativeId;
  final String? applovinRewardsAdsId;

  ConfigAdsManager(
      {this.testDevices,
      this.applovinBannerId,
      this.applovinInterstitial,
      this.applovinNativeId,
      this.applovinRewardsAdsId,
      this.isShowAds,
      this.isShowBanner,
      this.isShowInterstitial,
      this.isShowNative,
      this.isShowReward,
      this.typeAdsBanner,
      this.typeAdsInterstitial,
      this.typeAdsNative,
      this.typeAdsReward,
      this.admobBannerId,
      this.admobInterstitial,
      this.admobNativeId,
      this.admobRewardsAdsId});
}

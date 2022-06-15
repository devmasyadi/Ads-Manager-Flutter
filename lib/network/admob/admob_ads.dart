import 'package:ads_manager/config_ads_manager.dart';
import 'package:ads_manager/listener.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// You can also test with your own ad unit IDs by registering your device as a
// test device. Check the logs for your device's ID value.
const String testDevice = 'YOUR_DEVICE_ID';
const int maxFailedLoadAttempts = 3;

class AdmobAds {
  late ConfigAdsManager _configAdsManager;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  AdsManagerRewardsListner? _adsManagerRewardsListner;

  static const AdRequest request = AdRequest();

  initSdk() {
    MobileAds.instance.initialize();
  }

  setConfigAds(ConfigAdsManager configAdsManager) {
    MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: configAdsManager.testDevices));
    _configAdsManager = configAdsManager;
    if (configAdsManager.isShowAds == true) {
      if (_isValidShowInterstitial()) {
        _createInterstitialAd();
      }
      if (_isValidShowRewards()) {
        _createRewardedAd();
      }
    }
  }

  _isValidShowInterstitial() {
    return _configAdsManager.isShowInterstitial == true &&
        _configAdsManager.typeAdsInterstitial == TypeAds.admob &&
        _configAdsManager.admobInterstitial != null;
  }

  _isValidShowRewards() {
    return _configAdsManager.isShowReward == true &&
        _configAdsManager.typeAdsReward == TypeAds.admob &&
        _configAdsManager.admobRewardsAdsId != null;
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: _configAdsManager.admobInterstitial ?? "",
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: _configAdsManager.admobRewardsAdsId ?? "",
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
      if (_adsManagerRewardsListner != null) _adsManagerRewardsListner!(true);
    });
    _rewardedAd = null;
  }

  showInterstitialAd() {
    if (_isValidShowInterstitial()) _showInterstitialAd();
  }

  showRewardedAd(AdsManagerRewardsListner? adsManagerRewardsListner) {
    this._adsManagerRewardsListner = adsManagerRewardsListner;
    if (_isValidShowRewards()) _showRewardedAd();
  }
}

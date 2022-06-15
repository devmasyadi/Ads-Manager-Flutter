import 'package:ads_manager/config_ads_manager.dart';
import 'package:applovin_max/applovin_max_banner_view.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsManagerBannerView extends StatelessWidget {
  final ConfigAdsManager configAdsManager;
  const AdsManagerBannerView({Key? key, required this.configAdsManager})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (configAdsManager.isShowBanner == false)
      return Container();
    else if (configAdsManager.typeAdsBanner == TypeAds.admob &&
        configAdsManager.admobBannerId != null) {
      final BannerAd myBanner = BannerAd(
        adUnitId: configAdsManager.admobBannerId!,
        size: AdSize.banner,
        request: AdRequest(),
        listener: BannerAdListener(),
      );
      myBanner.load();
      final AdWidget adWidget = AdWidget(ad: myBanner);
      final Container adContainer = Container(
        alignment: Alignment.center,
        child: adWidget,
        width: myBanner.size.width.toDouble(),
        height: myBanner.size.height.toDouble(),
      );
      return adContainer;
    } else
      return ApplovinMaxBannerView(
        size: BannerAdSize.banner,
      );
  }
}

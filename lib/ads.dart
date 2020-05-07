import 'package:firebase_admob/firebase_admob.dart';
import './constants.dart';

class Ads {

  BannerAd myBanner = BannerAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: Constants().bamnnerAdId,
    size: AdSize.smartBanner,
    listener: (MobileAdEvent event) {
      print("BannerAd event is $event");
    },
  );
  void start(bool load){
    if(load){
      FirebaseAdMob.instance.initialize(appId: Constants().appId);
      myBanner.load();
      myBanner.show();
    }

  }
}
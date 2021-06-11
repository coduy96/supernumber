import 'dart:io';

class AdMobService{
 String getAppId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-2934283537605585~9441966202';//done
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-2934283537605585~7069231533';//done
  }
  return null;
}

String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-2934283537605585/8128884537';//done
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-2934283537605585/1662073750';//done
  }
  return null;
}

String getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-2934283537605585/8938762699';//done
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-2934283537605585/9250394517';//done
  }
  return null;
}
}
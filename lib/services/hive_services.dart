import 'package:hive_flutter/adapters.dart';
import 'package:nymble_pet_app/constants.dart';

class HiveServices {
  getAppData() {
    bool appLaunched = Hive.box(appBoxKey).get(appDataKey) ?? false;
    return appLaunched;
  }

  updateAppData(bool appLaunched) {
    Hive.box(appBoxKey).put(appDataKey, appLaunched);
  }

  getFavList() {
    final favList = Hive.box(petBoxKey).get(favDataKey);
    return favList;
  }

  updateFavList(List<int> favList) {
    Hive.box(petBoxKey).put(favDataKey, favList);
  }

  getAdoptedList() {
    final adoptedList = Hive.box(petBoxKey).get(adoptedDataKey);
    return adoptedList;
  }

  updateAdoptedList(List<int> adoptedList) {
    Hive.box(petBoxKey).put(adoptedDataKey, adoptedList);
  }
}

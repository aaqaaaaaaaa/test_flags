import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_flags/common/constants.dart';
import 'package:test_flags/fuatures/home/data/models/country_model.dart';

abstract class CountryLocalDataSource {
  Future<List<CountriesModel>> getCountryList();

  Future<bool> setCountryList(List<CountriesModel> list);
}

class CountryLocalDataSourceImpl extends CountryLocalDataSource {
  @override
  Future<List<CountriesModel>> getCountryList() async {
    try {
      await Hive.openBox(AppConstants.countryBox);
      final box = Hive.box(AppConstants.countryBox);
      final countryFromHive =
          box.get(AppConstants.countryBox).cast<CountriesModel>() ?? [];
      return countryFromHive;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> setCountryList(List<CountriesModel> list) async {
    try {
      await Hive.openBox(AppConstants.countryBox);
      final box = Hive.box(AppConstants.countryBox);
      box.put(AppConstants.countryBox, list);
      return true;
    } catch (e) {
      return false;
    }
  }
}

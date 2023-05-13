import 'package:hive/hive.dart';

part 'country_model.g.dart';

@HiveType(typeId: 1)
class CountriesModel {
  @HiveField(0)
  String? common;

  @HiveField(1)
  List? capital;

  @HiveField(2)
  String? region;
  @HiveField(3)
  String? subregion;
  @HiveField(4)
  String? official;
  @HiveField(5)
  List? latlng;

  @HiveField(6)
  String? flag;

  @HiveField(7)
  int? population;

  @HiveField(8)
  List? timezones;

  @HiveField(9)
  List? continents;

  @HiveField(10)
  String? flagsPng;

  CountriesModel({
    this.official,
    this.common,
    this.capital,
    this.region,
    this.subregion,
    this.latlng,
    this.flag,
    this.population,
    this.timezones,
    this.continents,
    this.flagsPng,
  });

  CountriesModel.fromJson(Map<String, dynamic> json) {
    common = json['name']['common'];
    official = json['name']['official'];
    capital = json['capital'];
    region = json['region'];
    subregion = json['subregion'];
    latlng = json['latlng'];
    flag = json['flag'];
    population = json['population'];
    timezones = json['timezones'];
    continents = json['continents'];
    flagsPng = json['flags']['png'];
  }
}

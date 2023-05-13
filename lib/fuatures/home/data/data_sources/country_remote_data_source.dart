import 'dart:convert';

import 'package:test_flags/core/error/exception.dart';
import 'package:test_flags/fuatures/home/data/models/country_model.dart';
import 'package:http/http.dart' as http;

abstract class CountryRemoteDataSource {
  Future<List<CountriesModel>> getCountries();
}

class CountryRemoteDataSourceImpl extends CountryRemoteDataSource {
  final http.Client client;

  CountryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CountriesModel>> getCountries() async {
    final responce = await client.get(
      Uri.parse('https://restcountries.com/v3.1/all'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
    );
    if (responce.statusCode == 200) {
      final countryList = jsonDecode(responce.body);
      return (countryList as List)
          .map((e) => CountriesModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}

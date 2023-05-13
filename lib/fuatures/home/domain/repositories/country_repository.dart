import 'package:dartz/dartz.dart';
import 'package:test_flags/core/error/failure.dart';
import 'package:test_flags/fuatures/home/data/models/country_model.dart';

abstract class CountriesRepository {
  Future<Either<Failure, List<CountriesModel>>> getCountries();
  Future<Either<Failure, List<CountriesModel>>> getLocalCountries();
}

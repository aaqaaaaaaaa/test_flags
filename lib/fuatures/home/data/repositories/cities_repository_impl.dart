import 'package:dartz/dartz.dart';
import 'package:test_flags/core/error/failure.dart';
import 'package:test_flags/core/platform/network_info.dart';
import 'package:test_flags/fuatures/home/data/data_sources/country_local_data_source.dart';
import 'package:test_flags/fuatures/home/data/data_sources/country_remote_data_source.dart';
import 'package:test_flags/fuatures/home/data/models/country_model.dart';
import 'package:test_flags/fuatures/home/domain/repositories/country_repository.dart';

class CountriesRepositoryImpl extends CountriesRepository {
  final CountryRemoteDataSourceImpl remoteDataSourceImpl;
  final CountryLocalDataSourceImpl localDataSourceImpl;
  final NetworkInfo networkInfo;

  CountriesRepositoryImpl(
      {required this.localDataSourceImpl,
      required this.remoteDataSourceImpl,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<CountriesModel>>> getCountries() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSourceImpl.getCountries();
        localDataSourceImpl.setCountryList(result);
        return Right(result);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      try {
        final result = await localDataSourceImpl.getCountryList();
        return Right(result);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<CountriesModel>>> getLocalCountries() async {
    try {
      final result = await localDataSourceImpl.getCountryList();
      return Right(result);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }
}

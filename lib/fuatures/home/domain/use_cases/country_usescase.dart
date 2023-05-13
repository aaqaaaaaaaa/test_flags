import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flags/core/error/failure.dart';
import 'package:test_flags/core/usecases/use_case.dart';
import 'package:test_flags/fuatures/home/domain/repositories/country_repository.dart';

class CountryUsesCase extends UseCase<dynamic, CountryParams> {
  final CountriesRepository repository;

  CountryUsesCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(CountryParams params) {
    return repository.getCountries();
  }
}

class CountryParams extends Equatable {
  @override
  List<Object?> get props => [];
}

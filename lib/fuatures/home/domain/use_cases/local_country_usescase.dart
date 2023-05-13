import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test_flags/core/error/failure.dart';
import 'package:test_flags/core/usecases/use_case.dart';
import 'package:test_flags/fuatures/home/domain/repositories/country_repository.dart';

class LocalCountryUsesCase extends UseCase<dynamic, LocalCountryParams> {
  final CountriesRepository repository;

  LocalCountryUsesCase({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(LocalCountryParams params) {
    return repository.getLocalCountries();
  }
}

class LocalCountryParams extends Equatable {
  @override
  List<Object?> get props => [];
}

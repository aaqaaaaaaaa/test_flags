import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test_flags/fuatures/home/data/models/country_model.dart';
import 'package:test_flags/fuatures/home/domain/use_cases/country_usescase.dart';
import 'package:test_flags/fuatures/home/domain/use_cases/local_country_usescase.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit({required this.localCountryUsesCase, required this.usesCase})
      : super(CountryInitial());
  final CountryUsesCase usesCase;
  final LocalCountryUsesCase localCountryUsesCase;
  List<CountriesModel> countryList = [];

  FutureOr<void> getCountryList() async {
    emit(CountryLoadingState());
    final failureOrCountry = await usesCase(CountryParams());
    failureOrCountry.fold(
      (l) => emit(CountryErrorState(
          message: 'Ma\'lumot yuklashlikda hatolik yuz berdi!')),
      (r) {
        if (r.isEmpty) {
          emit(CountryErrorState(
              message: 'Ma\'lumot yuklashlikda hatolik yuz berdi!'));
        } else {
          emit(CountryLoadedState(data: r));
        }
      },
    );
  }

  FutureOr<void> searchCountryList(String query) async {
    if (countryList.isEmpty) {
      final failureOrCountry = await localCountryUsesCase(LocalCountryParams());
      failureOrCountry.fold(
        (l) => emit(CountryErrorState(
            message: 'Ma\'lumot yuklashlikda hatolik yuz berdi!')),
        (r) {
          if (r.isEmpty) {
            emit(CountryErrorState(message: "Bunday ma'lumot topilmadi!"));
          } else {
            countryList = r;
            emit(CountryLoadedState(
                data: countryList.where((item) {
              if (query.isNotEmpty) {
                final titleLower = item.common?.toLowerCase();
                final searchLower = query.toLowerCase();
                return titleLower!.contains(searchLower);
              } else {
                return true;
              }
            }).toList()));
          }
        },
      );
    } else {
      var list = countryList.where((item) {
        if (query.isNotEmpty) {
          final titleLower = item.common?.toLowerCase();
          final searchLower = query.toLowerCase().trim();
          return titleLower!.contains(searchLower);
        } else {
          return true;
        }
      }).toList();
      if (list.isEmpty) {
        emit(CountrySearchEmptyState());
      } else {
        emit(CountryLoadedState(data: list));
      }
    }
  }
}

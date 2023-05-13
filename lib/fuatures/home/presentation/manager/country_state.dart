part of 'country_cubit.dart';

@immutable
abstract class CountryState {}

class CountryInitial extends CountryState {}

class CountryLoadingState extends CountryState {}

class CountrySearchEmptyState extends CountryState {}

class CountryLoadedState extends CountryState {
  final List<CountriesModel> data;

  CountryLoadedState({required this.data});
}

class CountryErrorState extends CountryState {
  final String message;

  CountryErrorState({required this.message});
}

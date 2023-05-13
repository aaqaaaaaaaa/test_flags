import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flags/common/constants.dart';
import 'package:test_flags/core/platform/network_info.dart';
import 'package:test_flags/fuatures/home/data/data_sources/country_local_data_source.dart';
import 'package:test_flags/fuatures/home/data/data_sources/country_remote_data_source.dart';
import 'package:test_flags/fuatures/home/data/models/country_model.dart';
import 'package:test_flags/fuatures/home/data/repositories/cities_repository_impl.dart';
import 'package:test_flags/fuatures/home/domain/repositories/country_repository.dart';
import 'package:test_flags/fuatures/home/domain/use_cases/country_usescase.dart';
import 'package:test_flags/fuatures/home/domain/use_cases/local_country_usescase.dart';
import 'package:test_flags/fuatures/home/presentation/manager/country_cubit.dart';

// import 'package:test_flags/features/home/data/data_sources/person_local_data_source.dart';
// import 'package:test_flags/features/home/data/data_sources/person_remote_data_source.dart';
// import 'package:test_flags/features/home/data/repositories/person_repository_impl.dart';
// import 'package:test_flags/features/home/domain/repositories/person_repository.dart';
// import 'package:test_flags/features/home/domain/use_cases/get_all_persons.dart';
// import 'package:test_flags/features/home/presentation/bloc/person_list/person_list_cubit.dart';
// import 'package:test_flags/features/home/presentation/bloc/search/search_bloc.dart';

final di = GetIt.instance;

Future<void> init() async {
  di.registerFactory(() => CountryCubit(
      localCountryUsesCase: di<LocalCountryUsesCase>(),
      usesCase: di<CountryUsesCase>()));

  di.registerLazySingleton(() => CountryUsesCase(repository: di()));
  di.registerLazySingleton(() => LocalCountryUsesCase(repository: di()));

  di.registerFactory<CountriesRepository>(
    () => CountriesRepositoryImpl(
      localDataSourceImpl: di(),
      remoteDataSourceImpl: di(),
      networkInfo: di(),
    ),
  );

  di.registerLazySingleton<CountryRemoteDataSourceImpl>(
      () => CountryRemoteDataSourceImpl(client: di()));

  di.registerLazySingleton<CountryLocalDataSourceImpl>(
      () => CountryLocalDataSourceImpl());

  /// Network
  di.registerLazySingleton<http.Client>(() => http.Client());

  /// Network Info
  di.registerLazySingleton(() => InternetConnectionChecker());

  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));

  /// Local cache
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  di.registerLazySingleton(() => sharedPreferences);

  /// Local datasource
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter<CountriesModel>(CountriesModelAdapter());
  }
}

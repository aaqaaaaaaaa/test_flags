import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:screensize_utils/screensize_util.dart';
import 'package:test_flags/fuatures/home/data/data_sources/country_local_data_source.dart';
import 'package:test_flags/fuatures/home/data/data_sources/country_remote_data_source.dart';
import 'package:test_flags/fuatures/home/presentation/pages/home_page.dart';

import 'di/di.dart' as sl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sl.init();
  // GetIt.instance.registerLazySingleton<CountryRemoteDataSourceImpl>(
  //     () => CountryRemoteDataSourceImpl(client: sl.di()));
  // GetIt.instance.registerLazySingleton<CountryLocalDataSource>(
  //     () => CountryLocalDataSourceImpl());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenSizeUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, state) {
        return MaterialApp(
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: child!,
            );
          },
          home: HomePage.screen(),
        );
      },
    );
  }
}

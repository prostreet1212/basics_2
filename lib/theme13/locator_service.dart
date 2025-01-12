import 'package:basics_2/theme13/core/platform/network_info.dart';
import 'package:basics_2/theme13/features/data/data_sources/person_local_data_source.dart';
import 'package:basics_2/theme13/features/data/data_sources/person_remote_data_source.dart';
import 'package:basics_2/theme13/features/data/repositories/person_repository_impl.dart';
import 'package:basics_2/theme13/features/domain/repositories/person_repository.dart';
import 'package:basics_2/theme13/features/domain/use_cases/get_all_persons.dart';
import 'package:basics_2/theme13/features/domain/use_cases/search_person.dart';
import 'package:basics_2/theme13/features/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:basics_2/theme13/features/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async{
  //bloc,cubit
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()));

  //usecases
  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPerson(sl()));

  //repository
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<PersonRemoteDataSource>(
      () => PersonRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PersonLocalDataSource>(
      () => PersonLocalDataSourceImpl(sharedPreferences: sl()));
  //core
  sl.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(sl()));

  //external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker);

}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/constants/api_constants.dart';
import 'core/network/network_info.dart';
import 'features/pokemon/data/datasources/pokemon_remote_datasource.dart';
import 'features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'features/pokemon/domain/repositories/pokemon_repository.dart';
import 'features/pokemon/domain/usecases/get_pokemon_detail.dart';
import 'features/pokemon/domain/usecases/get_pokemon_list.dart';
import 'features/pokemon/presentation/bloc/pokemon_detail/pokemon_detail_bloc.dart';
import 'features/pokemon/presentation/bloc/pokemon_list/pokemon_list_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async 
{
  // for blocs
  sl.registerFactory(() =>PokemonListBloc(getPokemonList: sl()));
  sl.registerFactory(() => PokemonDetailBloc(getPokemonDetail: sl()));

  // for use cases
  sl.registerLazySingleton(() => GetPokemonList(sl()));
  sl.registerLazySingleton(() =>GetPokemonDetail(sl()));

  // for repository
  sl.registerLazySingleton<PokemonRepository>(
    () =>PokemonRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // for data sources
  sl.registerLazySingleton<PokemonRemoteDataSource>(
    () =>PokemonRemoteDataSourceImpl(dio: sl()),
  );

  // core
  sl.registerLazySingleton<NetworkInfo>(()=> NetworkInfoImpl(sl()));
  sl.registerLazySingleton(()=> Connectivity());
  sl.registerLazySingleton
  (
    () => Dio
    (
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
         connectTimeout: ApiConstants.defaultTimeout,
        receiveTimeout: ApiConstants.defaultTimeout,
        responseType: ResponseType.json,
      ) ,
    ),
  );
}

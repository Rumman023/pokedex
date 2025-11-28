import 'package:dartz/dartz.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_remote_datasource.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  final PokemonRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Pokemon>>> getPokemonList({int limit = AppConstants.defaultPokemonDisplayLimit}) async {
    final connected = await networkInfo.isConnected;
    if(!connected)
    {
      return const Left(NetworkFailure());
    }

    try 
    {
      final pokemon = await remoteDataSource.getPokemonList(limit: limit);
      return Right(pokemon);
    } on ServerException {
      return const Left(ServerFailure());
    } catch (error, stackTrace) 
    {
      AppLogger.error('Unexpected error fetching pokemon list', error: error, stackTrace: stackTrace);
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PokemonDetail>> getPokemonDetail(String url) async {
    final connected = await networkInfo.isConnected;
    if(!connected)
    {
      return const Left(NetworkFailure());
    }

    try
    {
      final detail = await remoteDataSource.getPokemonDetail(url);
      return Right(detail);
    } on ServerException {
      return const Left(ServerFailure());
  } catch (error, stackTrace) 
    {
      AppLogger.error('Unexpected error fetching pokemon detail', error: error, stackTrace: stackTrace);
      return const Left(ServerFailure());
    }
  }
}

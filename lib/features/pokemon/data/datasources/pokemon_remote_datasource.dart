import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../models/pokemon_detail_model.dart';
import '../models/pokemon_list_model.dart';

abstract class PokemonRemoteDataSource 
{
  Future< List<PokemonModel>>getPokemonList({int limit});
  Future< PokemonDetailModel> getPokemonDetail(String url);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource 
{
  PokemonRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<List <PokemonModel>> getPokemonList({int limit =AppConstants.defaultPokemonDisplayLimit}) 
  async 
  {
    try 
    {
      final response = await dio.get(ApiConstants.pokemonListEndpoint);
      final results = response.data['results'] as List<dynamic>?;
      if (results == null) 
      {
        throw ServerException();
      }
      final casted = results.cast<Map<String, dynamic>>();
      final limited = casted.length > limit ? casted.sublist(0,limit) :casted;
      return limited
          .map(PokemonModel.fromJson)
          .toList(growable: false);
    } on DioException catch (error, stackTrace) {
      AppLogger.error('Failed to fetch pokemon list', error: error, stackTrace: stackTrace);
      throw ServerException();
    }
  }

  @override
  Future< PokemonDetailModel> getPokemonDetail(String url) async 
  {
    try {
      final response = await dio.get(url);
      return PokemonDetailModel.fromJson(response.data as Map<String,dynamic>);
    } on DioException catch (error,stackTrace) 
    {
      AppLogger.error('Failed to fetch pokemon detail', error: error, stackTrace: stackTrace);
      throw ServerException();
    }
}
}

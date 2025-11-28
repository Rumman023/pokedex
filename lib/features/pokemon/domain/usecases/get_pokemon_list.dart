import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/failures.dart';
import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonList 
{
  GetPokemonList(this.repository);

  final PokemonRepository repository;

  Future<Either<Failure, List<Pokemon>>> call(PokemonListParams params) 
  {
    return repository.getPokemonList(limit: params.limit);
  }
}

class PokemonListParams extends Equatable 
{
  const PokemonListParams({this.limit = AppConstants.defaultPokemonDisplayLimit});

  final int limit;

  @override
  List<Object?> get props => [limit];
}

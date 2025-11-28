import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/pokemon.dart';
import '../entities/pokemon_detail.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<Pokemon>>> getPokemonList({int limit = 151});
  Future<Either<Failure, PokemonDetail>> getPokemonDetail(String url);
}

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/helpers.dart';
import '../entities/pokemon_detail.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonDetail {
  GetPokemonDetail(this.repository);

  final PokemonRepository repository;

  Future<Either<Failure, PokemonDetail>> call(PokemonDetailParams params) 
  {
    return repository.getPokemonDetail(params.url);
  }
}

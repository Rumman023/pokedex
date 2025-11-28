import '../../../../core/utils/helpers.dart';
import '../../domain/entities/pokemon_detail.dart';

class PokemonDetailModel extends PokemonDetail 
{ 
  const PokemonDetailModel(
  {
    required super.id, 
    required super.name, 
    required super.height, 
    required super.weight,
    required super.spriteUrl,
    required super.types, 
    required super.stats,
  }
  );

  factory PokemonDetailModel.fromJson(Map<String, dynamic> json) 
  {
    final sprites = json['sprites'] as Map<String, dynamic>?;
    final other = sprites?['other'] as Map<String, dynamic>?;
    final artwork = other?['official-artwork'] as Map<String, dynamic>?;
    final spriteUrl = (artwork?['front_default'] ?? sprites?['front_default'] ?? '') as String;

    final statsList = (json['stats'] as List<dynamic>)
        .map((entry) => PokemonStatModel.fromJson(entry as Map<String, dynamic>))
        .toList(growable: false);

    final typesList = (json['types'] as List<dynamic>)
        .map((entry) => entry as Map<String, dynamic>)
        .map((entry) => entry['type'] as Map<String, dynamic>)
        .map((entry) => capitalize(entry['name'] as String))
        .toList(growable: false);

    return PokemonDetailModel(
      id: json['id'] as int,
      name: capitalize(json['name'] as String),
      height: (json['height'] as num).toDouble()/10,
      weight: (json['weight'] as num).toDouble()/10,
      spriteUrl: spriteUrl,
      types: typesList,
      stats: statsList,
    ) ;
  }
}

class PokemonStatModel extends PokemonStat 
{
  const PokemonStatModel({required super.name, required super.baseStat});

  factory PokemonStatModel.fromJson(Map<String, dynamic> json) {
    final stat = json['stat'] as Map<String, dynamic>;
    return PokemonStatModel(
      name: capitalize(stat['name'] as String),
      baseStat: (json['base_stat'] as num).toInt(),
    );
  }
}

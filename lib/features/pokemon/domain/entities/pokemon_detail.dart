import 'package:equatable/equatable.dart';

class PokemonStat extends Equatable 
{
  const PokemonStat({required this.name, required this.baseStat});
  final String name;
  final int baseStat;

  @override
  List<Object?> get props => [name, baseStat];
}

class PokemonDetail extends Equatable 
{
  const PokemonDetail({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.spriteUrl,
    required this.types,
    required this.stats,
  }
  );

  final int id;
  final String name;
  final double height;
  final double weight;
  final String spriteUrl;
  final List<String> types;
  final List<PokemonStat> stats;

  @override
  List<Object?> get props => [id, name, height, weight, spriteUrl, types, stats];
}

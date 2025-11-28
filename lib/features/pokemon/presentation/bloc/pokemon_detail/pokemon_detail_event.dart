import 'package:equatable/equatable.dart';

abstract class PokemonDetailEvent extends Equatable 
{
  const PokemonDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadPokemonDetail extends PokemonDetailEvent 
{
  const LoadPokemonDetail({required this.url});

  final String url;

  @override
  List<Object?> get props => [url];
}

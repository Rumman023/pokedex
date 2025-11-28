import 'package:equatable/equatable.dart';

abstract class PokemonListEvent extends Equatable 
{
  const PokemonListEvent();

  @override
  List<Object?> get props => [];
}

class LoadPokemonList extends PokemonListEvent 
{
  const LoadPokemonList({this.limit});

  final int? limit;

  @override
  List<Object?> get props => [limit];
}

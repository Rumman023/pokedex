import 'package:equatable/equatable.dart';

import '../../../domain/entities/pokemon.dart';

abstract class PokemonListState extends Equatable 
{
  const PokemonListState();

  @override
  List<Object?> get props => [];
}

class PokemonListInitial extends PokemonListState 
{
  const PokemonListInitial();
}

class PokemonListLoading extends PokemonListState 
{
  const PokemonListLoading();
}

class PokemonListLoaded extends PokemonListState 
{
  const PokemonListLoaded(this.pokemon);

  final List<Pokemon> pokemon;

  @override
  List<Object?> get props => [pokemon];
}

class PokemonListError extends PokemonListState 
{
  const PokemonListError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

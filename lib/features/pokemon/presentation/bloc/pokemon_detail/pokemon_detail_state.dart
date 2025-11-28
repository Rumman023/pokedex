import 'package:equatable/equatable.dart';

import '../../../domain/entities/pokemon_detail.dart';

abstract class PokemonDetailState extends Equatable {
  const PokemonDetailState();

  @override
  List<Object?> get props => [];
}

class PokemonDetailInitial extends PokemonDetailState {
  const PokemonDetailInitial();
}

class PokemonDetailLoading extends PokemonDetailState {
  const PokemonDetailLoading();
}

class PokemonDetailLoaded extends PokemonDetailState {
  const PokemonDetailLoaded(this.detail);

  final PokemonDetail detail;

  @override
  List<Object?> get props => [detail];
}

class PokemonDetailError extends PokemonDetailState {
  const PokemonDetailError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

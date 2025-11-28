import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/string_constants.dart';
import '../../../domain/usecases/get_pokemon_list.dart';
import 'pokemon_list_event.dart';
import 'pokemon_list_state.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> 
{
  PokemonListBloc({required this.getPokemonList}) : super(const PokemonListInitial()) {
    on<LoadPokemonList>(_onLoadPokemonList);
  }

  final GetPokemonList getPokemonList;

  Future<void> _onLoadPokemonList(LoadPokemonList event, Emitter<PokemonListState> emit) 
  async {
    emit(const PokemonListLoading());

    final params = PokemonListParams(limit: event.limit ?? AppConstants.defaultPokemonDisplayLimit);
    final result = await getPokemonList(params);
    result.fold(
      (failure) =>emit(PokemonListError(failure.message.isNotEmpty ? 
      failure.message : StringConstants.genericErrorMessage)),
      (pokemon) =>emit(PokemonListLoaded(pokemon)),
    );
  }
}

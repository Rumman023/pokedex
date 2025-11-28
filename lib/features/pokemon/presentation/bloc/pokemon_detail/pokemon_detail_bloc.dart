import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/string_constants.dart';
import '../../../../../core/utils/helpers.dart';
import '../../../domain/usecases/get_pokemon_detail.dart';
import 'pokemon_detail_event.dart';
import 'pokemon_detail_state.dart';

class PokemonDetailBloc extends Bloc<PokemonDetailEvent, PokemonDetailState> 
{
  PokemonDetailBloc({required this.getPokemonDetail}) :super(const PokemonDetailInitial()) 
  {
    on<LoadPokemonDetail>(_onLoadPokemonDetail);
  }

  final GetPokemonDetail getPokemonDetail;

  Future<void> _onLoadPokemonDetail(LoadPokemonDetail event, Emitter<PokemonDetailState> emit) 
  async {
    emit(const PokemonDetailLoading());

    final result =await getPokemonDetail(PokemonDetailParams(url: event.url));
    result.fold(
      (failure) => emit(PokemonDetailError(failure.message.isNotEmpty ? 
      failure.message : StringConstants.genericErrorMessage)),
      (detail) => emit(PokemonDetailLoaded(detail)),
    );
  }
}

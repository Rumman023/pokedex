import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/string_constants.dart';
import '../../domain/entities/pokemon.dart';
import '../bloc/pokemon_detail/pokemon_detail_bloc.dart';
import '../bloc/pokemon_detail/pokemon_detail_event.dart';
import '../bloc/pokemon_list/pokemon_list_bloc.dart';
import '../bloc/pokemon_list/pokemon_list_event.dart';
import '../bloc/pokemon_list/pokemon_list_state.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/pokemon_card.dart';
import 'pokemon_detail_page.dart';
import '../../../../injection_container.dart';

class PokemonListPage extends StatelessWidget 
{
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConstants.pokemonListTitle),
      ),
      body: BlocBuilder<PokemonListBloc,PokemonListState>(
        builder: (context, state) {
          if (state is PokemonListLoading || state is PokemonListInitial) {
            return const Center(child: LoadingWidget());
          }

          if (state is PokemonListError) {
            return Center(
              child: AppErrorWidget(
                message: state.message,
                onRetry: () => context.read<PokemonListBloc>().add(const LoadPokemonList()),
              ),
            );
          }

          if (state is PokemonListLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: state.pokemon.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final pokemon = state.pokemon[index];
                  return SizedBox(
                    width: 180,
                    child: PokemonCard(
                      pokemon: pokemon,
                      onTap: () => _openDetail(context, pokemon),
                    ),
                  ) ;
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
    ),
    );
  }

  void _openDetail(BuildContext context,Pokemon pokemon) 
  {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => sl<PokemonDetailBloc>()..add(LoadPokemonDetail(url: pokemon.url)),
          child: PokemonDetailPage(pokemon: pokemon),
        ),
      ),
  );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/utils/helpers.dart';
import '../../domain/entities/pokemon.dart';
import '../bloc/pokemon_detail/pokemon_detail_bloc.dart';
import '../bloc/pokemon_detail/pokemon_detail_event.dart';
import '../bloc/pokemon_detail/pokemon_detail_state.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/pokemon_stat_item.dart';

class PokemonDetailPage extends StatelessWidget 
{
  const PokemonDetailPage({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) 
  {
    final displayName = capitalize(pokemon.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(displayName),
      ),
      body: BlocBuilder<PokemonDetailBloc,PokemonDetailState>(
        builder: (context, state) 
        {
          if(state is PokemonDetailLoading || state is PokemonDetailInitial) 
          {
            return const Center(child: LoadingWidget());
          }

          if(state is PokemonDetailError) 
          {
            return Center(
              child: AppErrorWidget(
                message: state.message.isEmpty ? StringConstants.genericErrorMessage : state.message,
                onRetry: () => context
                    .read<PokemonDetailBloc>()
                    .add(LoadPokemonDetail(url: pokemon.url)),
              ),
            );
          }

          if (state is PokemonDetailLoaded) {
            final detail = state.detail;
            final imageUrl = detail.spriteUrl.isNotEmpty ? detail.spriteUrl : buildPokemonSpriteUrl(detail.id);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'pokemon-${detail.id}',
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 200,
                      placeholder: (context, url) => const LoadingWidget(),
                      errorWidget: (context, url, error) => const Icon(Icons.catching_pokemon, size: 100),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    detail.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: detail.types
                        .map(
                          (type) => Chip(
                            label: Text(type),
                            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          ),
                        )
                        .toList(growable: false),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoTile(label: 'Height', value: '${detail.height.toStringAsFixed(1)} m'),
                      _InfoTile(label: 'Weight', value: '${detail.weight.toStringAsFixed(1)} kg'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Stats',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...detail.stats.map(
                    (stat) => PokemonStatItem(stat: stat),
                   ),
                  ],
              ),
            );
          }

          return const SizedBox.shrink();
         },
      ),
    );
}
}

class _InfoTile extends StatelessWidget 
{
  const _InfoTile({required this.label,required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) 
   {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
         ),
      ],
  );
  }
}

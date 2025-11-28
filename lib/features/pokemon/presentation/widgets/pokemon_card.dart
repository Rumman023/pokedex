import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/helpers.dart';
import '../../domain/entities/pokemon.dart';
import 'loading_widget.dart';

class PokemonCard extends StatelessWidget 
{
  const PokemonCard({super.key, required this.pokemon, required this.onTap});

  final Pokemon pokemon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) 
  {
    final imageUrl = buildPokemonSpriteUrl(pokemon.id);
    final displayName = capitalize(pokemon.name);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'pokemon-${pokemon.id}',
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 96,
                placeholder: (context, url) => const LoadingWidget(),
                errorWidget: (context, url, error) => const Icon(Icons.catching_pokemon, size: 48),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '#${pokemon.id.toString().padLeft(3, '0')}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Text(
              displayName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}

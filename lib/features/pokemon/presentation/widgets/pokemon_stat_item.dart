import 'package:flutter/material.dart';

import '../../domain/entities/pokemon_detail.dart';

class PokemonStatItem extends StatelessWidget 
{
  const PokemonStatItem({super.key, required this.stat});

  final PokemonStat stat;

  @override
  Widget build(BuildContext context) 
  {
    final normalizedValue = stat.baseStat.clamp(0, 200).toDouble()/200;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: 
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stat.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                stat.baseStat.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: normalizedValue,
              minHeight: 8,
            ),
          ) ,
        ],
      ),
  );
  }
}

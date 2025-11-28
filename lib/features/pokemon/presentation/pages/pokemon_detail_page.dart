import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/string_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/helpers.dart';
import '../../domain/entities/pokemon.dart';
import '../bloc/pokemon_detail/pokemon_detail_bloc.dart';
import '../bloc/pokemon_detail/pokemon_detail_event.dart';
import '../bloc/pokemon_detail/pokemon_detail_state.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/pokemon_stat_item.dart';

class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({super.key, required this.pokemon});

  final Pokemon pokemon;

  Color _typeColor(String type) {
    return AppColors.typeColors[type.toLowerCase()] ?? AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.of(context).pop(),
           ),
      ),
      ),
      body: BlocBuilder<PokemonDetailBloc, PokemonDetailState>
      (
        builder: (context, state) {
          if (state is PokemonDetailLoading || state is PokemonDetailInitial) 
          {
            return const Center(child: LoadingWidget());
          }

          if (state is PokemonDetailError) 
          {
            return Center(
              child: AppErrorWidget(
                message:
                    state.message.isEmpty ? StringConstants.genericErrorMessage 
                    : state.message,
                onRetry: () => context .read<PokemonDetailBloc>()
                    .add(LoadPokemonDetail(url: pokemon.url)),
              ),
            );
          }

          if(state is PokemonDetailLoaded)
          {
            final detail = state.detail;
            final imageUrl =
                detail.spriteUrl.isNotEmpty ? detail.spriteUrl : buildPokemonSpriteUrl(detail.id);
            final primaryType = detail.types.isNotEmpty ? detail.types.first : 'normal';
            final background = _typeColor(primaryType);

            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [background.withValues(alpha: 0.3), Colors.white],
                      stops: const [0.0, 0.4],
                    ),
                  ),
                ),
                Positioned(
                  right: -50,
                  top: 100,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: background.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                Positioned(
                  left: -30,
                  top: 300,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: background.withValues(alpha: 0.08),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 100, 24, 24),
                        child: Column(
                          children: [
                            Text(
                              '#${detail.id.toString().padLeft(3, '0')}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: background.withValues(alpha: 0.7),
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              detail.name,
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              children: detail.types
                                  .map(
                                    (type) => Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            _typeColor(type),
                                            _typeColor(type).withValues(alpha: 0.8),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: _typeColor(type).withValues(alpha: 0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        type.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(growable: false),
                            ),
                            const SizedBox(height: 32),
                            Hero(
                              tag: 'pokemon-${detail.id}',
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: background.withValues(alpha: 0.2),
                                      blurRadius: 30,
                                      spreadRadius: 5,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  height: 200,
                                  width: 200,
                                  placeholder: (context, url) => const LoadingWidget(),
                                  errorWidget: (context, url, error) => const Icon(
                                    Icons.catching_pokemon,
                                    size: 120,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _InfoTile(
                                    icon: Icons.straighten,
                                    label: 'Height',
                                    value: '${detail.height.toStringAsFixed(1)} m',
                                    color: background,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _InfoTile(
                                    icon: Icons.fitness_center,
                                    label: 'Weight',
                                    value: '${detail.weight.toStringAsFixed(1)} kg',
                                    color: background,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: background.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(Icons.analytics_outlined, size: 20, color: background),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Base Stats',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ...detail.stats.map(
                              (stat) => PokemonStatItem(
                                stat: stat,
                                color: background,
                              ),
                            ),
                           ],
                         ),
                      ),
                      const SizedBox(height: 32),
                  ],
                  ),
                ),
            ],
            );
          }

              return const SizedBox.shrink();
        },
      ) ,
    );
}
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: color),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
          ),
        ],
      ),
    );
  }
}

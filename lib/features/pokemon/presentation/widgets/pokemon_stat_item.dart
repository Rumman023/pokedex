import 'package:flutter/material.dart';

import '../../domain/entities/pokemon_detail.dart';

class PokemonStatItem extends StatefulWidget 
{
  const PokemonStatItem({super.key, required this.stat, required this.color});

  final PokemonStat stat;
  final Color color;

  @override
  State<PokemonStatItem> createState() => _PokemonStatItemState();
}

class _PokemonStatItemState extends State<PokemonStatItem> with SingleTickerProviderStateMixin 
{
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _controller.forward();
      }
    }
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatStatName(String name) {
    if (name.isEmpty) {
      return name;
    }

    final segments = name
        .split('-')
        .where((segment) => segment.isNotEmpty)
        .map(
          (segment) => segment[0].toUpperCase() + segment.substring(1),
        );

    return segments.join(' ');
  }

  Color _statColor(int baseStat) {
    if (baseStat >= 150) 
    {
      return const Color(0xFF00C853);
    } if (baseStat >= 100) 
    {
      return const Color(0xFF66BB6A);
    }if (baseStat >= 70)
    {
      return const Color(0xFFFFA726);
    }
    if(baseStat >= 50)
    {
      return const Color(0xFFFF7043);
    }
    return const Color(0xFFEF5350);
  }

  @override
  Widget build(BuildContext context) {
    final normalizedValue = widget.stat.baseStat.clamp(0, 200).toDouble() / 200;
    final statColor = _statColor(widget.stat.baseStat);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: 
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: 
                [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: statColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _formatStatName(widget.stat.name),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          letterSpacing: 0.5,
                        ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: statColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: statColor.withValues(alpha: 0.3), width: 1),
                ),
                child: Text(
                  widget.stat.baseStat.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: statColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            children: [
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return FractionallySizedBox(
                    widthFactor: normalizedValue * _animation.value,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        gradient:LinearGradient(
                          colors:[statColor, statColor.withValues(alpha: 0.7)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: 
                        [
                          BoxShadow(
                            color: statColor.withValues(alpha: 0.4),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) 
                {
                  return FractionallySizedBox(
                    widthFactor: normalizedValue * _animation.value,
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.0),
                            Colors.white.withValues(alpha: 0.3),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  );
                },
              ),
             ],
          ),
        ],
      ),
    );
  }
}

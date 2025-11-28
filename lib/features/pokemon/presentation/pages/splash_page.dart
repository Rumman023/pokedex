import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/string_constants.dart';
import '../bloc/pokemon_list/pokemon_list_bloc.dart';
import '../bloc/pokemon_list/pokemon_list_event.dart';
import 'pokemon_list_page.dart';

class SplashPage extends StatefulWidget 
{
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin 
{
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;
  Timer? _navigationTimer;

  @override
  void initState() 
  {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();


    final listBloc = context.read<PokemonListBloc>();
    Future.microtask(() => listBloc.add(const LoadPokemonList()));

    _navigationTimer = Timer(const Duration(milliseconds: 1800), _navigateToHome);
  }

  @override
  void dispose() 
  {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHome() 
  {
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushReplacement
    (
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: const PokemonListPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) 
  {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset(
                    'assets/images/pokedex_logo.png',
                    width: 180,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  StringConstants.splashTagline,
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ) ,
              ),
            ],
         ),
        ),
      ),
  );
  }
}

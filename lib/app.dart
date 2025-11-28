import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/string_constants.dart';
import 'core/theme/app_theme.dart';
import 'features/pokemon/presentation/bloc/pokemon_list/pokemon_list_bloc.dart';
import 'features/pokemon/presentation/pages/splash_page.dart';
import 'injection_container.dart';

class App extends StatelessWidget 
{
  const App({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<PokemonListBloc>(),
        ),
      ],
      child: MaterialApp(
        title: StringConstants.appTitle,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
  );
  }
}

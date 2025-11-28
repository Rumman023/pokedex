import 'package:equatable/equatable.dart';

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}

class PokemonDetailParams extends Equatable 
{
  const PokemonDetailParams({required this.url});

  final String url;

  @override
  List<Object?> get props => [url];
}

int extractPokemonIdFromUrl(String url) 
{
  final uri = Uri.parse(url);
  final segments = uri.pathSegments.where((segment) => segment.isNotEmpty).toList();
  if(segments.isEmpty) 
  {
    return 0;
  }
  return int.tryParse(segments.last) ?? 0;
}

String buildPokemonSpriteUrl(int id) => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

String capitalize(String value) {
  if(value.isEmpty) 
  {
    return value;
    }
  return value[0].toUpperCase() + value.substring(1);
}

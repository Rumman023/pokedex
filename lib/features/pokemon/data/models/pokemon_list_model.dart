import '../../../../core/utils/helpers.dart';
import '../../domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  const PokemonModel({required super.id, required super.name, required super.url});

  factory PokemonModel.fromJson(Map<String, dynamic> json) 
  {
    final url = json['url'] as String;
    return PokemonModel(
      id: extractPokemonIdFromUrl(url),
      name: json['name'] as String,
      url: url,
  );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url, };
}

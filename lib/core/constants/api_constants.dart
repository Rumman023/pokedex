class ApiConstants 
{
  static const String baseUrl = 'https://pokeapi.co/api/v2';
  static const String pokemonEndpoint = '/pokemon';
  static const String pokemonListEndpoint = '$pokemonEndpoint?limit=100000&offset=0';
  static const Duration defaultTimeout = Duration(seconds: 15);

  static String pokemonDetailPath(String identifier) => '$pokemonEndpoint/$identifier';
}

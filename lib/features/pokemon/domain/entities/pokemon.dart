import 'package:equatable/equatable.dart';

class Pokemon extends Equatable 
{
  const Pokemon({required this.id, required this.name, required this.url});

  final int id;
  final String name;
  final String url;

  @override
  List<Object?> get props => [id, name, url];
}

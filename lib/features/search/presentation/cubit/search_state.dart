part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class CharactersLoaded extends SearchState {
  final List<CharacterEntity> characters;
  CharactersLoaded({required this.characters});
}

class SearchFailure extends SearchState {
  final String message;
  SearchFailure({required this.message});
}

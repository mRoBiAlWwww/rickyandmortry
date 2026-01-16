part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class CharactersLoaded extends HomeState {
  final List<CharacterEntity> characters;
  CharactersLoaded({required this.characters});
}

class HomeFailure extends HomeState {
  final String message;
  HomeFailure({required this.message});
}

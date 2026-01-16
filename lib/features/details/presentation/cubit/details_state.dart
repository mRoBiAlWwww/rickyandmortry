part of 'details_cubit.dart';

abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class CharacterLoaded extends DetailsState {
  final CharacterEntity character;
  CharacterLoaded({required this.character});
}

class DetailsSuccess extends DetailsState {
  final String message;
  DetailsSuccess({required this.message});
}

class DetailsFailure extends DetailsState {
  final String message;
  DetailsFailure({required this.message});
}

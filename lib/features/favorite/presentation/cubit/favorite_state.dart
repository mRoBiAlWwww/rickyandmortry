part of 'favorite_cubit.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  final String message;
  FavoriteSuccess({required this.message});
}

class FavoritesLoadedSuccess extends FavoriteState {
  final List<Favorite> favorites;
  FavoritesLoadedSuccess({required this.favorites});
}

class FavoriteFailure extends FavoriteState {
  final String message;
  FavoriteFailure({required this.message});
}

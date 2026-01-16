import 'package:bloc/bloc.dart';
import 'package:robi/core/dependency_injection/service_locator.dart';
import 'package:robi/features/favorite/domain/entities/favorite.dart';
import 'package:robi/features/favorite/domain/usecases/get_favorites.dart';
import 'package:robi/features/favorite/domain/usecases/remove_favorite.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  Future<void> loadFavorites() async {
    emit(FavoriteLoading());

    final result = await sl<GetFavoritesUseCase>().call();

    result.fold(
      (failure) => emit(FavoriteFailure(message: failure.toString())),
      (data) => emit(FavoritesLoadedSuccess(favorites: data)),
    );
  }

  Future<void> removeFavoriteItem(int id) async {
    emit(FavoriteLoading());

    final result = await sl<RemoveFavoriteUseCase>().call(id);

    result.fold(
      (failure) {
        emit(FavoriteFailure(message: failure.toString()));
      },
      (data) {
        loadFavorites();
      },
    );
  }
}

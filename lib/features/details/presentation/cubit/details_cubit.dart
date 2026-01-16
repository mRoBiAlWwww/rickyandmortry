import 'package:bloc/bloc.dart';
import 'package:robi/core/data/entities/character.dart';
import 'package:robi/core/dependency_injection/service_locator.dart';
import 'package:robi/features/details/domain/usecases/get_details_character.dart';
import 'package:robi/features/favorite/domain/entities/favorite.dart';
import 'package:robi/features/favorite/domain/usecases/add_favorite.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  Future<void> getDetailsCharacters(int id) async {
    emit(DetailsLoading());
    var returnedData = await sl<GetDetailsCharacterUseCase>().call(id);

    returnedData.fold(
      (error) {
        emit(DetailsFailure(message: error.toString()));
      },
      (data) {
        emit(CharacterLoaded(character: data));
      },
    );
  }

  Future<void> addFavoriteItem(int id, String name, String image) async {
    final favorite = Favorite(
      id: id,
      name: name,
      image: image,
      createdTime: DateTime.now(),
    );

    final result = await sl<AddFavoriteUseCase>().call(favorite);

    result.fold(
      (failure) => emit(DetailsFailure(message: failure.toString())),
      (data) {
        getDetailsCharacters(id);
      },
    );
  }
}

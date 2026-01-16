import 'package:bloc/bloc.dart';
import 'package:robi/core/data/entities/character.dart';
import 'package:robi/core/dependency_injection/service_locator.dart';
import 'package:robi/features/home/domain/usecases/get_all_characters.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getAllCharacters() async {
    emit(HomeLoading());
    var returnedData = await sl<GetAllCharactersUseCase>().call();

    returnedData.fold(
      (error) {
        emit(HomeFailure(message: error.toString()));
      },
      (data) {
        emit(CharactersLoaded(characters: data));
      },
    );
  }
}

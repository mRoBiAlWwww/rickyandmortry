import 'package:bloc/bloc.dart';
import 'package:robi/core/data/entities/character.dart';
import 'package:robi/core/dependency_injection/service_locator.dart';
import 'package:robi/features/search/domain/usecases/get_search_characters.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> getSearchCharacters(String keyword) async {
    emit(SearchLoading());
    var returnedData = await sl<GetSearchCharactersUseCase>().call(keyword);

    returnedData.fold(
      (error) {
        emit(SearchFailure(message: error.toString()));
      },
      (data) {
        emit(CharactersLoaded(characters: data));
      },
    );
  }

  Future<void> resetSearch() async {
    emit(SearchInitial());
  }
}

import 'package:get_it/get_it.dart';
import 'package:robi/features/details/data/datasources/details_service.dart';
import 'package:robi/features/details/data/repositories/details_repository_impl.dart';
import 'package:robi/features/details/domain/repositories/details_repository.dart';
import 'package:robi/features/details/domain/usecases/get_details_character.dart';
import 'package:robi/features/favorite/data/datasources/favorite_service.dart';
import 'package:robi/features/favorite/data/repositories/favorite_repository_impl.dart';
import 'package:robi/features/favorite/domain/repositories/favorite_repository.dart';
import 'package:robi/features/favorite/domain/usecases/add_favorite.dart';
import 'package:robi/features/favorite/domain/usecases/get_favorites.dart';
import 'package:robi/features/favorite/domain/usecases/remove_favorite.dart';
import 'package:robi/features/home/data/datasources/home_service.dart';
import 'package:robi/features/home/data/repositories/home_repository_impl.dart';
import 'package:robi/features/home/domain/repositories/home_repository.dart';
import 'package:robi/features/home/domain/usecases/get_all_characters.dart';
import 'package:robi/features/search/data/datasources/search_service.dart';
import 'package:robi/features/search/data/repositories/search_repository_impl.dart';
import 'package:robi/features/search/domain/repositories/search_repository.dart';
import 'package:robi/features/search/domain/usecases/get_search_characters.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //datasources
  sl.registerSingleton<HomeService>(HomeServiceImpl());
  sl.registerSingleton<DetailsService>(DetailsServiceImpl());
  sl.registerSingleton<SearchService>(SearchServiceImpl());
  sl.registerSingleton<FavoriteService>(FavoriteServiceImpl());

  //repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(service: sl<HomeService>()),
  );
  sl.registerLazySingleton<DetailsRepository>(
    () => DetailsRepositoryImpl(service: sl<DetailsService>()),
  );
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(service: sl<SearchService>()),
  );
  sl.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(service: sl<FavoriteService>()),
  );

  //usecases
  sl.registerSingleton<GetAllCharactersUseCase>(
    GetAllCharactersUseCase(repository: sl<HomeRepository>()),
  );
  sl.registerSingleton<GetDetailsCharacterUseCase>(
    GetDetailsCharacterUseCase(repository: sl<DetailsRepository>()),
  );
  sl.registerSingleton<GetSearchCharactersUseCase>(
    GetSearchCharactersUseCase(repository: sl<SearchRepository>()),
  );
  sl.registerSingleton<AddFavoriteUseCase>(
    AddFavoriteUseCase(repository: sl<FavoriteRepository>()),
  );
  sl.registerSingleton<GetFavoritesUseCase>(
    GetFavoritesUseCase(repository: sl<FavoriteRepository>()),
  );
  sl.registerSingleton<RemoveFavoriteUseCase>(
    RemoveFavoriteUseCase(repository: sl<FavoriteRepository>()),
  );
}

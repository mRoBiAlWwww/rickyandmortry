import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robi/core/bloc/bottom_navigation_cubit.dart';
import 'package:robi/core/config/theme/app_theme.dart';
import 'package:robi/core/dependency_injection/service_locator.dart';
import 'package:robi/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:robi/features/splash/presentation/pages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavCubit()),
        BlocProvider(create: (context) => FavoriteCubit()..loadFavorites()),
      ],
      child: MaterialApp(
        title: "Ricky and Mortry App",
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    );
  }
}

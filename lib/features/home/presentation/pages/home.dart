import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robi/common/widget/list/character_list.dart';
import 'package:robi/features/home/presentation/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllCharacters(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Daftar karakter Rick and Morty"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is HomeFailure) {
                return Center(child: Text('Error: ${state.message}'));
              }
              if (state is CharactersLoaded) {
                return CharacterListWidget(characters: state.characters);
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

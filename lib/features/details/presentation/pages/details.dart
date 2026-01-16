import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robi/core/config/theme/app_colors.dart';
import 'package:robi/core/data/entities/character.dart';
import 'package:robi/features/details/presentation/cubit/details_cubit.dart';
import 'package:robi/features/details/presentation/widgets/character_detail.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  const DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late CharacterEntity character;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit()..getDetailsCharacters(widget.id),
      child: Scaffold(
        backgroundColor: AppColors.splashBackground,
        body: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            if (state is DetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DetailsFailure) {
              return Center(child: Text("Error: ${state.message}"));
            }
            if (state is CharacterLoaded) {
              return CharacterDetailWidget(character: state.character);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

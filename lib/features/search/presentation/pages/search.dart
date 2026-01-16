import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robi/common/widget/list/character_list.dart';
import 'package:robi/core/config/theme/app_colors.dart';
import 'package:robi/features/search/presentation/cubit/search_cubit.dart';
import 'package:robi/features/search/presentation/widgets/searchbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchCon = TextEditingController();
  Timer? debounce;

  void onSearchChanged(BuildContext context, String value) {
    if (debounce?.isActive ?? false) debounce!.cancel();

    debounce = Timer(const Duration(milliseconds: 500), () async {
      if (value.isEmpty) {
        context.read<SearchCubit>().resetSearch();
        return;
      }
      await context.read<SearchCubit>().getSearchCharacters(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.splashBackground,
            appBar: AppBar(
              toolbarHeight: 80,
              titleSpacing: 20,
              title: SearchBarWidget(
                controller: searchCon,
                hint: "Cari karakter...",
                onChanged: (value) => onSearchChanged(context, value),
                onClear: () {
                  searchCon.clear();
                  onSearchChanged(context, "");
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const Center(
                      child: Text(
                        'Mulai cari karakter yang kamu inginkan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is SearchFailure) {
                    return Center(child: Text("Error: ${state.message}"));
                  }
                  if (state is CharactersLoaded) {
                    if (state.characters.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Karakter sesuai pencarian - ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: "${state.characters.length} hasil",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: CharacterListWidget(
                              characters: state.characters,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Tidak ada hasil',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: AppColors.secondaryBackgroundButton,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Anda mungkin salah memasukkan nama karakter atau karakter yang anda cari tidak tersedia",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.disableTextButton,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    }
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

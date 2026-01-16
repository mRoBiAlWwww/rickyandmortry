import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robi/core/config/theme/app_colors.dart';
import 'package:robi/features/details/presentation/pages/details.dart';
import 'package:robi/features/favorite/presentation/cubit/favorite_cubit.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar karakter favorite anda"),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is FavoriteFailure) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is FavoritesLoadedSuccess) {
            if (state.favorites.isEmpty) {
              return Center(
                child: Text(
                  "Belum ada karakter favorite\nSilakan tambahkan dari halaman detail karakter",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 16,
                  ),
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xFFFBFBFB), Color(0xFFEDEDED)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ListView.separated(
                shrinkWrap: false,
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(145, 20, 25, 20),
                  child: const Divider(
                    color: AppColors.disableBackgroundButton,
                    thickness: 1,
                    height: 1,
                  ),
                ),
                itemCount: state.favorites.length,
                itemBuilder: (context, index) {
                  final character = state.favorites[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(id: character.id),
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: character.image.isNotEmpty
                              ? Image.network(
                                  character.image,
                                  width: 110,
                                  height: 110,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 110,
                                  height: 110,
                                  color: Colors.grey.shade300,
                                  child: Icon(Icons.image_not_supported),
                                ),
                        ),
                        const SizedBox(width: 30),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 15),
                                    Text(
                                      character.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    context
                                        .read<FavoriteCubit>()
                                        .removeFavoriteItem(character.id);
                                  },
                                  icon: Icon(
                                    CupertinoIcons.trash,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robi/common/widget/toast/toast.dart';
import 'package:robi/core/config/theme/app_colors.dart';
import 'package:robi/core/data/entities/character.dart';
import 'package:robi/features/details/presentation/cubit/details_cubit.dart';

class CharacterDetailWidget extends StatefulWidget {
  final CharacterEntity character;

  const CharacterDetailWidget({super.key, required this.character});

  @override
  State<CharacterDetailWidget> createState() => _CharacterDetailWidgetState();
}

class _CharacterDetailWidgetState extends State<CharacterDetailWidget> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  bool isMaximized = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScrollChanged);
  }

  void _onScrollChanged() {
    final currentSize = _controller.size;
    if (currentSize >= 0.99 && !isMaximized) {
      setState(() => isMaximized = true);
    } else if (currentSize < 0.99 && isMaximized) {
      setState(() => isMaximized = false);
    }

    if (currentSize < 0.55) {
      _controller.jumpTo(0.55);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScrollChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Gambar
        Positioned.fill(
          child: Image.network(
            widget.character.image,
            alignment: Alignment.topCenter,
            fit: BoxFit.contain,
            width: screenSize.width,
            height: screenSize.height * 0.5,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            },
          ),
        ),

        // Section detail
        DraggableScrollableSheet(
          controller: _controller,
          initialChildSize: 0.6,
          minChildSize: 0.6,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Material(
                      color: AppColors.splashBackground,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: CustomScrollView(
                        controller: scrollController,
                        slivers: [
                          SliverToBoxAdapter(
                            child: isMaximized
                                ? SizedBox.shrink()
                                : Column(
                                    children: [
                                      SizedBox(height: 15),
                                      Container(
                                        width: 40,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),

                          // Header (Nama & Tombol Close)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                      widget.character.name,
                                      style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  isMaximized
                                      ? Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(
                                                  Icons.close,
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                  _controller.animateTo(
                                                    0.55,
                                                    duration: const Duration(
                                                      milliseconds: 400,
                                                    ),
                                                    curve: Curves.easeInOut,
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 32),
                                          ],
                                        )
                                      : const SizedBox(height: 80),
                                ],
                              ),
                            ),
                          ),

                          // List Detail karakter
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 150),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentGeometry.centerRight,
                                          child: IconButton(
                                            onPressed: () {
                                              context
                                                  .read<DetailsCubit>()
                                                  .addFavoriteItem(
                                                    widget.character.id,
                                                    widget.character.name,
                                                    widget.character.image,
                                                  );
                                              context.showSuccessToast(
                                                "Sukses menambahkan ke favorit",
                                              );
                                            },
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            iconSize: 30.0,
                                            icon: Icon(
                                              Icons.favorite_border_outlined,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Origin",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          widget.character.origin.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.secondaryText,
                                            fontSize: 18,
                                          ),
                                        ),

                                        SizedBox(height: 20),
                                        Text(
                                          "Species",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          widget.character.species,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.secondaryText,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "Gender",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          widget.character.gender,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.secondaryText,
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "Location",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          widget.character.location.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.secondaryText,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}

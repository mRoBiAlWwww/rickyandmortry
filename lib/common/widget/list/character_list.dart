import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:robi/core/config/theme/app_colors.dart';
import 'package:robi/core/data/entities/character.dart';
import 'package:robi/features/details/presentation/pages/details.dart';

class CharacterListWidget extends StatelessWidget {
  final List<CharacterEntity> characters;

  const CharacterListWidget({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
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
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final character = characters[index];

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
                const SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          character.status,
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),

                        Text(
                          character.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),

                        const SizedBox(height: 10),
                        const DottedLine(
                          dashLength: 6,
                          dashGapLength: 3,
                          lineThickness: 1,
                          dashColor: AppColors.disableBackgroundButton,
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            const Icon(Icons.flag, size: 16),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                character.origin.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondaryText,
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        Row(
                          children: [
                            const Icon(Icons.emoji_events, size: 16),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                character.location.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondaryText,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ],
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
}

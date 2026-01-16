import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robi/core/bloc/bottom_navigation_cubit.dart';
import 'package:robi/core/config/theme/app_colors.dart';
import 'package:robi/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:robi/features/favorite/presentation/pages/favorites.dart';
import 'package:robi/features/home/presentation/pages/home.dart';
import 'package:robi/features/search/presentation/pages/search.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final List<Widget> topLevelPages = [
    HomePage(),
    SearchPage(),
    FavoritesPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (newContext) {
        return Scaffold(
          body: _mainWrapperBody(newContext),
          bottomNavigationBar: _mainWrapperBottomNavBar(newContext),
        );
      },
    );
  }

  BottomAppBar _mainWrapperBottomNavBar(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      color: AppColors.splashBackground,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.thirdBackGroundButton, width: 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bottomAppBarItem(
              context,
              defaultIcon: Icons.home,
              page: 0,
              label: "Home",
              filledIcon: Icons.home_sharp,
            ),
            _bottomAppBarItem(
              context,
              defaultIcon: Icons.search,
              page: 1,
              label: "Search",
              filledIcon: Icons.search_rounded,
            ),
            _bottomAppBarItem(
              context,
              defaultIcon: Icons.favorite_border_outlined,
              page: 2,
              label: "Favorites",
              filledIcon: Icons.favorite,
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainWrapperBody(BuildContext context) {
    final int currentIndex = context.watch<BottomNavCubit>().state;
    return IndexedStack(index: currentIndex, children: topLevelPages);
  }

  Widget _bottomAppBarItem(
    BuildContext context, {
    required defaultIcon,
    required page,
    required label,
    required filledIcon,
  }) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<BottomNavCubit>(
          context,
        ).changeSelectedIndexJobseeker(page);

        if (page == 2) {
          context.read<FavoriteCubit>().loadFavorites();
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Icon(
              context.watch<BottomNavCubit>().state == page
                  ? filledIcon
                  : defaultIcon,
              size: 30.0,
              color: context.watch<BottomNavCubit>().state == page
                  ? Colors.black
                  : Colors.grey,
            ),

            Text(
              label,
              style: TextStyle(
                color: context.watch<BottomNavCubit>().state == page
                    ? Colors.black
                    : Colors.grey,
                fontSize: 10,
                fontWeight: context.watch<BottomNavCubit>().state == page
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

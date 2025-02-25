import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../controller/home_controller.dart';
import 'component/character_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff0F3A40),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 46),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchBar(
                hintText: 'search...',
                leading: Icon(
                  Icons.search,
                  color: Color(0xff0F3A40),
                ),
                backgroundColor: const WidgetStatePropertyAll<Color>(
                  Color(0xffEBFF6E),
                ),
                controller: homeController.searchBarController,
                onChanged: (value) {
                  homeController.searchChar();
                },

              ),
              SizedBox(
                height: 5.h,
              ),
              Image.asset('assets/images/Header.png'),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    'Characters',
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Container(
                    color: const Color(0xffEBFF6E),
                    height: 2.h,
                    width: 135.w,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              if (homeController.isLoading)
                const Center(child: CircularProgressIndicator()),
              if (homeController.errorMessage != null)
                Center(
                    child: Text(homeController.errorMessage!,
                        style: const TextStyle(color: Colors.white))),
              if (homeController.charactersData?.results != null)
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      homeController.fetchCharacters();
                      homeController.resetPages();
                      print(
                          "from refresh ${homeController.charactersList.length}");
                    },
                    child: ListView.builder(
                      controller: homeController.scrollController,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: homeController.searchBarController.text.isEmpty
                          ? homeController.charactersList.length
                          : homeController.searchedChar.length,
                      itemBuilder: (context, index) {
                        final character =
                            homeController.searchBarController.text.isEmpty
                                ? homeController.charactersList[index]
                                : homeController.searchedChar[index];
                        return CharacterCard(
                          imageUrl: character.image ?? '',
                          id: character.id ?? 0,
                          charName: character.name ?? 'Unknown',
                          status: character.status ?? 'Unknown',
                          species: character.species ?? 'Unknown',
                          gender: character.gender ?? 'Unknown',
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

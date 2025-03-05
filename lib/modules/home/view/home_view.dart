import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/app_router.dart';
import '../controller/home_controller.dart';
import 'component/character_card.dart';
import 'component/my_show_bottom_sheet.dart';

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
                leading: const Icon(
                  Icons.search,
                  color: Color(0xff0F3A40),
                ),
                backgroundColor:
                    WidgetStateProperty.all<Color>(const Color(0xffEBFF6E)),
                controller: homeController.searchBarController,
                onChanged: (value) {
                  homeController.fetchCharacters();
                },
              ),
              SizedBox(
                height: 5.h,
              ),
              Image.asset('assets/images/Header.png'),
              SizedBox(
                height: 10.h,
              ),
              Row(children: [
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
                  width: 65.w,
                ),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => const MyBottomSheet(),
                          isScrollControlled: true);
                    },
                    icon: const Icon(
                      Icons.filter_alt,
                      color: Color(0xffEBFF6E),
                    )),
                IconButton(
                    onPressed: () {
                      // Navigator.pushNamed(context,Routes.characterDetailsRoute
                      Navigator.pushNamed(context, Routes.favorite);
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,size: 40,
                    )),
              ]), ////Characters
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
                      homeController.resetPages();
                      homeController.fetchCharacters();
                    },
                    notificationPredicate: (scrollInfo) {
                      if (scrollInfo is ScrollEndNotification &&
                          scrollInfo.metrics.extentAfter == 0 ) {
                        homeController.loadMore();
                      }
                      return true;
                    },
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: homeController.charactersList.length,
                      itemBuilder: (context, index) {
                        final character = homeController.charactersList[index];
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

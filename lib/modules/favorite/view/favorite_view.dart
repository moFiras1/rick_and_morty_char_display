import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/modules/home/controller/home_controller.dart';
import 'package:rick_and_morty/modules/home/view/component/character_card.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff0F3A40),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 46),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Favorite Character',
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
                    width: 74.w,
                  ),
                ],
              ),
              Expanded(
                child: Consumer<HomeController>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: homeController.favCharList.length,
                      itemBuilder: (context, index) {
                        final character = homeController.favCharList[index];
                        return CharacterCard(
                          imageUrl: character.image ?? '',
                          id: character.id ?? 0,
                          charName: character.name ?? 'Unknown',
                          status: character.status ?? 'Unknown',
                          species: character.species ?? 'Unknown',
                          gender: character.gender ?? 'Unknown',
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

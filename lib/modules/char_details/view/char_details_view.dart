import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/modules/char_details/controller/char_details_controller.dart';

import 'component/char_card_details.dart';

class CharDetailsScreen extends StatefulWidget {
  final int characterId;

  const CharDetailsScreen({
    required this.characterId,
    super.key,
  });

  @override
  _CharDetailsScreenState createState() => _CharDetailsScreenState();
}

class _CharDetailsScreenState extends State<CharDetailsScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CharDetailsController>(context, listen: false)
          .fetchCharDetails(widget.characterId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CharDetailsController>(
      builder: (context,screenController,child) {
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
                        'Character Details',
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
                        width: 80.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  if (screenController.isLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (screenController.errorMessage != null)
                    Center(
                        child: Text(screenController.errorMessage!,
                            style: const TextStyle(color: Colors.white))),
                  if (screenController.charDetails?.id != null)
                    Expanded(
                      child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CharCardDetails(
                            id: screenController.charDetails?.id ?? 0,
                            imageUrl: screenController.charDetails?.image ?? '',
                            locationurl:
                            screenController.charDetails?.location?.url ??
                                'Unknown',
                            type: screenController.charDetails?.type ?? 'Unknown',
                            status:
                            screenController.charDetails?.status ?? 'Unknown',
                            species:
                            screenController.charDetails?.species ?? 'Unknown',
                            locationName:
                            screenController.charDetails?.origin?.name ??
                                'Unknown',
                            gender:
                            screenController.charDetails?.gender ?? 'Unknown',
                            charName:
                            screenController.charDetails?.name ?? 'Unknown',
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
    );
  }
}

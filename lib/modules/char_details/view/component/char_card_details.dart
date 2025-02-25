import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CharCardDetails extends StatelessWidget {
  final Object id;
  final String charName;
  final String status;
  final String type;
  final String species;
  final String gender;
  final String imageUrl;
  final Object locationName;
  final Object locationurl;


  const CharCardDetails({
    super.key,
    required this.imageUrl,
    required this.id,
    required this.charName,
    required this.status,
    required this.type,
    required this.species,
    required this.gender,
    required this.locationName,
    required this.locationurl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(top: 60.r),
          padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 32.w),
          decoration: BoxDecoration(
            color: const Color(0xff0D7C85),
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: const Color(0xffEBFF6E), width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70.h),
              Text(
                charName,
                style: TextStyle(
                  color: const Color(0xffEBFF6E),
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp,
                ),
              ),//// char nameme
              SizedBox(height: 30.h),
              Text(
                "Status:$status",
                style: TextStyle(
                  color: Color(0xffEBFF6E),
                  fontSize: 20.sp,
                ),
              ), ///status
              SizedBox(height: 30.h),
              Text(
                'type: $type ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),//gender
              SizedBox(height: 30.h),
              Text(
                'Species: $species ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),//cSpecies:
              SizedBox(height: 30.h),
              Text(
                'gender: $gender ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),//gender
              SizedBox(height: 30.h),
              Text(
                'locationName: $locationName ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),//gender




            ],
          ),
        ),
        Positioned(
          top: 50,
          child: CircleAvatar(
            radius: 75.r,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ],
    );
  }
}

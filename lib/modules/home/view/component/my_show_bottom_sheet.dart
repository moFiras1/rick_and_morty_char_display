import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../controller/home_controller.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<HomeController>(
      builder: (context, value, child) {
       return  Container(
          padding: EdgeInsets.all(16.w),
          constraints: const BoxConstraints(
          ),
          decoration: BoxDecoration(
            color: const Color(0xffEBFF6E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Status Filter
              Text('Status', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.h),
              Column(
                children: value.statusList.map((status) => ListTile(
                  title: Text(status),
                  leading: Radio<String>(
                    value: status,
                    groupValue: value.selectedStatus,
                    onChanged: (onChangedValue) {
                      value.selectedStatus = onChangedValue!;
                      value.notifyListeners();
                    },
                  ),
                )).toList(),
              ),
              SizedBox(height: 10.h),

              // Gender Filter
              Text('Gender', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.h),
              Column(
                children: value.genderList.map((gender) => ListTile(
                  title: Text(gender),
                  leading: Radio<String>(
                    value: gender,
                    groupValue: value.selectedGender,
                    onChanged: (onChangeValue) {
                      value.selectedGender = onChangeValue!;
                      value.notifyListeners();
                    },
                  ),
                )).toList(),
              ),

              // Buttons
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () { value.clearFilter();
                      Navigator.pop(context);

                      },
                      child: const Text("Clear"),
                    ),
                    SizedBox(width: 5.w),
                    ElevatedButton(
                      onPressed: () {
                        value.resetPages();
                        Navigator.pop(context);
                      },
                      child: const Text("Save"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

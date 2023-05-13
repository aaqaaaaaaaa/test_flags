import 'package:flutter/material.dart';
import 'package:screensize_utils/screensize_util.dart';
import 'package:test_flags/common/app_colors.dart';
import 'package:test_flags/fuatures/home/data/models/country_model.dart';
import 'package:test_flags/fuatures/home/presentation/widgets/flags_cache_image_widget.dart';
import 'package:test_flags/fuatures/home/presentation/widgets/item_info_widget.dart';

class CountryCardWidget extends StatelessWidget {
  const CountryCardWidget({super.key, required this.item});

  // final String common, official, flagPng;
  final CountriesModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: Colors.black38,
      child: InkWell(
        onTap: () {
          countryShowModalBottomSheet(context);
        },
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          height: 80.h,
          width: 300.w,
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r), color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 230.w,
                    child: Text(item.common ?? '',
                        style: AppTheme.body22w5,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    width: 210.w,
                    child: Text(
                      item.official ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.body14w5,
                    ),
                  ),
                ],
              ),
              FlagsCacheImage(imageUrl: item.flagsPng ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> countryShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Column(
            children: [
              Container(
                width: 45.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(50.r)),
              ),
              FlagsCacheImage(
                  height: 60.h, width: 100.w, imageUrl: item.flagsPng ?? ''),
              SizedBox(height: 24.h),
              CountryItemInfoWidget(
                  title: 'Official', desc: '${item.official}'),
              CountryItemInfoWidget(title: 'Capital', desc: item.capital?[0]),
              CountryItemInfoWidget(
                  title: 'Continent', desc: item.continents?[0]),
              CountryItemInfoWidget(
                  title: 'Timezones', desc: '${item.timezones?[0]}'),
              CountryItemInfoWidget(title: 'Region', desc: '${item.region}'),
              CountryItemInfoWidget(
                  title: 'Subregion',
                  isHaveDivider: false,
                  desc: '${item.subregion}'),
            ],
          ),
        );
      },
    );
  }
}

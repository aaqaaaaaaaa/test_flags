import 'package:flutter/material.dart';
import 'package:screensize_utils/screensize_util.dart';
import 'package:test_flags/common/app_colors.dart';

class CountryItemInfoWidget extends StatelessWidget {
  const CountryItemInfoWidget({
    super.key,
    required this.title,
    this.isHaveDivider = true,
    required this.desc,
  });

  final bool isHaveDivider;
  final String desc, title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style:
                      AppTheme.body22w5.copyWith(fontWeight: FontWeight.w600)),
              Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width * .5,
                  child: Text(
                    desc,
                    style: AppTheme.body14w5.copyWith(fontSize: 18.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
            ],
          ),
          if (isHaveDivider) const Divider(),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screensize_utils/screensize_util.dart';
import 'package:test_flags/common/app_colors.dart';
import 'package:test_flags/di/di.dart';
import 'package:test_flags/fuatures/home/presentation/manager/country_cubit.dart';
import 'package:test_flags/fuatures/home/presentation/widgets/custom_anim_search_bar.dart';
import 'package:test_flags/fuatures/home/presentation/widgets/country_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static Widget screen() {
    return BlocProvider<CountryCubit>(
      create: (context) => di<CountryCubit>()..getCountryList(),
      child: const HomePage(),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: CustomAnimSearchBar(
              autoFocus: true,
              style: AppTheme.body14w5
                  .copyWith(fontSize: 20.sp, color: AppTheme.black),
              width: MediaQuery.of(context).size.width,
              textController: textController,
              onSuffixTap: () {
                textController.clear();
                context
                    .read<CountryCubit>()
                    .searchCountryList(textController.text);
              },
              onSubmitted: (value) {
                context.read<CountryCubit>().searchCountryList(value);
              },
              onChanged: (value) {
                context.read<CountryCubit>().searchCountryList(value);
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<CountryCubit, CountryState>(
        builder: (context, state) {
          if (state is CountryLoadedState) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              itemCount: state.data.length,
              separatorBuilder: (context, index) => SizedBox(height: 2.h),
              itemBuilder: (context, index) {
                return CountryCardWidget(item: state.data[index]);
              },
            );
          } else if (state is CountrySearchEmptyState) {
            return Center(
                child: Text(
              'Bunday ma`lumot topilmadi!',
              style: AppTheme.body22w5.copyWith(fontSize: 18.sp),
            ));
          } else if (state is CountryErrorState) {
            return Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    "Internet bilan aloqa yo'q! Qayta urinib ko'ring!",
                    textAlign: TextAlign.center,
                    style: AppTheme.body22w5.copyWith(fontSize: 24.sp),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<CountryCubit>().getCountryList();
                    },
                    child: const Text('Yangilash'))
              ],
            ));
          } else if (state is CountryLoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: AppTheme.black));
          }

          return const Center(
              child: CircularProgressIndicator(color: AppTheme.black));
        },
      ),
    );
  }
}

import 'dart:io';

import 'package:cutfx_salon/bloc/addstaff/add_staff_bloc.dart';
import 'package:cutfx_salon/model/staff/staff.dart';
import 'package:cutfx_salon/screens/editSalon/edit_salon_categories_widget.dart';
import 'package:cutfx_salon/screens/main/main_screen.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class AddStaffScreen extends StatelessWidget {
  const AddStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddStaffBloc(),
      child: Scaffold(
        body: BlocBuilder<AddStaffBloc, AddStaffState>(
          builder: (context, state) {
            AddStaffBloc addStaffBloc = context.read<AddStaffBloc>();
            return Column(
              children: [
                ToolBarWidget(
                  title: addStaffBloc.staffData == null
                      ? AppLocalizations.of(context)!.addStaff
                      : AppLocalizations.of(context)!.editStaff,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: CustomCircularInkWell(
                              onTap: () {
                                addStaffBloc.add(ImageSelectClickEvent());
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1000),
                                  color: ColorRes.smokeWhite3,
                                ),
                                padding: const EdgeInsets.all(1),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: ClipOval(
                                  child: Stack(
                                    children: [
                                      const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: BgRoundImageWidget(
                                            image: AssetRes.icPlus_,
                                            imageColor: ColorRes.darkGray,
                                            height: 45,
                                            width: 45,
                                            bgColor: ColorRes.transparent,
                                          ),
                                        ),
                                      ),
                                      addStaffBloc.imageFile != null
                                          ? Image(
                                              height: double.infinity,
                                              width: double.infinity,
                                              image: FileImage(
                                                addStaffBloc.imageFile ??
                                                    File('path'),
                                              ),
                                              fit: BoxFit.cover,
                                              loadingBuilder: loadingImage,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const SizedBox(),
                                            )
                                          : FadeInImage.assetNetwork(
                                              height: double.infinity,
                                              width: double.infinity,
                                              image:
                                                  '${ConstRes.itemBaseUrl}${addStaffBloc.imageUrl}',
                                              fit: BoxFit.cover,
                                              placeholder: '1',
                                              placeholderErrorBuilder:
                                                  loadingImage,
                                              imageErrorBuilder: (context,
                                                      error, stackTrace) =>
                                                  const SizedBox(),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.barberName,
                            controller: addStaffBloc.nameController,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextWithTextFieldSmokeWhiteWidget(
                            title: AppLocalizations.of(context)!.mobileNumber,
                            controller: addStaffBloc.mobileNumberController,
                            textInputType: TextInputType.phone,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            AppLocalizations.of(context)!.gender,
                            style: kLightWhiteTextStyle.copyWith(
                              color: ColorRes.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GenderSelectWidget(
                            addStaffBloc: addStaffBloc,
                            gender: addStaffBloc.genderType,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    margin:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: TextButton(
                      onPressed: () {
                        addStaffBloc.onTapSubmit();
                      },
                      style: kButtonThemeStyle,
                      child: Text(
                        addStaffBloc.staffData == null
                            ? AppLocalizations.of(context)!.addStaff
                            : AppLocalizations.of(context)!.editStaff,
                        style: kBlackButtonTextStyle.copyWith(
                          color: ColorRes.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class GenderSelectWidget extends StatefulWidget {
  final AddStaffBloc? addStaffBloc;
  final int gender;

  const GenderSelectWidget({
    super.key,
    this.addStaffBloc,
    required this.gender,
  });

  @override
  State<GenderSelectWidget> createState() => _GenderSelectWidgetState();
}

class _GenderSelectWidgetState extends State<GenderSelectWidget> {
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    selectedIndex =
        (Get.arguments as StaffData?)?.gender?.toInt() ?? widget.gender;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          ItemGenderWidget(
            title: AppLocalizations.of(context)!.male,
            filterIsSelected: selectedIndex == 1,
            onTap: () {
              selectedIndex = 1;
              widget.addStaffBloc?.genderType = selectedIndex;
              setState(() {});
            },
            horizontalPadding: 30,
          ),
          ItemGenderWidget(
            horizontalPadding: 30,
            title: AppLocalizations.of(context)!.female,
            filterIsSelected: selectedIndex == 0,
            onTap: () {
              selectedIndex = 0;
              widget.addStaffBloc?.genderType = selectedIndex;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

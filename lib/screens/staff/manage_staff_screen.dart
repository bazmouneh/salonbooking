import 'package:cutfx_salon/bloc/managestaff/manage_staff_bloc.dart';
import 'package:cutfx_salon/model/staff/staff.dart';
import 'package:cutfx_salon/screens/addStaff/add_staff_screen.dart';
import 'package:cutfx_salon/screens/stafforderhistory/staff_order_history_screen.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_bottom_sheet.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class ManageStaffScreen extends StatelessWidget {
  const ManageStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageStaffBloc(),
      child: BlocBuilder<ManageStaffBloc, ManageStaffState>(
        builder: (context, state) {
          ManageStaffBloc manageStaffBloc = context.read<ManageStaffBloc>();
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              onPressed: () {
                Get.to(() => const AddStaffScreen())?.then(
                  (value) {
                    ManageStaffBloc manageStaffBloc =
                        context.read<ManageStaffBloc>();
                    manageStaffBloc.fetchStaff();
                  },
                );
              },
              backgroundColor: ColorRes.themeColor,
              child: const Image(
                image: AssetImage(AssetRes.icPlus_),
                height: 30,
                width: 30,
              ),
            ),
            body: Column(
              children: [
                ToolBarWidget(
                  title: AppLocalizations.of(context)!.manageStaff,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 100,
                    ),
                    itemBuilder: (context, index) {
                      StaffData? staffData =
                          manageStaffBloc.staff?.data?[index];
                      return ItemStaff(staffData: staffData);
                    },
                    itemCount: manageStaffBloc.staff?.data?.length ?? 0,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ItemStaff extends StatelessWidget {
  const ItemStaff({
    super.key,
    required this.staffData,
  });

  final StaffData? staffData;

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: () {
        Get.to(() => const StaffOrderHistoryScreen(), arguments: staffData);
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: ColorRes.smokeWhite2,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipOval(
              child: FadeInImage.assetNetwork(
                image: '${ConstRes.itemBaseUrl}${staffData?.photo}',
                height: 75,
                width: 75,
                fit: BoxFit.cover,
                placeholder: AssetRes.icUser,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${staffData?.name}',
                            style: kMediumTextStyle.copyWith(
                              fontSize: 17,
                              color: ColorRes.nero,
                            ),
                          ),
                          Text(
                            (staffData?.gender?.toInt() == 1
                                    ? AppLocalizations.of(context)!.male
                                    : AppLocalizations.of(context)!.female)
                                .toUpperCase(),
                            style: kThinWhiteTextStyle.copyWith(
                              color: ColorRes.subTitleText,
                              letterSpacing: 1,
                              fontSize: 13,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorRes.pumpkin15,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: const EdgeInsets.only(top: 3, right: 5),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 2,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '${staffData?.rating != 0 ? staffData?.rating?.toStringAsFixed(1) : staffData?.rating}',
                                      style: kSemiBoldTextStyle.copyWith(
                                        color: ColorRes.pumpkin,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.star_rounded,
                                      color: ColorRes.pumpkin,
                                      size: 16,
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.totalOrders_,
                                style: kLightWhiteTextStyle.copyWith(
                                  color: ColorRes.subTitleText,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${staffData?.bookingsCount ?? 0}',
                                style: kBoldThemeTextStyle.copyWith(
                                  fontSize: 16,
                                  color: ColorRes.nero,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ToggleButton(
                            isActive: staffData?.status == 1,
                            onToggleChange: (isActive) {
                              ApiService().changeStaffStatus(
                                staffId: staffData?.id?.toInt() ?? -1,
                                status: isActive ? 1 : 0,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomMenuWidget(
                            onMenuClick: (int position) {
                              if (position == 0) {
                                //Edit
                                Get.to(
                                  () => const AddStaffScreen(),
                                  arguments: staffData,
                                )?.then(
                                  (value) {
                                    ManageStaffBloc manageStaffBloc =
                                        context.read<ManageStaffBloc>();
                                    manageStaffBloc.fetchStaff();
                                  },
                                );
                              } else if (position == 1) {
                                //Order History
                                Get.to(() => const StaffOrderHistoryScreen(),
                                    arguments: staffData);
                              } else {
                                //Delete
                                Get.bottomSheet(
                                  ConfirmationBottomSheet(
                                    title: AppLocalizations.of(context)!
                                        .deleteStaff,
                                    description: staffData?.name ?? '',
                                    buttonText:
                                        AppLocalizations.of(Get.context!)!
                                            .delete,
                                    onButtonClick: () async {
                                      AppRes.showCustomLoader();
                                      await ApiService()
                                          .deleteStaff(
                                        staffId: staffData?.id?.toInt() ?? -1,
                                      )
                                          .then(
                                        (value) {
                                          ManageStaffBloc manageStaffBloc =
                                              context.read<ManageStaffBloc>();
                                          manageStaffBloc.fetchStaff();
                                          AppRes.hideCustomLoaderWithBack();
                                        },
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

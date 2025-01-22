import 'package:cutfx_salon/model/staff/staff.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SalonStaffPage extends StatefulWidget {
  const SalonStaffPage({super.key});

  @override
  State<SalonStaffPage> createState() => _SalonStaffPageState();
}

class _SalonStaffPageState extends State<SalonStaffPage> {
  List<StaffData> staffs = [];
  var isLoading = true;

  @override
  void initState() {
    ApiService().fetchAllStaffOfSalon().then(
      (value) {
        isLoading = false;
        if (value.data != null) {
          staffs = value.data
                  ?.where(
                    (element) => element.status == 1,
                  )
                  .toList() ??
              [];
        }
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: ColorRes.themeColor,
            ),
          )
        : staffs.isEmpty
            ? const Center(child: DataNotFound())
            : ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                itemCount: staffs.length,
                itemBuilder: (context, index) {
                  return ItemStaff(
                    staffData: staffs[index],
                    isSelected: false,
                  );
                },
              );
  }
}

class ItemStaff extends StatelessWidget {
  const ItemStaff({
    super.key,
    required this.staffData,
    required this.isSelected,
  });

  final StaffData? staffData;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: ColorRes.smokeWhite2,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? ColorRes.themeColor : ColorRes.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Container(
              color: ColorRes.smokeWhite,
              height: 70,
              width: 70,
              child: FadeInImage.assetNetwork(
                image: '${ConstRes.itemBaseUrl}${staffData?.photo}',
                fit: BoxFit.cover,
                placeholder: '1',
                placeholderErrorBuilder: (context, error, stackTrace) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Image(
                      image: AssetImage(AssetRes.icUser),
                    ),
                  );
                },
                imageErrorBuilder: (context, error, stackTrace) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Image(
                      image: AssetImage(AssetRes.icUser),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${staffData?.name}',
                style: kMediumTextStyle.copyWith(
                  fontSize: 17,
                  color: ColorRes.nero,
                ),
              ),
              Text(
                AppRes.getGenderTypeInStringFromNumber(
                    context, staffData?.gender?.toInt() ?? 0),
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
                    AppLocalizations.of(context)!.totalOrders,
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
              const SizedBox(
                height: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

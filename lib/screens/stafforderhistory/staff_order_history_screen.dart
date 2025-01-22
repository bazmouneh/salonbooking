import 'package:cutfx_salon/bloc/orderhistory/staff_order_history_bloc.dart';
import 'package:cutfx_salon/model/staff/staff.dart';
import 'package:cutfx_salon/screens/bookinghistory/history_widget.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class StaffOrderHistoryScreen extends StatelessWidget {
  const StaffOrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaffOrderHistoryBloc(),
      child: Scaffold(
        body: BlocBuilder<StaffOrderHistoryBloc, StaffOrderHistoryState>(
          builder: (context, state) {
            StaffOrderHistoryBloc bookingHistoryBloc =
                context.read<StaffOrderHistoryBloc>();
            return Column(
              children: [
                Container(
                  color: ColorRes.smokeWhite,
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 15),
                  child: SafeArea(
                    bottom: false,
                    child: Row(
                      children: [
                        CustomCircularInkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Image(
                              image: AssetImage(AssetRes.icBack),
                              color: ColorRes.themeColor,
                              height: 30,
                            ),
                          ),
                        ),
                        TopStaffWidget(
                          staffData: bookingHistoryBloc.staffData,
                          isSelected: false,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: state is StaffOrderHistoryInitial
                      ? const LoadingData()
                      : bookingHistoryBloc.bookings.isEmpty
                          ? const DataNotFound()
                          : SingleChildScrollView(
                              controller: bookingHistoryBloc.scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BookingHistoryWidget(
                                    bookings:
                                        bookingHistoryBloc.bookings.toList(),
                                  ),
                                ],
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

class TopStaffWidget extends StatelessWidget {
  const TopStaffWidget({
    super.key,
    required this.staffData,
    required this.isSelected,
  });

  final StaffData? staffData;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
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
                height: 50,
                width: 50,
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
                Row(
                  children: [
                    Text(
                      '${AppLocalizations.of(context)!.totalOrders} :',
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
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
              ],
            ),
            const Spacer(),
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
          ],
        ),
      ),
    );
  }
}

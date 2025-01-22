import 'dart:io';
import 'dart:math';

import 'package:cutfx_salon/bloc/requestdetails/request_details_bloc.dart';
import 'package:cutfx_salon/model/address/address.dart';
import 'package:cutfx_salon/model/order_summary.dart';
import 'package:cutfx_salon/model/request/request_details.dart';
import 'package:cutfx_salon/model/user/salon.dart';
import 'package:cutfx_salon/screens/booking/widget/complete_booking_sheet.dart';
import 'package:cutfx_salon/screens/main/main_screen.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as url;
import 'package:url_launcher/url_launcher.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({super.key});

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  bool rateIsGave = false;
  bool orderIsStart = Random().nextBool();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestDetailsBloc(),
      child: Scaffold(
        body: BlocBuilder<RequestDetailsBloc, RequestDetailsState>(
          builder: (context, state) {
            RequestDetails? requestDetails =
                state is RequestDetailFoundState ? state.requestDetails : null;

            return Column(
              children: [
                Container(
                  color: ColorRes.smokeWhite,
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 15),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .bookingDetails,
                                    style: kBoldThemeTextStyle,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    requestDetails?.data?.bookingId ?? '',
                                    style: kRegularTextStyle.copyWith(
                                      fontSize: 14,
                                      color: ColorRes.empress,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${AppRes.currency}${requestDetails?.data?.payableAmount ?? ''}',
                                        style: kRegularThemeTextStyle.copyWith(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Text(
                                          AppLocalizations.of(context)!.dash,
                                          style: kLightWhiteTextStyle.copyWith(
                                            color: ColorRes.themeColor,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppRes.convertTimeForService(int.parse(
                                            requestDetails?.data?.duration ??
                                                '0')),
                                        style: kLightTextStyle.copyWith(
                                          color: ColorRes.themeColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                requestDetails == null
                    ? const Expanded(
                        child: Center(
                          child: LoadingData(
                            color: ColorRes.white,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 15,
                                      ),
                                      color: AppRes.getColorByStatus(
                                          requestDetails.data?.status
                                                  ?.toInt() ??
                                              0),
                                      child: Text(
                                        AppRes.getTextByStatus(requestDetails
                                                .data?.status
                                                ?.toInt() ??
                                            0),
                                        style: kRegularTextStyle.copyWith(
                                          color: AppRes.getTextColorByStatus(
                                              requestDetails.data?.status
                                                      ?.toInt() ??
                                                  0),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    AspectRatio(
                                      aspectRatio: 1 / .25,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: ColorRes.smokeWhite,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 1 / 1,
                                              child: FadeInImage.assetNetwork(
                                                image:
                                                    '${ConstRes.itemBaseUrl}${requestDetails.data?.user?.profileImage}',
                                                fit: BoxFit.cover,
                                                imageErrorBuilder:
                                                    errorBuilderForImage,
                                                placeholderErrorBuilder:
                                                    loadingImage,
                                                placeholder: '1',
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  right: 15,
                                                  left: 15,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      requestDetails
                                                              .data
                                                              ?.user
                                                              ?.fullname
                                                              ?.capitalize ??
                                                          '',
                                                      style: kSemiBoldTextStyle
                                                          .copyWith(
                                                        color: ColorRes.nero,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      requestDetails.data?.user
                                                              ?.phoneNumber ??
                                                          '',
                                                      style: kThinWhiteTextStyle
                                                          .copyWith(
                                                        color:
                                                            ColorRes.titleText,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            BgRoundImageWidget(
                                              image: AssetRes.icCall,
                                              bgColor: ColorRes.smokeWhite1,
                                              imagePadding: 10,
                                              imageColor: ColorRes.themeColor,
                                              height: 45,
                                              width: 45,
                                              onTap: () {
                                                url.launchUrl(Uri.parse(
                                                    'tel:${requestDetails.data?.user?.phoneNumber}'));
                                              },
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: ColorRes.smokeWhite2,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),
                                      padding: const EdgeInsets.only(top: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .date,
                                                      style:
                                                          kLightWhiteTextStyle
                                                              .copyWith(
                                                        color: ColorRes.empress,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      AppRes.formatDate(
                                                        AppRes.parseDate(
                                                          requestDetails
                                                                  .data?.date ??
                                                              '',
                                                          pattern: 'yyyy-MM-dd',
                                                          isUtc: false,
                                                        ),
                                                        pattern: 'dd MMM, yyyy',
                                                        isUtc: false,
                                                      ),
                                                      style:
                                                          kRegularThemeTextStyle
                                                              .copyWith(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .time,
                                                      style:
                                                          kLightWhiteTextStyle
                                                              .copyWith(
                                                        color: ColorRes.empress,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      AppRes
                                                          .convert24HoursInto12Hours(
                                                              requestDetails
                                                                  .data?.time),
                                                      style:
                                                          kRegularThemeTextStyle
                                                              .copyWith(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .duration,
                                                      style:
                                                          kLightWhiteTextStyle
                                                              .copyWith(
                                                        color: ColorRes.empress,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Text(
                                                      AppRes.convertTimeForService(
                                                          int.parse(requestDetails
                                                                  .data
                                                                  ?.duration ??
                                                              '0')),
                                                      style:
                                                          kRegularThemeTextStyle
                                                              .copyWith(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 20,
                                              bottom: 10,
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .serviceLocation,
                                              style:
                                                  kLightWhiteTextStyle.copyWith(
                                                color: ColorRes.empress,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          BookingAddressWidget(
                                            addressData: requestDetails
                                                .data?.serviceAddress,
                                            serviceLocationType: requestDetails
                                                    .data?.serviceLocation
                                                    ?.toInt() ??
                                                0,
                                          ),
                                          Visibility(
                                            visible:
                                                requestDetails.data?.staff !=
                                                    null,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                                top: 10,
                                                bottom: 10,
                                              ),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .staff,
                                                style: kLightWhiteTextStyle
                                                    .copyWith(
                                                  color: ColorRes.empress,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                requestDetails.data?.staff !=
                                                    null,
                                            child: Container(
                                              color: ColorRes.smokeWhite,
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                              child: Row(
                                                children: [
                                                  ClipOval(
                                                    child: Container(
                                                      height: 55,
                                                      width: 55,
                                                      color:
                                                          ColorRes.smokeWhite2,
                                                      child: FadeInImage
                                                          .assetNetwork(
                                                        image:
                                                            '${ConstRes.itemBaseUrl}${requestDetails.data?.staff?.photo}',
                                                        fit: BoxFit.cover,
                                                        placeholder: '1',
                                                        placeholderErrorBuilder:
                                                            (context, error,
                                                                stackTrace) {
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 15),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  AssetRes
                                                                      .icUser),
                                                            ),
                                                          );
                                                        },
                                                        imageErrorBuilder:
                                                            (context, error,
                                                                stackTrace) {
                                                          return const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 15),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  AssetRes
                                                                      .icUser),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            requestDetails
                                                                    .data
                                                                    ?.staff
                                                                    ?.name ??
                                                                '',
                                                            style:
                                                                kRegularThemeTextStyle
                                                                    .copyWith(
                                                              color:
                                                                  ColorRes.nero,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            AppRes.getGenderTypeInStringFromNumber(
                                                                context,
                                                                requestDetails
                                                                        .data
                                                                        ?.staff
                                                                        ?.gender
                                                                        ?.toInt() ??
                                                                    0),
                                                            style:
                                                                kLightWhiteTextStyle
                                                                    .copyWith(
                                                              fontSize: 14,
                                                              color: ColorRes
                                                                  .empress,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 20,
                                              bottom: 10,
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .services,
                                              style:
                                                  kLightWhiteTextStyle.copyWith(
                                                color: ColorRes.empress,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: List<Widget>.generate(
                                              requestDetails
                                                      .data?.services?.length ??
                                                  0,
                                              (index) {
                                                Services? serviceData =
                                                    requestDetails
                                                        .data?.services?[index];
                                                return Container(
                                                  color: ColorRes.smokeWhite,
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            serviceData
                                                                    ?.title ??
                                                                '',
                                                            style:
                                                                kRegularTextStyle
                                                                    .copyWith(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                          Text(
                                                            '${serviceData?.category?.title} | ${AppRes.convertTimeForService(serviceData?.serviceTime ?? 0)}',
                                                            style:
                                                                kLightTextStyle
                                                                    .copyWith(
                                                              color: ColorRes
                                                                  .themeColor,
                                                              fontSize: 15,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        '${AppRes.currency}${(serviceData?.price?.toInt() ?? 0) - AppRes.calculateDiscountByPercentage(serviceData?.price?.toInt() ?? 0, serviceData?.discount?.toInt() ?? 0).toInt()}',
                                                        style:
                                                            kSemiBoldThemeTextStyle
                                                                .copyWith(
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Visibility(
                                            visible: requestDetails.data
                                                    ?.getOrderSummary()
                                                    .coupon !=
                                                null,
                                            child: Container(
                                              color: ColorRes.smokeWhite,
                                              margin: const EdgeInsets.only(
                                                  bottom: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .couponDiscount,
                                                        style: kRegularTextStyle
                                                            .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 2,
                                                      ),
                                                      Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: ColorRes
                                                              .smokeWhite1,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 3),
                                                        child: Text(
                                                          (requestDetails.data
                                                                      ?.getOrderSummary()
                                                                      .coupon
                                                                      ?.coupon ??
                                                                  '')
                                                              .toUpperCase(),
                                                          style:
                                                              kBoldThemeTextStyle
                                                                  .copyWith(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '-${AppRes.currency}${requestDetails.data?.getOrderSummary().discountAmount}',
                                                    style:
                                                        kSemiBoldThemeTextStyle
                                                            .copyWith(
                                                      fontSize: 18,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            color: ColorRes.lavender,
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 15),
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .subTotal,
                                                  style: kRegularTextStyle
                                                      .copyWith(
                                                    fontSize: 16,
                                                    color: ColorRes.themeColor,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  '${AppRes.currency}${requestDetails.data?.getOrderSummary().subtotal}',
                                                  style: kSemiBoldThemeTextStyle
                                                      .copyWith(
                                                    fontSize: 18,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: List<Widget>.generate(
                                                requestDetails.data
                                                        ?.getOrderSummary()
                                                        .taxes
                                                        ?.length ??
                                                    0, (index) {
                                              Taxes? tax = requestDetails.data
                                                  ?.getOrderSummary()
                                                  .taxes?[index];
                                              return Container(
                                                color: ColorRes.smokeWhite,
                                                margin: const EdgeInsets.only(
                                                    bottom: 5),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 15),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      tax?.taxTitle ?? '',
                                                      style: kRegularTextStyle
                                                          .copyWith(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      '${AppRes.currency}${tax?.taxAmount}',
                                                      style:
                                                          kSemiBoldThemeTextStyle
                                                              .copyWith(
                                                        fontSize: 18,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                          Container(
                                            color: ColorRes.charcoal,
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 15,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .totalAmount,
                                                  style: kRegularTextStyle
                                                      .copyWith(
                                                    fontSize: 16,
                                                    color: ColorRes.white,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  '${AppRes.currency}${requestDetails.data?.payableAmount}',
                                                  style: kSemiBoldThemeTextStyle
                                                      .copyWith(
                                                    fontSize: 18,
                                                    color: ColorRes.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: ColorRes.lavender,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                bottom: Radius.circular(20),
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 20,
                                            ),
                                            margin: const EdgeInsets.only(
                                              top: 10,
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .paymentType,
                                                  style: kRegularThemeTextStyle
                                                      .copyWith(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  AppRes.getPaymentType(
                                                      requestDetails
                                                          .data?.paymentType
                                                          ?.toInt()),
                                                  style: kMediumThemeTextStyle
                                                      .copyWith(
                                                    fontSize: 15,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: requestDetails.data?.isRated
                                              ?.toInt() ==
                                          1,
                                      child: Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: ColorRes.smokeWhite,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        margin: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .reviews,
                                              style: kRegularThemeTextStyle,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            RatingBar(
                                              initialRating: requestDetails
                                                      .data?.review?.rating
                                                      ?.toDouble() ??
                                                  0,
                                              ignoreGestures: true,
                                              ratingWidget: RatingWidget(
                                                full: const Icon(
                                                  Icons.star_rounded,
                                                  color: ColorRes.sun,
                                                ),
                                                half: const Icon(
                                                  Icons.star_rounded,
                                                ),
                                                empty: const Icon(
                                                  Icons.star_rounded,
                                                  color: ColorRes.darkGray,
                                                ),
                                              ),
                                              onRatingUpdate: (value) {},
                                              itemSize: 30,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              requestDetails
                                                      .data?.review?.comment ??
                                                  '',
                                              style:
                                                  kLightWhiteTextStyle.copyWith(
                                                color: ColorRes.empress,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SafeArea(
                              top: false,
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: requestDetails.data?.status == 0,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: CustomCircularInkWell(
                                            onTap: () {
                                              context
                                                  .read<RequestDetailsBloc>()
                                                  .rejectBooking();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: ColorRes.bitterSweet10,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .decline,
                                                style: kRegularThemeTextStyle
                                                    .copyWith(
                                                  color: ColorRes.bitterSweet,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: CustomCircularInkWell(
                                            onTap: () {
                                              if (requestDetails
                                                      .data?.serviceLocation
                                                      ?.toInt() ==
                                                  1) {
                                                Get.bottomSheet(
                                                  AcceptBottomSheet(
                                                    addressData: requestDetails
                                                        .data?.serviceAddress,
                                                    onClick: () {
                                                      context
                                                          .read<
                                                              RequestDetailsBloc>()
                                                          .acceptBooking();
                                                    },
                                                  ),
                                                );
                                                return;
                                              }
                                              context
                                                  .read<RequestDetailsBloc>()
                                                  .acceptBooking();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: ColorRes.green10,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 15,
                                              ),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .accept,
                                                style: kRegularThemeTextStyle
                                                    .copyWith(
                                                  color: ColorRes.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: requestDetails.data?.status == 1,
                                    child: CustomCircularInkWell(
                                      onTap: () {
                                        Get.bottomSheet(
                                          CompleteBookingSheet(
                                            requestDetails: requestDetails,
                                          ),
                                          isScrollControlled: true,
                                          ignoreSafeArea: false,
                                        ).then((value) {});
                                      },
                                      child: Container(
                                        color: ColorRes.green10,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 18),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .markCompleted,
                                          style:
                                              kRegularThemeTextStyle.copyWith(
                                            color: ColorRes.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
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

class AcceptBottomSheet extends StatelessWidget {
  const AcceptBottomSheet({
    super.key,
    this.addressData,
    required this.onClick,
  });

  final AddressData? addressData;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.acceptBooking,
                  style: kBoldThemeTextStyle,
                ),
                const Spacer(),
                const CloseButtonWidget(),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const RotatedBox(
                  quarterTurns: 2,
                  child: Icon(
                    Icons.info,
                    color: ColorRes.burntSienna,
                    size: 22,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  AppLocalizations.of(context)!.differentLocation,
                  style: kMediumThemeTextStyle.copyWith(
                    color: ColorRes.burntSienna,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              AppLocalizations.of(context)!
                  .customerHasChosenToServeAtDifferentLocationAsMentioned,
              style: kLightWhiteTextStyle.copyWith(
                color: ColorRes.burntSienna,
                fontSize: 16,
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BookingAddressWidget(
            addressData: addressData,
            serviceLocationType: -1,
          ),
          const Spacer(),
          SafeArea(
            top: false,
            child: CustomCircularInkWell(
              onTap: () {
                Get.back();
                onClick();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorRes.apple,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: Text(
                  AppLocalizations.of(context)!.accept,
                  style: kRegularThemeTextStyle.copyWith(
                    color: ColorRes.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingAddressWidget extends StatelessWidget {
  const BookingAddressWidget({
    super.key,
    required this.addressData,
    required this.serviceLocationType,
  });

  final AddressData? addressData;
  final int serviceLocationType;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorRes.smokeWhite,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: serviceLocationType != -1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: ColorRes.themeColor,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 20,
              ),
              child: Text(
                serviceLocationType == 0 ? 'At Salon' : 'Other Location',
                style: kLightWhiteTextStyle.copyWith(
                  color: ColorRes.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Visibility(
            visible: serviceLocationType == 1 || serviceLocationType == -1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          ((addressData?.name ?? '')).length > 19
                              ? Expanded(
                                  child: Text(
                                    (addressData?.name ?? ''),
                                    style: kMediumThemeTextStyle.copyWith(
                                      fontSize: 17,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              : Text(
                                  (addressData?.name ?? ''),
                                  style: kMediumThemeTextStyle.copyWith(
                                    fontSize: 17,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: ColorRes.lavender,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: ColorRes.themeColor,
                                width: .75,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 2,
                            ),
                            child: Text(
                              AppRes.getAddressTypeInStringFromNumber(
                                addressData?.type?.toInt() ?? 0,
                              ),
                              style: kMediumThemeTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          CustomCircularInkWell(
                            onTap: () async {
                              String iosUrl =
                                  'https://maps.apple.com/?q=${addressData?.latitude},${addressData?.longitude}';
                              if (Platform.isAndroid) {
                                String googleUrl =
                                    'https://www.google.com/maps/search/?api=1&query=${addressData?.latitude},${addressData?.longitude}';
                                if (await canLaunchUrl(Uri.parse(googleUrl))) {
                                  await launchUrl(Uri.parse(googleUrl));
                                } else {
                                  throw 'Could not launch $googleUrl';
                                }
                              } else {
                                if (await canLaunchUrl(Uri.parse(iosUrl))) {
                                  await launchUrl(Uri.parse(iosUrl));
                                } else {
                                  throw 'Could not open the map.';
                                }
                              }
                            },
                            child: Image.asset(
                              AssetRes.icNavigator2,
                              height: 30,
                              width: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  addressData?.mobile ?? '',
                  style: kMediumThemeTextStyle.copyWith(
                    color: ColorRes.empress,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    addressData?.address ?? '',
                    style: kLightWhiteTextStyle.copyWith(
                      color: ColorRes.empress,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

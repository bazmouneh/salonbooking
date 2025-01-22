import 'package:cutfx_salon/utils/asset_res.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/style_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class AppLogo extends StatelessWidget {
  final Color? textColor;
  final double? textSize;

  const AppLogo({
    super.key,
    this.textColor,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          AppLocalizations.of(context)!.appName.toUpperCase(),
          style: TextStyle(
            color: textColor ?? ColorRes.white,
            fontFamily: AssetRes.fnGilroyBlack,
            fontSize: textSize ?? 22,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          AppLocalizations.of(context)!.salon.toUpperCase(),
          style: TextStyle(
            color: textColor ?? ColorRes.white,
            fontFamily: AssetRes.fnGilroyLight,
            fontSize: textSize ?? 22,
          ),
        ),
      ],
    );
  }
}

class TextWithTextFieldWidget extends StatelessWidget {
  final String title;
  final bool? isPassword;
  final TextEditingController controller;

  const TextWithTextFieldWidget({
    super.key,
    required this.title,
    this.isPassword,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kRegularWhiteTextStyle,
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorRes.white.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: ColorRes.smokeWhite,
              width: 0.5,
            ),
          ),
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(border: InputBorder.none),
            style: kRegularWhiteTextStyle.copyWith(),
            textCapitalization: TextCapitalization.sentences,
            obscureText: isPassword ?? false,
            enableSuggestions: isPassword != null ? !isPassword! : true,
            autocorrect: isPassword != null ? !isPassword! : true,
          ),
        ),
      ],
    );
  }
}

class TextWithTextFieldSmokeWhiteWidget extends StatelessWidget {
  final String title;
  final bool? isPassword;
  final TextEditingController? controller;
  final TextInputType? textInputType;

  const TextWithTextFieldSmokeWhiteWidget({
    super.key,
    required this.title,
    this.isPassword,
    this.controller,
    this.textInputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title.isEmpty
            ? const SizedBox()
            : Text(
                title,
                style: kLightWhiteTextStyle.copyWith(
                  color: ColorRes.black,
                  fontSize: 16,
                ),
              ),
        Container(
          decoration: BoxDecoration(
            color: ColorRes.smokeWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: ColorRes.smokeWhite,
              width: 0.5,
            ),
          ),
          height: 55,
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            style: kRegularTextStyle.copyWith(
              fontSize: 15,
              color: ColorRes.charcoal50,
            ),
            keyboardType: textInputType,
            textCapitalization: TextCapitalization.sentences,
            obscureText: isPassword ?? false,
            enableSuggestions: isPassword != null ? !isPassword! : true,
            autocorrect: isPassword != null ? !isPassword! : true,
          ),
        ),
      ],
    );
  }
}

class OpenClosedStatusWidget extends StatelessWidget {
  final Color? bgDisable;
  final bool salonIsOpen;

  const OpenClosedStatusWidget({
    super.key,
    this.bgDisable,
    required this.salonIsOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: salonIsOpen
            ? ColorRes.themeColor
            : bgDisable ?? ColorRes.smokeWhite,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      child: Text(
        (salonIsOpen
                ? AppLocalizations.of(context)!.open
                : AppLocalizations.of(context)!.closed)
            .toUpperCase(),
        style: kLightWhiteTextStyle.copyWith(
          color: salonIsOpen ? ColorRes.white : ColorRes.empress,
          fontSize: 12,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class TitleWithSeeAllWidget extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const TitleWithSeeAllWidget({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text(
            title,
            style: kSemiBoldTextStyle,
          ),
          const Spacer(),
          CustomCircularInkWell(
            onTap: onTap,
            child: Text(
              AppLocalizations.of(context)!.seeAll,
              style: kRegularEmpressTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCircularInkWell extends StatelessWidget {
  final Widget? child;
  final Function()? onTap;

  const CustomCircularInkWell({super.key, this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: WidgetStateProperty.all(ColorRes.transparent),
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: child,
    );
  }
}

class ToolBarWidget extends StatelessWidget {
  final String title;

  const ToolBarWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Image(
                  image: AssetImage(AssetRes.icBack),
                  color: ColorRes.themeColor,
                  height: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                title,
                style: kBoldThemeTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleButton extends StatefulWidget {
  final Function(bool isActive)? onToggleChange;
  final bool? isActive;

  const ToggleButton({super.key, this.onToggleChange, this.isActive});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool buttonIsActive = false;

  @override
  void initState() {
    buttonIsActive = widget.isActive ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: CupertinoSwitch(
        value: buttonIsActive,
        activeTrackColor: ColorRes.themeColor,
        onChanged: (value) {
          buttonIsActive = value;
          widget.onToggleChange?.call(buttonIsActive);
          setState(() {});
        },
      ),
    );
  }
}

class CloseButtonWidget extends StatelessWidget {
  final Function()? onTap;

  const CloseButtonWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCircularInkWell(
      onTap: () {
        onTap?.call();
        Get.back();
      },
      child: Container(
        height: 35,
        width: 35,
        decoration: const BoxDecoration(
          color: ColorRes.lavender,
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        padding: const EdgeInsets.all(5),
        child: const Icon(
          Icons.close_rounded,
          color: ColorRes.themeColor,
        ),
      ),
    );
  }
}

class ImageNotFound extends StatelessWidget {
  final Color? color;

  const ImageNotFound({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? ColorRes.smokeWhite,
      child: Center(
        child: Text(
          ':-('.toUpperCase(),
          style: kBoldThemeTextStyle.copyWith(
            color: ColorRes.smokeWhite1,
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}

Widget loadingImage(context, child, loadingProgress) {
  if (loadingProgress == null) {
    return child;
  }
  return const LoadingImage();
}

class ImageNotFoundOval extends StatelessWidget {
  final Color? color;
  final Color? tintcolor;
  final double? fontSize;

  const ImageNotFoundOval({
    super.key,
    this.color,
    this.tintcolor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: color ?? ColorRes.smokeWhite,
        child: Center(
          child: Text(
            ':-('.toUpperCase(),
            style: kBoldThemeTextStyle.copyWith(
              color: tintcolor ?? ColorRes.smokeWhite1,
              fontSize: fontSize ?? 50,
            ),
          ),
        ),
      ),
    );
  }
}

Widget errorBuilderForImage(context, error, stackTrace) {
  return const LoadingImage();
}

Widget loadingImageForCircle(context, child, loadingProgress) {
  if (loadingProgress == null) {
    return child;
  }
  return const LoadingImage(
    fontSize: 20,
  );
}

Widget errorBuilderForCircleImage(context, error, stackTrace) {
  return const LoadingImage(
    fontSize: 20,
  );
}

class LoadingImage extends StatelessWidget {
  final Color? color;
  final double? fontSize;

  const LoadingImage({super.key, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Container(
        color: color ?? ColorRes.smokeWhite1.withOpacity(.5),
        child: Center(
          child: Text(
            '● ● ●'.toUpperCase(),
            style: kBoldThemeTextStyle.copyWith(
              color: ColorRes.charcoal50.withOpacity(.2),
              fontSize: fontSize ?? 30,
              letterSpacing: -2,
            ),
          ),
        ),
      ),
    );
  }
}

class DataNotFound extends StatelessWidget {
  const DataNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(AssetRes.icNoData),
          height: 275,
        )
        // Text(
        //   ':-('.toUpperCase(),
        //   style: kBoldThemeTextStyle.copyWith(
        //     color: ColorRes.smokeWhite1,
        //     fontSize: 50,
        //   ),
        // ),
      ],
    );
  }
}

class LoadingData extends StatelessWidget {
  final Color? color;

  const LoadingData({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? ColorRes.smokeWhite,
      child: const Center(
        child: CircularProgressIndicator(
          color: ColorRes.themeColor,
        ),
      ),
    );
  }
}

class CustomMenuWidget extends StatefulWidget {
  const CustomMenuWidget({super.key, required this.onMenuClick});

  final Function(int position) onMenuClick;

  @override
  State<CustomMenuWidget> createState() => _CustomMenuWidgetState();
}

class _CustomMenuWidgetState extends State<CustomMenuWidget> {
  final MenuController menuController = MenuController();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: [
        CustomCircularInkWell(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: ColorRes.smokeWhite,
                ),
              ),
            ),
            padding:
                const EdgeInsets.only(bottom: 5, top: 0, left: 10, right: 10),
            child: Text(
              AppLocalizations.of(context)!.edit,
              style: kMediumTextStyle.copyWith(
                fontSize: 14,
                color: ColorRes.mortar,
              ),
            ),
          ),
          onTap: () {
            widget.onMenuClick(0);
            menuController.close();
          },
        ),
        CustomCircularInkWell(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: ColorRes.smokeWhite,
                ),
              ),
            ),
            padding:
                const EdgeInsets.only(bottom: 7, top: 7, left: 10, right: 10),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.orderHistory,
                style: kMediumTextStyle.copyWith(
                  fontSize: 14,
                  color: ColorRes.mortar,
                ),
              ),
            ),
          ),
          onTap: () {
            widget.onMenuClick(1);
            menuController.close();
          },
        ),
        CustomCircularInkWell(
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.only(bottom: 0, top: 5, left: 10, right: 10),
              child: Text(
                AppLocalizations.of(context)!.delete,
                style: kMediumTextStyle.copyWith(
                  fontSize: 14,
                  color: ColorRes.mortar,
                ),
              ),
            ),
            onTap: () {
              widget.onMenuClick(2);
              menuController.close();
            }),
      ],
      controller: menuController,
      builder: (context, controller, child) {
        return CustomCircularInkWell(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            height: 30,
            alignment: Alignment.bottomRight,
            child: const Icon(
              Icons.more_horiz,
              size: 35,
              color: ColorRes.empress,
            ),
          ),
        );
      },
    );
  }
}

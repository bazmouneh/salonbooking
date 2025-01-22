import 'dart:io';

import 'package:cutfx_salon/model/staff/staff.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:cutfx_salon/utils/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

part 'add_staff_event.dart';
part 'add_staff_state.dart';

class AddStaffBloc extends Bloc<AddStaffEvent, AddStaffState> {
  StaffData? staffData = Get.arguments;
  File? imageFile;
  String? imageUrl;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  int genderType = 0;

  AddStaffBloc() : super(AddStaffInitial()) {
    on<AddStaffEvent>((event, emit) {});
    on<ImageSelectClickEvent>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      final XFile? image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
      imageFile = image != null ? File(image.path) : null;
      add(FetchUserProfileEvent());
    });
    on<FetchUserProfileEvent>((event, emit) async {
      imageUrl = staffData?.photo ?? '';
      nameController.text = staffData?.name ?? '';
      mobileNumberController.text = staffData?.phone ?? '';
      genderType = staffData?.gender?.toInt() ?? 0;
      emit(StaffDataFoundState(staffData));
    });
    add(FetchUserProfileEvent());
  }

  void onTapSubmit() async {
    if ((imageUrl == null || imageUrl?.isEmpty == true) && imageFile == null) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseSelectImage, false);
      return;
    }
    if (nameController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseEnterName, false);
      return;
    }
    if (mobileNumberController.text.isEmpty) {
      AppRes.showSnackBar(
          AppLocalizations.of(Get.context!)!.pleaseEnterMobileNumber, false);
      return;
    }
    AppRes.showCustomLoader();
    if (staffData != null) {
      await ApiService().editStaff(
        staffId: staffData?.id?.toInt(),
        name: nameController.text,
        phone: mobileNumberController.text,
        gender: genderType,
        staffProfileImage: imageFile,
      );
    } else {
      await ApiService().addStaffToSalon(
        name: nameController.text,
        phone: mobileNumberController.text,
        gender: genderType,
        staffProfileImage: imageFile,
      );
    }
    AppRes.hideCustomLoaderWithBack();
  }
}

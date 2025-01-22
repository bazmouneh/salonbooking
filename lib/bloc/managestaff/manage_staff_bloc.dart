import 'package:cutfx_salon/model/staff/staff.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_staff_event.dart';
part 'manage_staff_state.dart';

class ManageStaffBloc extends Bloc<ManageStaffEvent, ManageStaffState> {
  ManageStaffBloc() : super(ManageStaffInitial()) {
    on<FetchManageStaffEvent>((event, emit) {
      emit(FetchStaffState());
    });
    fetchStaff();
  }

  Staff? staff;

  void fetchStaff() async {
    staff = await ApiService().fetchAllStaffOfSalon();
    add(FetchManageStaffEvent());
  }
}

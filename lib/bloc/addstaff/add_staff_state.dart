part of 'add_staff_bloc.dart';

class AddStaffState {}

class AddStaffInitial extends AddStaffState {}

class StaffDataFoundState extends AddStaffState {
  final StaffData? staffData;

  StaffDataFoundState(this.staffData);
}

import 'package:cutfx_salon/model/bookings/booking.dart';
import 'package:cutfx_salon/model/staff/staff.dart';
import 'package:cutfx_salon/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'staff_order_history_event.dart';
part 'staff_order_history_state.dart';

class StaffOrderHistoryBloc
    extends Bloc<StaffOrderHistoryEvent, StaffOrderHistoryState> {
  StaffOrderHistoryBloc() : super(StaffOrderHistoryInitial()) {
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          !isFetching) {
        add(FetchOrderHistoryEvent());
      }
    });
    on<FetchOrderHistoryEvent>((event, emit) async {
      Booking booking = await ApiService().fetchBookingsByStaff(
        start: bookings.length,
        staffId: staffData?.id?.toInt() ?? -1,
      );
      bookings.addAll(booking.data ?? []);
      // bookings.sort(
      //   (a, b) {
      //     return a.status!.compareTo(b.status!);
      //   },
      // );
      emit(OrderHistoryDataFoundState());
    });
    add(FetchOrderHistoryEvent());
  }

  StaffData? staffData = Get.arguments;
  ScrollController scrollController = ScrollController();
  bool isFetching = false;
  int count = 0;
  List<BookingData> bookings = [];
}

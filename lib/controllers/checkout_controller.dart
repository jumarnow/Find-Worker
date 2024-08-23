import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/config/app_info.dart';
import 'package:myapp/datasources/booking_datasource.dart';
import 'package:myapp/models/booking_model.dart';

class CheckoutController extends GetxController {
  clear() {
    Get.delete<CheckoutController>(force: true);
  }

  final List<Map<String, dynamic>> payments = [
    {
      'image': 'assets/ic_wallet_payment.png',
      'name': 'Wallet',
      'is_active': true,
    },
    {
      'image': 'assets/ic_master_card.png',
      'name': 'CC',
      'is_active': false,
    },
    {
      'image': 'assets/ic_paypal.png',
      'name': 'Paypal',
      'is_active': false,
    },
    {
      'image': 'assets/ic_other.png',
      'name': 'Other',
      'is_active': false,
    }
  ];

  final _loading = false.obs;
  bool get loading => _loading.value;

  set loading(bool n) => _loading.value = n;

  excute(BuildContext context, BookingModel bookingDetail) {
    loading = true;
    BookingDatasource.checkout(bookingDetail).then((value) {
      loading = false;
      value.fold((message) => AppInfo.failed(context, message), (data) {
        AppInfo.success(context, 'Booking Success');
      });
    });
  }
}

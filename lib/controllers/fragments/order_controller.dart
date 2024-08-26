import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/config/app_info.dart';
import 'package:myapp/datasources/booking_datasource.dart';
import 'package:myapp/models/booking_model.dart';

class OrderController extends GetxController {
  clear() {
    Get.delete<OrderController>(force: true);
  }

  final _selected = 'In Progress'.obs;
  String get selected => _selected.value;
  set selected(String n) => _selected.value = n;

  final _inProgress = <BookingModel>[].obs;
  List<BookingModel> get inProgress => _inProgress;

  final _completed = <BookingModel>[].obs;
  List<BookingModel> get completed => _completed;

  final _statusInProgress = ''.obs;
  String get statusInProgress => _statusInProgress.value;
  set statusInProgress(String n) => _statusInProgress.value = n;

  final _statusCompleted = ''.obs;
  String get statusCompleted => _statusCompleted.value;
  set statusCompleted(String n) => _statusCompleted.value = n;

  ini(String userId) {
    fetchInProgress(userId);
    fetchCompleted(userId);
  }

  fetchInProgress(String userId) {
    statusInProgress = 'Loading';
    BookingDatasource.fetchOrder(userId, 'In Progress').then((value) {
      value.fold((message) => statusInProgress = message, (data) {
        statusInProgress = 'Success';
        _inProgress.value = data;
      });
    });
  }

  fetchCompleted(String userId) {
    statusCompleted = 'Loading';
    BookingDatasource.fetchOrder(userId, 'Completed').then((value) {
      value.fold((message) => statusCompleted = message, (data) {
        statusCompleted = 'Success';
        _completed.value = data;
      });
    });
  }

  setCompleted(
    BuildContext context,
    String bookingId,
    String workerId,
    String userId,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Set Completed',
              style: TextStyle(color: Colors.black)),
          content: const Text(
              'You want to set this worker has finished the job?',
              style: TextStyle(color: Colors.black)),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    ).then((yes) {
      if (yes ?? false) {
        BookingDatasource.setCompleted(bookingId, workerId).then((value) {
          value.fold((message) {
            AppInfo.failed(context, message);
          }, (data) {
            AppInfo.toastSucces('Worker has been set completed');
            ini(userId);
          });
        });
      }
    });
  }
}

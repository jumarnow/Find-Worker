import 'package:get/get.dart';
import 'package:myapp/datasources/booking_datasource.dart';

class WorkerProfileController extends GetxController {
  clear() {
    Get.delete<WorkerProfileController>(force: true);
  }

  final _recruiterId = ''.obs;
  String get recruiterId => _recruiterId.value;
  set recruiterId(String n) => _recruiterId.value = n;

  checkHiredBy(String workerId) {
    BookingDatasource.checkHireBy(workerId).then((value) {
      value.fold((message) => recruiterId = 'Available', (booking) {
        recruiterId = booking.userId;
      });
    });
  }
}

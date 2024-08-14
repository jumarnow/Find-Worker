import 'package:d_session/d_session.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/user_controller.dart';
import 'package:myapp/models/user_model.dart';

class AppSession {
  static Future<bool> setUser(Map user) async {
    bool success = await DSession.setUser(user);

    if (success) {
      final userController = Get.put(UserController());
      userController.data = UserModel.fromJson(Map.from(user));
    }

    return success;
  }

  static Future<Map?> getUser() async {
    Map? mapUser = await DSession.getUser();

    if (mapUser != null) {
      final userController = Get.put(UserController());
      userController.data = UserModel.fromJson(Map.from(mapUser));
    }

    return mapUser;
  }

  static Future<bool> removeUser(Map user) async {
    bool success = await DSession.removeUser();

    if (success) {
      final userController = Get.put(UserController());
      userController.data = UserModel();
    }

    return success;
  }
}

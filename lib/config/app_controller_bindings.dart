

import 'package:get/get.dart';
import 'package:user_info/controller/profile_controller.dart';

class AppControllerBindings extends Bindings{
  @override
  void dependencies() {
Get.put(ProfileController());

  }
}
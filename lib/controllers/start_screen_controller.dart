import 'package:get/get.dart';
import 'package:rapid_medical_info_system/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartController extends GetxController{

  var isLoading = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLoading(true);
    SharedPreferences.getInstance().then((value) {
      isLoading(false);
      if (value.containsKey("logged") && value.getBool("logged")!) {
        Get.off(()=> HomeScreen(source: value.getString('type'),));
      }
    });
  }
}
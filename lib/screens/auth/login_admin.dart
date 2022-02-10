import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/controllers/loginController.dart';
import 'package:rapid_medical_info_system/widgets/authTextField.dart';
import 'package:rapid_medical_info_system/widgets/background.dart';
import 'register_med_stuff.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        source: 'A',
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: controller.loginMedKey.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/admin.png'),
                const Text(
                  "Hajj Health Admin",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 36),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  "Mobile App",
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, letterSpacing: 2),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: AuthTextField(
                    keyboardType: TextInputType.emailAddress,
                      controller: controller.emailController,
                      labelText: "Enter Email"),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: AuthTextField(
                    controller: controller.passwordController,
                    labelText: "Enter Password",
                    obscureText: true,
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: loginButton(size),
                ),
                // Container(
                //   alignment: Alignment.center,
                //   margin: EdgeInsets.symmetric(vertical: 10),
                //   child: GestureDetector(
                //       onTap: () => {Get.off(() => AdminRegisterScreen())},
                //       child: Column(
                //         children: const [
                //           Text(
                //             "Don't Have an Account? ",
                //             style: TextStyle(
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.white),
                //           ),
                //           Text(
                //             "Sign up",
                //             style: TextStyle(
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.white70),
                //           ),
                //         ],
                //       )),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginButton(size) {
    return ElevatedButton(
      onPressed: () {
        if (!controller.isLoading.value) {
          if (controller.loginMedKey.value.currentState!.validate()) {
            controller.logInAdmin(context);
          }
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black54),
          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
          textStyle: MaterialStateProperty.all(const TextStyle(
            color: Colors.white,
          ))),
      child: Container(
        alignment: Alignment.center,
        height: 50.0,
        width: size.width * 0.3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.black54),
        padding: const EdgeInsets.all(0),
        child: Obx(() => controller.isLoading.value
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text(
                "LOGIN",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )),
      ),
    );
  }
}

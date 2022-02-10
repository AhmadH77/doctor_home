import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';
import 'package:rapid_medical_info_system/controllers/signupController.dart';
import 'package:rapid_medical_info_system/screens/auth/login_med_stuff.dart';
import 'package:rapid_medical_info_system/widgets/authTextField.dart';
import 'package:rapid_medical_info_system/widgets/background.dart';

class MedStuffRegisterScreen extends StatefulWidget {
  @override
  State<MedStuffRegisterScreen> createState() => _MedStuffRegisterScreenState();
}

class _MedStuffRegisterScreenState extends State<MedStuffRegisterScreen> {
  SignupController controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        source: 'M',
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: controller.registerMedKey.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/login.png'),
                const Text(
                  "Hajj Health",
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

                form(size),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: loginButton(size),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                      onTap: () => {Get.off(() => MedStuffLoginScreen())},
                      child: Column(
                        children: const [
                          Text(
                            "Already have an Account? ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white54),
                          ),
                          Text(
                            "Log in",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white54),
                          ),
                        ],
                      )),
                )
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
          if (controller.registerMedKey.value.currentState!.validate()) {
            controller.signUpMed(context);
          }
        }
      },
      style: ButtonStyle(
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
            color: Constants.dark_teal),
        padding: const EdgeInsets.all(0),
        child: Obx(() => controller.isLoading.value
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text(
                "Register",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )),
      ),
    );
  }

  form(size) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: AuthTextField(
              controller: controller.idController,
              labelText: "Enter National ID"),
        ),
        SizedBox(height: size.height * 0.03),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: AuthTextField(
            keyboardType: TextInputType.phone,
            controller: controller.phoneController,
            labelText: "Enter Phone",
          ),
        ),
        SizedBox(height: size.height * 0.03),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: AuthTextField(
            controller: controller.nameController,
            labelText: "Enter Name",
          ),
        ),
        SizedBox(height: size.height * 0.03),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: AuthTextField(
            keyboardType: TextInputType.emailAddress,
            controller: controller.emailController,
            labelText: "Enter Email",
          ),
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
      ],
    );
  }
}

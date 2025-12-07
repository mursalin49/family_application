
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable loading state
  var isLoading = false.obs;

  void signIn() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please enter email and password");
      return;
    }

    isLoading.value = true;

    // Simulate API call delay
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      debugPrint("Sign In pressed");
      debugPrint("Email: ${emailController.text}");
      debugPrint("Password: ${passwordController.text}");

      // Navigate to Home or Notes
      Get.offNamed("/notes_screen");
    });
  }

  void createAccount() {
    debugPrint("Create Account pressed");
    Get.toNamed("/create_account");
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

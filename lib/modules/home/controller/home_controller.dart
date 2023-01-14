import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:internship_task/modules/home/model/user_model.dart';
import 'package:internship_task/modules/user_profile/model/my_user.dart';

class HomeController extends GetxController {
  RxList users = [].obs;
  Rx<List> myUsers = Rx<List>([]);
  Rx<bool> isLoading = false.obs;
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  @override
  void onInit() async {
    await loadMyUserFromHive();
    await loadUserFromJson();
    super.onInit();
  }

  Future<void> loadUserFromJson() async {
    isLoading.value = true;
    final jsonData = await rootBundle.loadString('assets/response.json');
    final List data = json.decode(jsonData) as List;
    final Map<String, dynamic> userResponse = data[0] as Map<String, dynamic>;
    users.assignAll(userResponse['users'].map((e) => ApiResponse.fromMap(e)));
    isLoading.value = false;
  }

  Future<void> loadMyUserFromHive() async {
    final box = await Hive.openBox<MyUserModel>('myUser');
    myUsers.value.assignAll(box.values);
    box.close();
  }

  Future<void> signIn(
    MyUserModel myUserModel,
  ) async {
    isLoading.value = true;
    final box = await Hive.openBox<MyUserModel>('myUser');
    box.put(myUserModel.id, myUserModel);
    myUsers.value.add(myUserModel);
    isLoading.value = false;
    Get.snackbar('Sign In', 'You have successfully signed in');
    box.close();
  }

  Future<void> signOut(
    String id,
  ) async {
    isLoading.value = true;
    final box = await Hive.openBox<MyUserModel>('myUser');
    box.delete(id);
    myUsers.value.removeWhere((element) => element.id == id);
    isLoading.value = false;
    Get.snackbar('Sign Out', 'You have successfully signed out');
    box.close();
  }
}

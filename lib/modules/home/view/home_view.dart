import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internship_task/modules/home/model/user_model.dart';
import 'package:internship_task/modules/user_profile/view/user_profile.dart';

import '../../user_profile/model/my_user.dart';
import '../controller/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Users'),
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: controller.users.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final ApiResponse user = controller.users[index];

                    bool isSignedIn(String id) {
                      return controller.myUsers.value
                          .any((element) => element.id == id);
                    }

                    return ListTile(
                        onTap: () {
                          if (isSignedIn(user.id)) {
                            Get.to(UserProfileView(
                                myUserModel: controller.myUsers.value
                                    .firstWhere(
                                        (element) => element.id == user.id)));
                          }
                        },
                        leading: CircleAvatar(
                          child: Text(user.id),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.atype),
                        trailing: Obx(
                          () => ElevatedButton(
                              onPressed: () {
                                if (isSignedIn(user.id)) {
                                  controller.signOut(user.id);
                                } else {
                                  Get.defaultDialog(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    title: 'Sign In',
                                    middleText:
                                        'Are you sure you want to sign in?',
                                    textConfirm: 'Yes',
                                    textCancel: 'No',
                                    confirmTextColor: Colors.white,
                                    content: Column(
                                      children: [
                                        TextFormField(
                                          controller: controller.ageController,
                                          decoration: const InputDecoration(
                                              hintText: 'Enter your age'),
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          controller:
                                              controller.genderController,
                                          decoration: const InputDecoration(
                                              hintText: 'Enter your gender'),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                    onConfirm: () {
                                      controller.signIn(MyUserModel(
                                          id: user.id,
                                          name: user.name,
                                          atype: user.atype,
                                          age: controller.ageController.text,
                                          gender: controller
                                              .genderController.text));
                                      Get.back();
                                    },
                                  );
                                }
                              },
                              child: isSignedIn(user.id)
                                  ? const Text('Sign Out')
                                  : const Text('Sign In')),
                        ));
                  },
                ),
        ));
  }
}

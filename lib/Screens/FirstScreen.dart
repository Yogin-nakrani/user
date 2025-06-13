import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_info/Screens/secondScreen.dart';
import 'package:user_info/Utils/WidgetScreen.dart';
import 'package:user_info/Utils/app_String.dart';
import 'package:user_info/Utils/app_colors.dart';
import 'package:user_info/Utils/getController.dart';
import 'package:get/get.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ToDoController controller = Get.put(ToDoController());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  final GlobalKey<ImagePickFromGalleryState> imageKey = GlobalKey();

  File? selectedImage;
  List<XFile?> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().appbarBG,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: () {
                Get.to(() => Secondscreen());
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(AppString().imgUrl),
              ),
            ),
          )
        ],
        title: AllWidgets().title("User Info get from user's device"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [


                ///textfields
                AllWidgets().txtField(nameController, "Your Name",
                    validator: controller.nameValidator),
                AllWidgets().txtField(emailController, "Your Email",
                    validator: controller.emailValidator),
                AllWidgets().txtField(ageController, "Your Age",
                    validator: controller.ageValidator),
                SizedBox(
                  height: 20,
                ),

                /// image picker stf function called
                ImagePickFromGallery(
                  key: imageKey,
                  onImagePicked: (img) {
                    setState(() {
                      selectedImage = img;
                    });
                  },
                  onMLTImagePicked: (imglist) {
                    setState(() {
                      images = imglist;
                    });
                  },
                ),

                ///submit  btn

                ElevatedButton(
                    onPressed: () {
                      final form = controller.formKey.currentState;

                      if (form != null && form.validate()) {
                        controller.addtask(
                            nameController.text,
                            emailController.text,
                            ageController.text,
                            selectedImage!.path,
                            images);

                        nameController.clear();
                        emailController.clear();
                        ageController.clear();
                        setState(() {
                          selectedImage = null;
                          images.clear();
                        });

                        imageKey.currentState?.clearImg();
                      }
                    },
                    child: AllWidgets().title("Submit"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

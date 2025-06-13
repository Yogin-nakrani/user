import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_info/Utils/app_colors.dart';
import 'dart:io';
import 'package:user_info/Utils/widgetScreen.dart';
import 'package:user_info/Utils/getController.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final ToDoController controller = Get.find();

  ImagePicker _pickImage = ImagePicker();

  List<String> _images = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  File? _selectedImage;
  late int index;

  @override
  void initState() {
    super.initState();
    index = Get.arguments as int;

    // Prefill the fields with existing task data
    final task = controller.tasks[index];
    nameController.text = task.name;
    emailController.text = task.email;
    ageController.text = task.age;
    _images = List<String>.from(task.imageList);
  }

  _pickImageFromGallery() async {
    final image = await _pickImage.pickImage(source: ImageSource.gallery);

    if (image?.path.isNotEmpty ?? false) {
      setState(() {
        _selectedImage = File(image?.path ?? "");

        print('NewImage Path: ${_selectedImage!.path}');
      });
    }
  }

  _mltImageFromGallary() async {
    List<XFile?> mltImage = await _pickImage.pickMultiImage();
    setState(() {
      _images.addAll(mltImage.whereType<XFile>().map((e) => e.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = controller.tasks;

    return Scaffold(
        appBar: AppBar(
          title: AllWidgets().title("Edit Screen"),
          backgroundColor: AppColors().appbarBG,
        ),
        body: Form(
          key: controller.updateformKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AllWidgets().txtField(nameController, "your name"),
                AllWidgets().txtField(emailController, "your email"),
                AllWidgets().txtField(ageController, "your age"),
                SizedBox(height: 20,),
                SizedBox(
                  height: 150,
                  child: ClipRRect(borderRadius: BorderRadius.circular(8),
                    child: _selectedImage != null
                      ? Image.file(_selectedImage!,fit: BoxFit.cover,)
                      : Image.file(File(controller.tasks[index].image,),fit: BoxFit.cover,),
                  )
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await _pickImageFromGallery();
                    },
                    child: Text("Upload New Image")),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.isEmpty
                          ? controller.tasks[index].imageList.length
                          : _images.length,
                      itemBuilder: (context, imgIndex) {
                        final imagePath = _images.isEmpty
                            ? controller.tasks[index].imageList[imgIndex]
                            : _images[imgIndex];

                        return Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: _images.isEmpty
                              ? SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.file(
                                            File(imagePath),
                                            fit: BoxFit.cover,
                                            height: 200,
                                            width: 200,
                                          )),
                                      Positioned(
                                          top: 10,
                                          right: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (_images.isEmpty) {
                                                      controller.tasks[index]
                                                          .imageList
                                                          .removeAt(imgIndex);
                                                    } else {
                                                      _images
                                                          .removeAt(imgIndex);
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                )),
                                          ))
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Stack(
                                    children: [
                                      
                                      ClipRRect(borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (_images.isEmpty) {
                                                      controller.tasks[index]
                                                          .imageList
                                                          .removeAt(imgIndex);
                                                    } else {
                                                      _images
                                                          .removeAt(imgIndex);
                                                    }
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                )),
                                          ))

                                  
                                  ],
                                  )),
                        );
                      }),
                ),
                ElevatedButton(
                    onPressed: () {
                      _mltImageFromGallary();
                    },
                    child: Text("Mlt Image")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///cancel btn
                    AllWidgets().btn(() {
                      Get.back();
                    }, "cancel"),
                    SizedBox(
                      width: 20,
                    ),

                    ///Submit Btn
                    AllWidgets().btn(() {
                      final form = controller.updateformKey.currentState;
                      if (form != null && form.validate()) {
                        controller.updateTask(
                            index,
                            nameController.text,
                            emailController.text,
                            ageController.text,
                            _selectedImage?.path ??
                                controller.tasks[index].image,
                            _images);
                        nameController.clear();
                        emailController.clear();
                        ageController.clear();
                        Get.back();
                      }
                    }, "Submit")
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

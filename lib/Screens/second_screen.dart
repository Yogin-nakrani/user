import 'dart:io';
import 'package:user_info/Screens/imagescreen.dart';

import 'package:flutter/material.dart';
import 'package:user_info/Screens/update_screen.dart';
import 'package:user_info/Utils/get_controller.dart';
import 'package:user_info/Utils/widget_screen.dart';

import 'package:get/get.dart';

class Secondscreen extends StatefulWidget {
  const Secondscreen({super.key});

  @override
  State<Secondscreen> createState() => _SecondscreenState();
}

class _SecondscreenState extends State<Secondscreen> {
  // This comes from Get.put(ToDoController())

    final ToDoController controller = Get.find();


 
  








  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();





  @override
  Widget build(BuildContext context) {
    final tasks = controller.tasks;

    return Scaffold(
      appBar: AppBar(
        title: AllWidgets().title("Information Preview"),
        centerTitle: true,
      ),
      body: SizedBox(
          child: Obx(
        () => ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return Padding(
                  padding:
                      index == 0 ? EdgeInsets.all(0) : EdgeInsets.only(top: 10),
                  child: ListTile(
                      onTap: () {
                        Get.to(() => Imagescreen(), arguments: tasks[index]);
                      },
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(task.image)),
                      ),
                      title: Text(task.name),
                      subtitle: Text(task.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Age:${task.age}"),

                          ///edit icon
                          AllWidgets().iconBtn(Icons.edit, () {
                            // nameController.text = task.name;
                            // emailController.text = task.email;
                            // ageController.text = task.age;
                            Get.to(()=> UpdateScreen(),arguments: index);
                          }),

                          ///delete icon
                          AllWidgets().iconBtn(Icons.delete, () {
                            controller.deleteTask(index);
                          })
                        ],
                      )));
            }),
      )),
    );
  }
}

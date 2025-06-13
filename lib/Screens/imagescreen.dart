import 'dart:io';
import 'package:flutter/material.dart';
import 'package:user_info/Screens/fullscreen.dart';
import 'package:user_info/Utils/get_controller.dart';
import 'package:get/get.dart';



class Imagescreen extends StatelessWidget {
   Imagescreen({super.key});
  final Task tasks =Get.arguments;

  @override
  Widget build(BuildContext context) {

    // final List<String> allImages = tasks.expand((task) => task.imageList).toList();


    return Scaffold(

appBar: AppBar(title: Text("Image Preview"),),

      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 8,crossAxisSpacing: 8), 
      itemCount: tasks.imageList.length,
      
      itemBuilder: (context,index){
       

   final String imagePath = tasks.imageList[index];

          

        return GestureDetector(
          onTap: (){
            Get.to(()=> Fullscreen(imagepath: imagePath));
          },
          child: Center(
            child: 
           Image.file(File(imagePath),fit: BoxFit.cover,) 
                    
                    
          ),
        );


      }),
    );
  }
}
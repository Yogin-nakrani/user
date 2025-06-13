import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_info/controller/profile_controller.dart';

class GetXDemoScreenState extends StatefulWidget {
  const GetXDemoScreenState({super.key});

  @override
  State<GetXDemoScreenState> createState() => _GetXDemoScreenStateState();
}

class _GetXDemoScreenStateState extends State<GetXDemoScreenState> {
ProfileController profileControllerFind = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

GetBuilder<ProfileController>(builder: (controller) {
  
  return Text(controller.a.toString(),style: TextStyle(color: Colors.black),);
},),

Obx(() {
  
  return InkWell(
  onTap: (){
    profileControllerFind.value++;
profileControllerFind.myStringData.value ="ljlsdjfds";
    
  }
  ,child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(profileControllerFind.value.toString()),
  ));
},),


        ],
      ),
    );
  }
}
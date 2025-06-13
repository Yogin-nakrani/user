
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Task{
  String name;
  String email;
 String age;
 String image;
 List<String> imageList;

  

Task({required this.name,required this.email,required this.age,required this.image, required this.imageList});

//converting into json from model
Map<String , dynamic>tojson(){
  return{
    'name' : name,
    'email': email,
    'age': age,
    'image': image,
    'imageList': imageList
  };

}

//convering into model from json
  factory Task.fromJson(Map<String , dynamic> json){
    return Task(name: json['name'], 
    email: json['email'], 
    age: json['age'], 
    image: json['image'], 
    imageList: List<String>.from(json['imageList']));
  }




}


class ToDoController extends GetxController{

  
///storing data in preferences
Future<void> saveTasktoPref()async{
final pref =  await SharedPreferences.getInstance();
List<String> taskJsonList = tasks.map((task)=> jsonEncode(task.tojson())).toList();
await pref.setStringList("TaskList", taskJsonList);
}

///loading data from preferences
Future<void> loadTaskFromPref()async{
  final pref = await SharedPreferences.getInstance();
  List<String>? taskJsonList = pref.getStringList("TaskList");

  if(taskJsonList != null){

    tasks.value= taskJsonList.map((task)=> Task.fromJson(jsonDecode(task))).toList();
  }

}

@override
void onInit() {
  super.onInit();
  loadTaskFromPref(); // load saved tasks when the app starts
}



final formKey = GlobalKey<FormState>();
final updateformKey = GlobalKey<FormState>();

  RxString email = " ".obs;

String? nameValidator (String? name){

  if(name!.length<3){

    return "name atleast contain 4 character";
  }
  return null;
}


  String? emailValidator(String? email){

    if(email == null || email.isEmpty ){
      return " please enter  email";
    }
    final emailexp = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');


    if(!emailexp.hasMatch(email)){
      return "Enter valid email";
    }
    return null;
  }

  String? ageValidator(String? age){
    if(age == "0"){
      return "age can not be zero";

    }
     if (!RegExp(r'^\d+$').hasMatch(age!)) {
    return "Only numbers are allowed";
  }
    
    return null;
  }


  var tasks = <Task>[].obs;

///adding data to moden and preferences
  void addtask(String title,String email,String age, String image, List<XFile?> imglist){
List<String> imagePaths = imglist.whereType<XFile>().map((xfile) => xfile.path).toList();

    tasks.add(Task(name: title,email: email, age: age, image: image, imageList: imagePaths));
    saveTasktoPref();
  }

//removing data from model and preferences
  void deleteTask(int index){
    tasks.removeAt(index);
    saveTasktoPref();
  }

  //updating data of modeland preferences
  void updateTask(int index,String newTitle,String newEmail,String newAge,String image, List<String> imglist){
// List<String> imagePaths = imglist.whereType<XFile>().map((xfile) => xfile.path).toList();

    tasks[index]=Task(name: newTitle, email: newEmail, age: newAge,image: image, imageList:imglist);
      saveTasktoPref();
      tasks.refresh();
      
  }

}
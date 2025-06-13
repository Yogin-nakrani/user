import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class AllWidgets {







  Widget title (String title){
    return Text(title);
  }


Widget txtField (TextEditingController txtController,String label,{String? Function(String?)? validator}){

return Padding(
  padding: const EdgeInsets.only(top: 10.0),
  child: TextFormField(
    controller: txtController,
    validator: validator,
    decoration: txtfieldDecoration(label),
    
  
  ),
);


}
InputDecoration txtfieldDecoration(String label){

  return  InputDecoration(

      label: Text(label,),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(width: 1))


  );
}

Widget iconBtn(IconData icon,VoidCallback onpressed){

  return IconButton(onPressed: onpressed, icon: Icon(icon));
}

Widget btn(VoidCallback onPressed, String title){

  return ElevatedButton(onPressed: onPressed, child: Text(title));
}


}









class ImagePickFromGallery extends StatefulWidget {
final   Function(File?)   onImagePicked;
final Function(List<XFile?>) onMLTImagePicked;

  const ImagePickFromGallery({required this.onImagePicked,required this.onMLTImagePicked,super.key});

  @override
  State<ImagePickFromGallery> createState() => ImagePickFromGalleryState();
}

class ImagePickFromGalleryState extends State<ImagePickFromGallery> {

  ImagePicker singleImage = ImagePicker();
  File? selectedImage;

  List<XFile> imageList = [];


    _pickImagefromGallery ()async{
final XFile?  Image = await singleImage.pickImage(source: ImageSource.gallery);
if(Image != null){


setState(() {
  selectedImage = File(Image.path);
});
widget.onImagePicked(selectedImage!);
  
}

    }



_mltImages()async{
  final List<XFile> images = await singleImage.pickMultiImage();

  setState(() {
    imageList = images;
  });
  widget.onMLTImagePicked(imageList);
 
}







void clearImg(){

  setState(() {
    selectedImage =null;
    imageList.clear();
  });
  widget.onImagePicked(null);
  widget.onMLTImagePicked([]);
}





  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        
      child: Column(
        children: [
          Container(
            width: 150,
            child: InkWell(
              onTap: _pickImagefromGallery,
              child: DottedBorder(
                color: Colors.blueAccent,
                dashPattern: [6-3],
                child: Center(
                child:  selectedImage != null?     ClipRect(
                    child: Image.file(selectedImage!,height: 150,width: 150,fit: BoxFit.cover,) 
                  ) :Column(
                  children: [
                    Icon(Icons.upload),
                    Text("Upload Image")
                  ],
                ),
              )),
            ),
          ),
          
            SizedBox(height: 20,),
            
            Container(
              width: 150,
              child: InkWell(
                onTap: () {
                  _mltImages();
                },
                child: DottedBorder(
                  dashPattern: [6-3],
                  color: Colors.blue,
                  child: Center(child: Column(
                    children: [
                      Icon(Icons.upload),
                      Text("Multiple Images")
                    ],
                  ),),
                ),
              ),
            ),
             Padding(
               padding: const EdgeInsets.only(top: 10.0),
               child: Container(
                height: 200,
                // width: double.infinity,
                 child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageList.length,
                          itemBuilder: (contaxt,index){
                            
                    
                              return Padding(
                                padding: const EdgeInsets.only(left:10.0),
                                child: Container(
                                  child:Image.file(File(imageList[index].path),fit: BoxFit.cover,) ,
                                ),
                              );
                    
                          
                        }),
               ),
             ) 



        ],
      ),
        ),
    );
  }
}
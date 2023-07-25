

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class serverImageUsingAPI extends StatefulWidget {
  const serverImageUsingAPI({super.key});

  @override
  State<serverImageUsingAPI> createState() => _serverImageUsingAPIState();
}

class _serverImageUsingAPIState extends State<serverImageUsingAPI> {





  File? file ;
  final imagePicker = ImagePicker();
  Future<void> ImageUploadToServer()async{


    //read image by stream
    var stream = new  http.ByteStream(file!.openRead());
    stream.cast();

    //get length of image in bytes
    var length = await file!.length();
    print("Length is : $length");

    //open request for server with some data ( if email , password etc )
    var url = Uri.parse("https://fakestoreapi.com/products");
    var request = new http.MultipartRequest("POST", url);
    request.fields['title'] = "Hamza Khan";


    //put image file
    var multipart = new http.MultipartFile(
        "image",
        stream,
        length);

    //send the file
  //
    // request.files.add(multipart);
   var response = await request.send();

   //check status code if api requested the server or not
   if(response.statusCode == 200){
     print('API HIT WITH IMAGE UPLOAD');

   }
   else{
     print('API NOT HIT ');
   }

  }


  @override


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : Scaffold(
       body : Center(
         child: file!=null ? Image.file(file!,fit: BoxFit.contain,height: 380,width: 188,) : MaterialButton(

             onPressed: () async{
               final pickedFile  = await imagePicker.pickImage(source: ImageSource.gallery,);
              setState(() {

                file = File(pickedFile!.path);

              });

              ImageUploadToServer();

             },
             height: MediaQuery.of(context).size.height /11,
             minWidth: MediaQuery.of(context).size.width /1.1,
             color: Colors.orangeAccent,
             shape: OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(18)),
                 borderSide: BorderSide(
                     color: Colors.transparent
                 )
             ),

             child: Text("Select Image")
         ),
       )
      )
    );
  }
}

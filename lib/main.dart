import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model/PostModel.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  List<PostModel> postList = [];
  
  Future<List<PostModel>> getPost()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        postList.add(PostModel.fromJson(i));
      }
    }
    else{

      return postList;
    }

    return postList;
  }
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   

    
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: FutureBuilder(
                future: getPost(),
                builder: (context ,snapshot){
                  if(!snapshot.hasData){
                    return const Center(child: Text("Loading Data"));
                  }
                  return ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context,index){
                        return ListTile(
                          title: Text(postList[index].title.toString()),
                        );
                      });
                },
              ))
            ],
          )
          
        ),
      ),
    );
  }
}

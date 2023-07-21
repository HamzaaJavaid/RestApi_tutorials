import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restapi_tutorials/FilewithComplexJson.dart';
import 'package:restapi_tutorials/FilewithoutModel.dart';
import 'FilewithCustomModel.dart';
import 'Model/PostsModel.dart';


void main() {
  runApp(const noModel());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  List<PostsModel>  allPostsList = [];

  Future<List<PostsModel>> getAllPosts()async{

    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      for(Map i in data){
        allPostsList.add(PostsModel.fromJson(i));
      }
      for(int i = 0 ; i<allPostsList.length ; i++){
        print(allPostsList[i].title.toString());
      }
    }
    else{
      print("api not hit");
    }
    return allPostsList;

  }




  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPosts();

  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: getAllPosts(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                        color: Colors.orangeAccent,
                      ),);
                    }
                    return ListView.builder(
                      itemCount: allPostsList.length,
                      itemBuilder: (context,index){
                        return Card(
                          child: ListTile(
                            title: Text(allPostsList[index].title.toString()),
                            subtitle: Text(allPostsList[index].body.toString()),
                            trailing: Text(allPostsList[index].id.toString()),
                          ),
                        );
                      },
                    );
                  },

                ),
              )
            ],
          )
          
        ),
      ),
    );
  }
}

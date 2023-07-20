

import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/Custom Models.dart';


class customModelScreen extends StatefulWidget {
  const customModelScreen({super.key});

  @override
  State<customModelScreen> createState() => _customModelScreenState();
}

class _customModelScreenState extends State<customModelScreen> {
  
  
  
  List<customModel> allDataFromAPI = [];
  
  Future<List<customModel>> getDataFromAPI()async{
    
    final response =await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());


    if(response.statusCode==200){
      for(Map i in data){
        customModel custModel = customModel(i['id'].toString(), i['title'].toString(), i['body'].toString(), i['userId'].toString());
        allDataFromAPI.add(custModel);
      }
    }
    else{
      print("API not hit");
    }
    return allDataFromAPI;
    
  }
  
  
  
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            future: getDataFromAPI(),
            builder: (context , AsyncSnapshot<List<customModel>> snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }
              return ListView.builder(
                itemCount: allDataFromAPI.length,
                itemBuilder: (context,index){
                  return Padding(padding: EdgeInsets.symmetric(horizontal: 3),child: Card(
                    shadowColor: Colors.black,
                    elevation: 4,
                    child: ListTile(
                      title: Text(snapshot.data![index].title.toString()),
                      subtitle: Text(snapshot.data![index].body.toString()),
                      trailing: Text(snapshot.data![index].id.toString()),
                      leading: Text(snapshot.data![index].userId.toString()),
                    ),
                  ),);
                },
              );
            },
          )
        ),
      ),
    );
  }
}


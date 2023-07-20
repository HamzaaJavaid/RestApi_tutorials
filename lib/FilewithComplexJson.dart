import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model/complexJson.dart';

class complexJsonScreen extends StatefulWidget {
  const complexJsonScreen({super.key});

  @override
  State<complexJsonScreen> createState() => _complexJsonScreenState();
}

class _complexJsonScreenState extends State<complexJsonScreen> {
  
  
  List<ComplexJson> allDataFromAPI = [];
  
  Future<List<ComplexJson>> getDataFromAPI()async{
    
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body);

    if(response.statusCode==200){
      for(Map i in data){
        allDataFromAPI.add(ComplexJson.fromJson(i));

      }
    }
    else{
      print("API NOT HIT");
    }
    return allDataFromAPI;
  }

  Widget ListTileWidget(String username , String email , String city , String coordinates){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Name"),
            SizedBox(),
            Text(username),
            Text(""),
            Text('')
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Email"),
            SizedBox(),
            Text(email),
            Text(""),
            Text('')
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("City"),
            SizedBox(),
            Text(city),
            Text(""),
            Text('')
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Location"),
            SizedBox(),
            Text(coordinates),
            Text(""),
            Text('')
          ],
        ),
      ],
    );
  }
  
  
  @override

  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: FutureBuilder(
            future: getDataFromAPI(),
            builder: (context , AsyncSnapshot<List<ComplexJson>> snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }
              return ListView.builder(
                itemCount: allDataFromAPI.length,
                itemBuilder: (context , index){
                  return Card(
                    child: ListTileWidget(
                      snapshot.data![index].username.toString(),
                      snapshot.data![index].email.toString(),
                      snapshot.data![index].address!.city.toString(),
                      "${snapshot.data![index].address!.geo!.lat} and ${snapshot.data![index].address!.geo!.lng}",

                    ),
                  );
                },

              );
            },



          ),
        ),
      ),
    );
  }
}



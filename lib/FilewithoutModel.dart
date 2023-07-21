import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class noModel extends StatefulWidget {
  const noModel({super.key});

  @override
  State<noModel> createState() => _noModelState();
}

class _noModelState extends State<noModel> {

  var data ;
  Future<void> getAPIData()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if(response.statusCode==200){

       data = jsonDecode(response.body.toString());
    }
    else{
      print('API NOT  HIT');
    }

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



  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: FutureBuilder(
              future: getAPIData(),
              builder: (context, snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
    }
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: ListTileWidget(
                            data[index]['username'],
                            data[index]['email'],
                            data[index]['address']['city'],
                            data[index]['address']['geo']['lat']
                        ),
                      );
                    });
    },
        ),
      ),
      ) );
  }
}

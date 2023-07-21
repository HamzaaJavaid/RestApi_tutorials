import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'Model/veryComplexJsonModel.dart';


class veryComplexJson extends StatefulWidget {
  const veryComplexJson({super.key});

  @override
  State<veryComplexJson> createState() => _veryComplexJsonState();
}

class _veryComplexJsonState extends State<veryComplexJson> {





  var data ;
  Future<VeryComplexJsonModel> getDataFromAPI()async{

    final response = await http.get(Uri.parse("https://webhook.site/c186341a-9197-4f2d-868a-019d1d6ba6a0"));
    data = jsonDecode(response.body.toString());

    if(response.statusCode==200){
      return VeryComplexJsonModel.fromJson(data);
    }
    else{
      print("API not hit");
    }
     return VeryComplexJsonModel.fromJson(data);


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
          minimum: EdgeInsets.all(20),
          child: FutureBuilder(
            future: getDataFromAPI(),
            builder: (context,AsyncSnapshot<VeryComplexJsonModel> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              return ListView.builder(
                itemCount: snapshot.data?.data?.length,
                  itemBuilder: (context,index){
                  return Column(
                    children: [
                      Text("Status : ${snapshot.data?.success.toString()}"),
                      Text("ID : ${snapshot.data?.data?[index].id.toString()}"),
                      Text("Image URL :${snapshot.data?.data?[index].categories?.image.toString()} ",style: TextStyle(
                        color: Colors.blue
                      ),),
                      Text("Name :${snapshot.data?.data?[index].subcat?.name.toString()} ",),
                      Text("ShopCity :${snapshot.data?.data?[index].shop?.shopcity.toString()} ",),
                      Text("Price  :${snapshot.data?.data?[index].price.toString()} ",),


                    ],
                  );
                  }
              );
            },
          ),
        ),
      ),
    );
  }
}

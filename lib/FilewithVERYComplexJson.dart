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



  Future<VeryComplexJsonModel> getDataFromAPI()async{

    final response = await http.get(Uri.parse("https://webhook.site/8cf6d09a-fc2c-4abc-aced-be5cc94922dd"));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode== 200){
      return VeryComplexJsonModel.fromJson(data);
    }

    else{
      return VeryComplexJsonModel.fromJson(data);
    }


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
            builder: (context , AsyncSnapshot<VeryComplexJsonModel> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              return ListView.builder(
                itemCount: snapshot.data?.data?.length,
                itemBuilder: (context , index){
                  return ListTile(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    title: Text(snapshot.data!.data![index].title.toString()),
                    subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data!.data![index].categories!.image.toString()),
                    ),
                    trailing: Text(snapshot.data!.data![index].price.toString()),
                  );
                },
              );
            },
          )
        ),
      ),
    );
  }
}

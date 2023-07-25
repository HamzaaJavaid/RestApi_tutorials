import 'package:flutter/material.dart';
import 'package:http/http.dart' ;


class authenticationScreenusingAPI extends StatefulWidget {
  const authenticationScreenusingAPI({super.key});

  @override
  State<authenticationScreenusingAPI> createState() => _authenticationScreenusingAPIState();
}

class _authenticationScreenusingAPIState extends State<authenticationScreenusingAPI> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void SignupAPI(String email , String password)async{

    Response response = await  post(Uri.parse("https://reqres.in/api/register"), body: {
        "email" : email.toString(),
        "password" : password.toString(),
      });

    if(response.statusCode== 200){
      print("API HIT");
    }
    else{
      print('API not Hit');
    }

  }
  void LoginAPI(String email , String password)async{

    Response response = await  post(Uri.parse("https://reqres.in/api/login"), body: {
      "email" : email.toString(),
      "password" : password.toString(),
    });

    if(response.statusCode== 200){
      print("API HIT");
    }
    else{
      print('API not Hit');
    }

  }
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body : SafeArea(
          child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
              Padding(padding: EdgeInsets.all(20),child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Enter Your Email : ",
                    labelText: "Email",
                    focusColor: Colors.orangeAccent,
                    hoverColor: Colors.orangeAccent,
                    focusedBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.orangeAccent),
                    ) ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.transparent),
                    )
                ),
              ),),
              SizedBox(height: 6,),
              Padding(padding: EdgeInsets.all(20),child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "Enter Your Email : ",
                    labelText: "Email",
                    focusColor: Colors.orangeAccent,
                    hoverColor: Colors.orangeAccent,
                    focusedBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.orangeAccent),
                    ) ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.transparent),
                    )
                ),
              ),),
              SizedBox(height: 6,),
              MaterialButton(
                onPressed: (){
                  SignupAPI(emailController.text.toString() , passwordController.text.toString());
                 

                },
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  color: Colors.redAccent,
                  minWidth: MediaQuery.of(context).size.width /1.1,
                  height: MediaQuery.of(context).size.height /13,
                child : Text('SignUp')
              ),
              SizedBox(height: 6,),
              MaterialButton(
                  onPressed: (){

                    LoginAPI(emailController.text.toString() , passwordController.text.toString());

                  },
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  color: Colors.redAccent,
                  minWidth: MediaQuery.of(context).size.width /1.1,
                  height: MediaQuery.of(context).size.height /13,
                  child : Text('Login')
              )


            ]
          )
        )
      ),
    );
  }
}

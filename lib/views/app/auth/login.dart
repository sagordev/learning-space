import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_space/configs/endpoints.dart';
import 'package:learning_space/services/api_service.dart';
import 'package:learning_space/services/auth_service.dart';

class Login extends StatefulWidget{
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login>{
  final formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";

  _doLogin(BuildContext context) async {
    print("Username is: " + username);
    print("Password is: " + password);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_){
          return Dialog(
            child: SizedBox(
              height: 120,
              child:  Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 15,),
                  Text("Please wait...")
                ],
              ),
            )
          );
        }
    );
    bool isLoggedIn = await AuthService().login(username, password);
    if(isLoggedIn){
      Navigator.of(context).pushNamedAndRemoveUntil('/dashboard', (route) => false);
    }else{
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Incorrect username or password!", style: TextStyle(color: Colors.white),)
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/reading.png', width: 250,),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text("Learning Space", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              Padding(padding: EdgeInsets.only(top: 10)),
              Text("Enter your University given ID and Password", style: TextStyle(color: Colors.grey),),
              Padding(padding: EdgeInsets.only(top: 10)),
              Card(
                  elevation: 30.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                getUsernameField(),
                                getPasswordField(),
                                getLoginButton(),
                              ],
                            ),
                          )
                      )
                  )
              )
            ],
          ),
        )
      ),
    );
  }
  Widget getLoginButton(){
    return Padding(padding: EdgeInsets.only(top: 10),
      child: ElevatedButton(
          onPressed: () async {
            if(formKey.currentState!.validate()){
              formKey.currentState!.save();
              await this._doLogin(context);
            }
          },
          child: Container(
            alignment: Alignment.center,
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Text("Login", textAlign: TextAlign.center,),
          )
      ),
    );
  }


  Widget getUsernameField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("ID/Username", textScaleFactor: 1.2,style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: 5,),
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Your ID/Username",
            prefixIcon: Icon(Icons.person),
          ),
          validator: (value){
            return value == null || value.isEmpty ? 'Enter valid username' : null;
          },
          onChanged: (value) {
            setState(() {
              username = value;
            });
          },
        ),
      ],
    );
  }

  Widget getPasswordField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 10)),
        Text("Password", textScaleFactor: 1.2,style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: 5,),
        TextFormField(
          obscureText: true,
          validator: (value){
            return value == null || value.isEmpty ? 'Enter valid password' : null;
          },
          decoration: const InputDecoration(
            hintText: "Your Password",
            prefixIcon: Icon(Icons.key),
          ),
          onChanged: (value) {
            setState(() {
              password = value;
            });
          },
        ),
      ],
    );
  }
}



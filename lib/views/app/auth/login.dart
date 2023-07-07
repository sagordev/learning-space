import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/reading.png', width: 250,),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text("Learning Space", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text("Enter your University ID and Password to login", style: TextStyle(color: Colors.grey),),
            Padding(padding: EdgeInsets.only(top: 10)),
            Card(
              elevation: 180.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                child: Padding(
                  padding: EdgeInsets.all(15),
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
          ],
        ),
      ),
    );
  }
  Widget getLoginButton(){
    return Padding(padding: EdgeInsets.only(top: 10),
      child: ElevatedButton(
          onPressed: () => {
            Navigator.of(context).pushNamedAndRemoveUntil('/dashboard', (route) => false)
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
        Text("Student ID", textScaleFactor: 1.2,style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: 5,),
        TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person),
          ),
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
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.key),
          ),
        ),
      ],
    );
  }
}



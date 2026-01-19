import 'package:flutter/material.dart';
import 'package:flutter_sec8_apis/provider/user_token_provider.dart';
import 'package:flutter_sec8_apis/services/auth.dart';
import 'package:flutter_sec8_apis/views/register.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          TextField(controller: emailController,),
          TextField(controller: passwordController,),
          isLoading ? Center( child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
                try{
                 await AuthServices().loginUser(
                     email: emailController.text,
                     password: passwordController.text)
                     .then((val)async{
                       userProvider.setToken(val.token.toString());
                       await AuthServices().getProfile(val.token.toString())
                       .then((userData){
                         showDialog(context: context, builder: (BuildContext context) {
                           return AlertDialog(
                             content: Text("Register Successfully"),
                             actions: [
                               TextButton(onPressed: (){
                                 Navigator.pop(context);
                                 Navigator.pop(context);
                               }, child: Text("Okay"))
                             ],
                           );
                         }, );
                       });
                 });
                }catch(e){
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
          }, child: Text("Login")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Register()));
          }, child: Text("Register"))
        ],
      ),
    );
  }
}

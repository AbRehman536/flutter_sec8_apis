import 'package:flutter/material.dart';
import 'package:flutter_sec8_apis/provider/user_token_provider.dart';
import 'package:flutter_sec8_apis/views/update_profile.dart';
import 'package:provider/provider.dart';

class GetProfile extends StatefulWidget {
  const GetProfile({super.key});

  @override
  State<GetProfile> createState() => _GetProfileState();
}

class _GetProfileState extends State<GetProfile> {

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Profile"),
      ),
      body: Column(children: [
        Text("Name: ${userProvider.getUser()!.user!.name.toString()}"),
        Text("Email: ${userProvider.getUser()!.user!.email.toString()}"),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfile()));
        }, child: Text("Update Profile"))
      ],),
    );
  }
}

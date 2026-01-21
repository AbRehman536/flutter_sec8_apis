import 'package:flutter/material.dart';
import 'package:flutter_sec8_apis/provider/user_token_provider.dart';
import 'package:flutter_sec8_apis/services/task.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';

class UpdateTask extends StatefulWidget {
  final Task model;
  const UpdateTask({super.key, required this.model});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    descriptionController.text = widget.model.description.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Task"),
      ),
      body: Column(
        children: [
          TextField(controller:  descriptionController,),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await TaskServices().updateTask(
                  token: userProvider.getToken().toString(),
                  description: descriptionController.text,
                  taskID: widget.model.id.toString())
                  .then((val){
                isLoading = false;
                setState(() {});
                showDialog(
                  context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Update Successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: Text("Okay"))
                    ],
                  );
                }, );
              });
            }catch(e){ isLoading = false;
            setState(() {});
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Update Task"))
        ],
      ),
    );
  }
}

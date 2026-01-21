import 'package:flutter/material.dart';
import 'package:flutter_sec8_apis/models/task.dart';
import 'package:flutter_sec8_apis/models/taskListing.dart';
import 'package:flutter_sec8_apis/services/task.dart';
import 'package:provider/provider.dart';

import '../provider/user_token_provider.dart';

class GetAllTask extends StatelessWidget {
  const GetAllTask({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Task"),
      ),
      body: FutureProvider.value(
          value: TaskServices().getAllTask(userProvider.getToken().toString()),
          initialData: [TaskModel()],
          builder: (context, child){
            TaskListingModel taskListingModel = context.watch<TaskListingModel>();
            return taskListingModel.tasks == null ?
              Center(child: CircularProgressIndicator(),)
            :ListView.builder(itemBuilder: (BuildContext context, int index) {
              return GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                children: [
                  Text(taskListingModel.tasks![index].description.toString()),
                  IconButton(onPressed: ()async{
                    try{
                      await TaskServices().deleteTask(
                          token: userProvider.getToken().toString(),
                          taskID: taskListingModel.tasks![index].id.toString());
                    }catch(e){
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }, icon: Icon(Icons.delete)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.edit))
                ],
              );
            },);

      },),
    );
  }
}

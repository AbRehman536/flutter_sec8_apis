
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../models/taskListing.dart';
import '../provider/user_token_provider.dart';
import '../services/task.dart';

class GetInCompletedTask extends StatelessWidget {
  const GetInCompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Get In Completed Task"),
      ),
      body: FutureProvider.value(
        value: TaskServices().getInCompletedTask(userProvider.getToken().toString()),
        initialData: [TaskListingModel()],
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

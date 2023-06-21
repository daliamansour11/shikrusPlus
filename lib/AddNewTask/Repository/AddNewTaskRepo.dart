



import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../apiService/DioClient.dart';

class AddNewTaskRepo{

  final DioClient dioClient;
  AddNewTaskRepo( this.dioClient);

    ///////POST EMPLOYEE TASKS/////

  addNewMainTask(String name,String subject,String note,
      String start_date,String end_date,String time_from,String time_to,String type,int project_id)
  async{
    var responseData = await dioClient.AddNewMainTask( name,subject,note,start_date,end_date,
        time_from,time_to,type ,project_id);

     return responseData;
  }


addNewSubTask(String name,String subject,String note,
      String start_date,String end_date,String time_from,String time_to,String type,int project_id,int main_task_id) async{
    var responseData = await dioClient.AddNewSubTask( name,subject,
        note,start_date,end_date,time_from,time_to,type, project_id,main_task_id );

     return responseData;
  }
}




final AddNewTasksRepoProvider = Provider<AddNewTaskRepo>((ref) =>
    AddNewTaskRepo(DioClient()),
);

//

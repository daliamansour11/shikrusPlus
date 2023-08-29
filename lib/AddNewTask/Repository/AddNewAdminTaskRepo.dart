



import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../apiService/DioClient.dart';

class AddNewAdminTaskRepo{

  final DioClient dioClient;
  AddNewAdminTaskRepo( this.dioClient);

  ///////POST EMPLOYEE TASKS/////

  addNewMainAdminTask(String name,String subject,String note, String start_date,String end_date,String time_from,String time_to,String type,int project_id,int employeeid)
  async{
    var responseData;
    try{
      responseData = await dioClient.AddNewMainAdminTask( name,subject,note,start_date,end_date,
          time_from,time_to,type ,project_id,employeeid);
      print("${responseData.hashCode}ttttt");
      return responseData;
    }catch(e){print("${e.toString()}erorrrrrrr");}
    return responseData;
  }




}




final AddNewTasksAdminRepoProvider = Provider<AddNewAdminTaskRepo>((ref) =>
    AddNewAdminTaskRepo(DioClient()),
);

//


class GroupModel
{



  String groupName;
  String groupId;
  String groupImage;
  String about;
  String sender;
  String senderId;
  String receiverId;
  // List<MembersModel> groupMembers;

  GroupModel({
    required this.groupName,
    required this.groupId,
    required this.groupImage,
    required this.about,
    // required this.groupMembers,
    required this.sender,
    required this.senderId,
    required this.receiverId,
    // required this.email,
  });

}
class UserJoinRequest{
  int id;
int status;
String communityName;

UserJoinRequest({required this.status,required this.communityName,required this.id});
factory UserJoinRequest.fromJson(Map<String, dynamic> json) {
  return UserJoinRequest(
   status: json['status'],
    communityName:  json['Community']['name'], id: json['id'],
  );
}
}

import 'dart:convert';

class UserGroupsModel {
  static const String id = 'id';
  static const String uid = 'uid';
  static const String gid = 'gid';

  static List<String> getFields() => [id, uid, gid,];

}


class UserGroup {
  final int id;
  final String uid;
  final String gid;

  const UserGroup({
    this.id,
    this.uid,
    this.gid,
  });

  static UserGroup fromJson(Map<String, dynamic> json) => UserGroup(
    id: jsonDecode(json[UserGroupsModel.id]),
    uid: json[UserGroupsModel.uid],
    gid: json[UserGroupsModel.gid],
  );

  Map<String, dynamic> toJson() => {
    UserGroupsModel.id: id,
    UserGroupsModel.uid: uid,
    UserGroupsModel.gid: gid,
  };
}

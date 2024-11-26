class ChatRoomModel {
  final String uid;
  final String personAuid;
  final String personAname;
  final String personBuid;
  final String personBname;
  final int lastChattedAt;

  ChatRoomModel({
    required this.uid,
    required this.personAuid,
    required this.personAname,
    required this.personBuid,
    required this.personBname,
    required this.lastChattedAt,
  });

  ChatRoomModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        personAname = json['personAname'],
        personAuid = json['personAuid'],
        personBuid = json['personBuid'],
        personBname = json['personBname'],
        lastChattedAt = json['lastChattedAt'];

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "personAuid": personAuid,
      "personAname": personAname,
      "personBuid": personBuid,
      "personBname": personBname,
      "lastChattedAt": lastChattedAt,
    };
  }
}

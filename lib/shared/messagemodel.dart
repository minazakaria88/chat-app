class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTIme;
  String? text;

  MessageModel({this.receiverId, this.text, this.dateTIme, this.senderId});

  MessageModel.fromJson(Map<String,dynamic> json)
  {
    senderId=json['senderId'];
    receiverId=json['receiverId'];
    dateTIme=json['dateTIme'];
    text=json['text'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'senderId':senderId,
        'receiverId':receiverId,
        'dateTIme':dateTIme,
        'text':text,
      };
  }

}

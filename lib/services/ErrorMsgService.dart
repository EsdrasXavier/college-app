class ErrorMsgService {
  static String handleMsg(Map<String, dynamic> json) {
    print(json);
    return json['msg'];
  }
}

import 'dart:convert';

class RequestData {
  String url;
  Map<String, String> headers;
  dynamic body;
  Encoding encoding;

  RequestData({
    this.url,
    this.headers,
    this.body,
    this.encoding,
  });
}

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_middleware/models/request_data.dart';
import 'middleware_contract.dart';

class HttpMiddlewareClient implements http.Client {
  final List<MiddlewareContract> middlewares;

  HttpMiddlewareClient.build({
    this.middlewares,
  });

  http.Client _client = http.IOClient();

  @override
  void close() {
    _client.close();
  }

  @override
  Future<http.Response> delete(url, {Map<String, String> headers}) {
    RequestData requestData =
        _getRequestData(url: url, headers: headers, body: null, encoding: null);

    var callbackList = <Function(http.Response)>[];

    middlewares.forEach(
      (middleware) {
        Function(http.Response) responseCallback =
            middleware.interceptDelete(data: requestData);
        if (responseCallback != null) callbackList.add(responseCallback);
      },
    );

    return _client.delete(requestData.url, headers: requestData.headers).then(
      (response) {
        callbackList.forEach((callback) => callback(response));
        return response;
      },
    );
  }

  @override
  Future<http.Response> get(url, {Map<String, String> headers}) {
    RequestData requestData =
        _getRequestData(url: url, headers: headers, body: null, encoding: null);

    var callbackList = <Function(http.Response)>[];

    middlewares.forEach(
      (middleware) {
        Function(http.Response) responseCallback =
            middleware.interceptGet(data: requestData);
        if (responseCallback != null) callbackList.add(responseCallback);
      },
    );

    return _client.get(requestData.url, headers: requestData.headers).then(
      (response) {
        callbackList.forEach((callback) => callback(response));
        return response;
      },
    );
  }

  @override
  Future<http.Response> head(url, {Map<String, String> headers}) {
    RequestData requestData = _getRequestData(url: url, headers: headers);

    var callbackList = <Function(http.Response)>[];

    middlewares.forEach(
      (middleware) {
        Function(http.Response) responseCallback =
            middleware.interceptHead(data: requestData);
        if (responseCallback != null) callbackList.add(responseCallback);
      },
    );

    return _client.head(requestData.url, headers: requestData.headers).then(
      (response) {
        callbackList.forEach((callback) => callback(response));
        return response;
      },
    );
  }

  @override
  Future<http.Response> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    RequestData requestData = _getRequestData(
        url: url, headers: headers, body: body, encoding: encoding);

    var callbackList = <Function(http.Response)>[];

    middlewares.forEach(
      (middleware) {
        Function(http.Response) responseCallback =
            middleware.interceptPatch(data: requestData);
        if (responseCallback != null) callbackList.add(responseCallback);
      },
    );

    return _client
        .patch(requestData.url,
            headers: requestData.headers,
            body: requestData.body,
            encoding: requestData.encoding)
        .then(
      (response) {
        callbackList.forEach((callback) => callback(response));
        return response;
      },
    );
  }

  @override
  Future<http.Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    RequestData requestData = _getRequestData(
        url: url, headers: headers, body: body, encoding: encoding);

    var callbackList = <Function(http.Response)>[];

    middlewares.forEach(
      (middleware) {
        Function(http.Response) responseCallback =
            middleware.interceptPost(data: requestData);
        if (responseCallback != null) callbackList.add(responseCallback);
      },
    );

    return _client
        .post(requestData.url,
            headers: requestData.headers,
            body: requestData.body,
            encoding: requestData.encoding)
        .then(
      (response) {
        callbackList.forEach((callback) => callback(response));
        return response;
      },
    );
  }

  @override
  Future<http.Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    RequestData requestData = _getRequestData(
        url: url, headers: headers, body: body, encoding: encoding);

    var callbackList = <Function(http.Response)>[];

    middlewares.forEach(
      (middleware) {
        Function(http.Response) responseCallback =
            middleware.interceptPut(data: requestData);
        if (responseCallback != null) callbackList.add(responseCallback);
      },
    );

    return _client
        .put(requestData.url,
            headers: requestData.headers,
            body: requestData.body,
            encoding: requestData.encoding)
        .then(
      (response) {
        callbackList.forEach((callback) => callback(response));
        return response;
      },
    );
  }

  @override
  Future<String> read(url, {Map<String, String> headers}) {
    RequestData requestData = _getRequestData(url: url, headers: headers);

    var callbackList = <Function(String)>[];

    middlewares.forEach(
      (middleware) {
        Function(String) responseCallback =
            middleware.interceptRead(data: requestData);
        if (responseCallback != null) callbackList.add(responseCallback);
      },
    );

    return _client.read(requestData.url, headers: requestData.headers).then(
      (response) {
        callbackList.forEach((callback) => callback(response));
        return response;
      },
    );
  }

  @override
  Future<Uint8List> readBytes(url, {Map<String, String> headers}) {
    RequestData requestData = _getRequestData(url: url, headers: headers);

    var callbackList = <Function(Uint8List)>[];

    middlewares.forEach(
      (middleware) {
        Function(Uint8List) responseCallback =
            middleware.interceptReadBytes(data: requestData);
        if (responseCallback != null) callbackList.add(responseCallback);
      },
    );

    return _client
        .readBytes(requestData.url, headers: requestData.headers)
        .then(
      (response) {
        callbackList.forEach((callback) => callback(response));
        return response;
      },
    );
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    var callbackList = <Function(http.StreamedResponse)>[];

    middlewares.forEach(
      (middleware) {
        Function(http.StreamedResponse) responseCallback =
            middleware.interceptSend(request: request);
        if (responseCallback != null) callbackList.add(responseCallback);
      },
    );

    return _client.send(request).then(
      (response) {
        callbackList.forEach((callback) => callback(response));
        return response;
      },
    );
  }

  RequestData _getRequestData(
      {String url, Map<String, String> headers, body, Encoding encoding}) {
    return RequestData(
        url: url, headers: headers, body: body, encoding: encoding);
  }
}

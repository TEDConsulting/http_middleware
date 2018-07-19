import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_middleware/models/request_data.dart';
import 'middleware_contract.dart';

///Class to be used by the user as a replacement for 'http' with middleware supported.
///call the `build()` constructor passing in the list of middlewares.
///Example:
///```dart
/// HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
///     Logger(),
/// ]);
///```
///Then call the functions you want to, on the created `http` object.
///```dart
/// http.get(...);
/// http.post(...);
/// http.put(...);
/// http.delete(...);
/// http.head(...);
/// http.patch(...);
/// http.read(...);
/// http.readBytes(...);
///```
class HttpWithMiddleware {
  final List<MiddlewareContract> middlewares;

  HttpWithMiddleware._internal({this.middlewares});

  factory HttpWithMiddleware.build({List<MiddlewareContract> middlewares}) {
    //Remove any value that is null.
    middlewares.removeWhere((middleware) => middleware == null);
    return HttpWithMiddleware._internal(middlewares: middlewares);
  }

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

    return http.delete(requestData.url, headers: requestData.headers).then(
      (response) {
        callbackList.forEach((callback) => callback(response));
        return response;
      },
    );
  }

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

    return http.get(requestData.url, headers: requestData.headers).then(
      (response) {
        callbackList.forEach((callback) => callback(response));
        return response;
      },
    );
  }

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

    return http.head(requestData.url, headers: requestData.headers).then(
      (response) {
        callbackList.forEach((callback) => callback(response));
        return response;
      },
    );
  }

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

    return http
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

    return http
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

    return http
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

    return http.read(requestData.url, headers: requestData.headers).then(
      (response) {
        callbackList.forEach((callback) => callback(response));
        return response;
      },
    );
  }

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

    return http.readBytes(requestData.url, headers: requestData.headers).then(
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

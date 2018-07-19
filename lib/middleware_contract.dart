import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_middleware/models/request_data.dart';

///Middleware interface to create custom middleware for http.
///Extend this class and override the functions that you want
///to intercept.
///
///Intercepting Requests: Every function takes in a RequestData as a parameter which
///contains the url, body, headers and encoding from the request.
///
///Intercepting Response: If you want to intercept response,
///return a Function(http.Response) from the intercepted function.
///You are returning a callback which will be called when the response
///is received.
///
///Example (Simple logging):
///
///```dart
///class CustomMiddleWare extends MiddlewareContract {
///    @override
///    Function(http.Response) interceptPost({RequestData data}) {
///        print("POST Url: ${response}")
///        return (response) {
///            print("POST Status: ${}")
///        };
///    }
///}
///```
abstract class MiddlewareContract {

  ///Intercept POST request made by the `http.Client`.
  ///
  ///@param data `RequestData` containing url, body, headers and encoding.
  ///@returns A callback function used to intercept response.
  Function(http.Response) interceptPost({RequestData data}) {
    return null;
  }

  ///Intercept DELETE request made by the `http.Client`.
  ///
  ///@param data `RequestData` containing url, body, headers and encoding.
  ///@returns A callback function used to intercept response.
  Function(http.Response) interceptDelete({RequestData data}) {
    return null;
  }

  ///Intercept GET request made by the `http.Client`.
  ///
  ///@param data `RequestData` containing url, body, headers and encoding.
  ///@returns A callback function used to intercept response.
  Function(http.Response) interceptGet({RequestData data}) {
    return null;
  }

  ///Intercept HEAD request made by the `http.Client`.
  ///
  ///@param data `RequestData` containing url, body, headers and encoding.
  ///@returns A callback function used to intercept response.
  Function(http.Response) interceptHead({RequestData data}) {
    return null;
  }

  ///Intercept PATCH request made by the `http.Client`.
  ///
  ///@param data `RequestData` containing url, body, headers and encoding.
  ///@returns A callback function used to intercept response.
  Function(http.Response) interceptPatch({RequestData data}) {
    return null;
  }

  ///Intercept PUT request made by the `http.Client`.
  ///
  ///@param data `RequestData` containing url, body, headers and encoding.
  ///@returns A callback function used to intercept response.
  Function(http.Response) interceptPut({RequestData data}) {
    return null;
  }

  ///Intercept READ request made by the `http.Client`.
  ///
  ///@param data `RequestData` containing url, body, headers and encoding.
  ///@returns A callback function used to intercept response.
  Function(String) interceptRead({RequestData data}) {
    return null;
  }

  ///Intercept READ BYTES request made by the `http.Client`.
  ///
  ///@param data `RequestData` containing url, body, headers and encoding.
  ///@returns A callback function used to intercept response.
  Function(Uint8List) interceptReadBytes({RequestData data}) {
    return null;
  }

  ///Intercept SEND request made by the `http.Client`.
  ///
  ///@param data `RequestData` containing url, body, headers and encoding.
  ///@returns A callback function used to intercept stream response.
  Function(http.StreamedResponse) interceptSend({http.BaseRequest request}) {
    return null;
  }
}

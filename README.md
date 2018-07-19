# http_middleware

A middleware library for Dart [http](https://pub.dartlang.org/packages/http) library.

## Getting Started

Middleware interface to create custom middleware for http.
Extend this class and override the functions that you want
to intercept.

Intercepting Requests: Every function takes in a RequestData as a parameter which
contains the url, body, headers and encoding from the request.

Intercepting Response: If you want to intercept response,
return a Function(http.Response) from the intercepted function.
You are returning a callback which will be called when the response
is received.

Example (Simple logging):
```dart
class CustomMiddleWare extends MiddlewareContract {
   @override
   Function(http.Response) interceptPost({RequestData data}) {
       print("POST Url: ${data.url}");
       return (response) {
           print("POST Status: ${response.body}");
       };
   }
}
```
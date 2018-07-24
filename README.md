# http_middleware

A middleware library for Dart [`http`](https://pub.dartlang.org/packages/http) library.

## Getting Started

`http_middleware` is a module that lets you build middleware for Dart's [`http`](https://pub.dartlang.org/packages/http) package.

### Installing
Include this library in your package.
```yaml
http_middleware: any
```

### Importing
```dart
import 'package:http_middleware/http_middleware.dart';
```

### Using `http_middleware`

Create an object of `HttpWithMiddleware` by using the `build` factory constructor.

The `build` constructor takes in a list of middlewares that are built for `http_middleware`. 
One very nice middleware you can use is the [`http_logger`](https://pub.dartlang.org/packages/http_logger) package. We will use that here for demonstration.

##### (You can also build your own middleware for `http_middleware`. Check out [Build your own middleware](#building-your-own-middleware))

```dart
HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
]);
```

That is it! Now go ahead and use this `http` object as you would normally do.
```dart
//Simple POST request
var response = await http.post('https://jsonplaceholder.typicode.com/posts/',
    body: {"testing", "1234"});

//Simple GET request
var response = await http.get('https://jsonplaceholder.typicode.com/posts/');
```

#### Request Timout
With `http_middleware` you can also specify the timeout of requests. So if you want a request to be timeout in 30 seconds:
```dart
HttpWithMiddleware http = HttpWithMiddleware.build(
  requestTimeout: Duration(seconds: 30),
  middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
]);
```

You need to catch the exception thrown to know if connection timed out.
 ```dart
try {
  var response = await http.get('https://jsonplaceholder.typicode.com/posts/');
} catch(e) {
  if (e is TimeoutException) {
    //Timed out
  }
}
```

`HttpWithMiddleware` supports all the functions that [`http`](https://pub.dartlang.org/packages/http) provides.

```dart
http.get(...);
http.post(...);
http.put(...);
http.delete(...);
http.head(...);
http.patch(...);
http.read(...);
http.readBytes(...);
```

#### Using a Client
If you want to use a `http.Client` in order to keep the connection alive with the server, use `HttpClientWithMiddleware`.
```dart
HttpClientWithMiddleware httpClient = HttpClientWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
]);

var response = await httpClient.post('https://jsonplaceholder.typicode.com/posts/',
    body: {"testing", "1234"});

var response = await httpClient.get('https://jsonplaceholder.typicode.com/posts/');

//Don't forget to close the client once done.
httpClient.close();
```

### Building your own middleware
Building your own middleware with `http_middleware` is very easy, whether you want to create a package for `http_middleware` or you want to build a middleware solely for your own project.

Once you have the necessary imports, all you have to do is extend the `MiddlewareContract` class which will give you access to 2 functions.

`interceptRequest(RequestData)` is the method called before any request is made. `interceptResponse(ResponseData)` is the method called after the response from request is received.

You can then `@override` all the required functions you need to add middleware to.

Example (A simple logger that logs data in all requests):
```dart
class Logger extends MiddlewareContract {
  @override
  interceptRequest({RequestData data}) {
    print("Method: ${data.method}");
    print("Url: ${data.url}");
    print("Body: ${data.body}");
  }

  @override
  interceptResponse({ResponseData data}) {
    print("Status Code: ${data.statusCode}");
    print("Method: ${data.method}");
    print("Url: ${data.url}");
    print("Body: ${data.body}");
    print("Headers: ${data.headers}");
  }
}
```

You can also modify the `RequestData` before the request is made and every `ResponseData` after every response is received. For Example, if you want to wrap your data in a particular structure before sending, or you want every request header to have `Content-Type` set to `application/json`.

```dart
class Logger extends MiddlewareContract {
  @override
  interceptRequest({RequestData data}) {
    //Adding content type to every request
    data.headers["Content-Type"] = "application/json";
    
    data.body = jsonEncode({
      uniqueId: "some unique id",
      data: data.body,
    });
  }

  @override
  interceptResponse({ResponseData data}) {
    //Unwrapping response from a structure
    data.body = jsonDecode(data.body)["data"];
  }
}
```

### Packages built on `http_middleware`

- [`http_logger`](https://github.com/gurleensethi/http_logger) : Easy request and response logging.


If your package uses `http_middleware`, [open an issue](https://github.com/gurleensethi/http_middleware/issues/new) and tell me, i will be happy to add it to the list.
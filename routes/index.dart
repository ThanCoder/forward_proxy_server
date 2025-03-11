import 'package:dart_frog/dart_frog.dart';
import 'package:dio/dio.dart' show Dio, Options, ResponseType;

final dio = Dio();

Future<Response> onRequest(RequestContext context) async {
  final targetUrl = context.request.uri.queryParameters['url'] ?? '';
  if (targetUrl.isEmpty) {
    return Response(body: 'provided url -> `?url=[request url]`');
  }

  // final res = await http.get(Uri.parse(targetUrl));

  // return Response(body: 'hello');

  // final proxyAddress = '192.168.191.253'; // Proxy IP or hostname
  // final proxyPort = 8080; // Proxy Port

  // dio.httpClientAdapter = IOHttpClientAdapter(
  //   createHttpClient: () {
  //     final client = HttpClient();
  //     client.findProxy = (uri) {
  //       // return "PROXY 192.168.191.253:8081";
  //       return "PROXY $proxyAddress:$proxyPort";
  //     };
  //     return client;
  //   },
  // );
  try {
    final res = await dio.get<List<int>>(
      targetUrl,
      options: Options(
        responseType: ResponseType.bytes,
      ), // Set the response type to `stream`.
    );
    return Response.bytes(
      body: res.data,
      statusCode: res.statusCode!,
      // headers: res.headers.map,
    );
  } catch (e) {
    return Response(body: 'error: ${e.toString()}');
  }
}

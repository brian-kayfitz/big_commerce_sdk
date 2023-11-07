import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'big_commerce_client.dart';

class EcommerceResponse {
  final dynamic data;
  final Map<String, String> headers;

  const EcommerceResponse(this.data, this.headers);
}

abstract class ECommerceClient {
  String get apiKeyHeaderName;
  final String apiKey;

  ECommerceClient({required this.apiKey});

  Uri buildUri(String path, [Map<String, String>? parameters]);

  Future<EcommerceResponse> send({
    required HTTPMethod method,
    required String path,
    Map? body,
    Map<String, String>? parameters,
  }) async {
    final headers = {
      apiKeyHeaderName: apiKey,
      'Content-Type': 'application/json; charset=utf-8'
    };

    final uri = buildUri(path, parameters);

    late Response response;
    // _logRequest(method, uri, headers, body);

    final json = body != null ? jsonEncode(body) : null;

    try {
      switch (method) {
        case HTTPMethod.get:
          response = await get(uri, headers: headers);
          break;

        case HTTPMethod.post:
          response = await post(
            uri,
            headers: headers,
            body: json,
          );
          break;

        case HTTPMethod.put:
          response = await put(
            uri,
            headers: headers,
            body: json,
          );
          break;

        case HTTPMethod.delete:
          response = await delete(uri, headers: headers);
          break;
      }
    } catch (e) {
      print(e);
      rethrow;
    }

    // _logResponse(response);

    if (response.statusCode >= HttpStatus.badRequest) {
      throw response;
    }

    dynamic data;

    try {
      data = jsonDecode(response.body);
    } catch (e) {
      data = {};
    }

    return EcommerceResponse(
      data,
      response.headers,
    );
  }

  void _logRequest(HTTPMethod method, Uri uri, Map<String, String> headers,
      Map<dynamic, dynamic>? body) {
    print('');
    print('$method - ${uri.toString()}');
    print('headers');
    print(headers);

    if (body != null) {
      print(JsonEncoder.withIndent('  ').convert(body));
    }
  }

  void _logResponse(Response response) {
    print('');
    print('Finished');
    print('status: ${response.statusCode}');
    print('headers:');
    for (final entry in response.headers.entries) {
      print('${entry.key}: ${entry.value}');
    }
    print(response.body);
  }
}

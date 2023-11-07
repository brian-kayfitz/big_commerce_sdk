import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

enum HTTPMethod {
  get,
  post,
  put,
  delete,
}

class BigCommerceClient {
  static const kHost = 'api.bigcommerce.com';
  static const kPathRoot = 'stores';

  final String storeId;
  final int apiVersion;

  final String apiKey;
  final BigCommerceRequestOptions defaultOptions;

  static const kTokenKey = 'X-Auth-Token';

  const BigCommerceClient({
    required this.storeId,
    required this.apiKey,
    required this.apiVersion,
    this.defaultOptions = const BigCommerceRequestOptions(limit: 250),
  });

  Uri buildUri(
    String? path,
    BigCommerceRequestOptions? options, [
    int? apiVersionOverride,
  ]) {
    return Uri(
      scheme: 'https',
      host: kHost,
      pathSegments: [
        kPathRoot,
        storeId,
        'v${apiVersionOverride ?? apiVersion}',
        if (path != null)
          if (path.contains('/')) ...path.split('/') else path,
      ],
    );
  }

  Future<dynamic> send({
    required HTTPMethod method,
    String? path,
    Object? body,
    bool fetchAllPages = false,
    int? apiVersionOverride,
    BigCommerceRequestOptions? options,
  }) async {
    final headers = {
      kTokenKey: apiKey,
      'content-type': 'application/json',
    };

    var uri = buildUri(
      path,
      options,
      apiVersionOverride,
    );

    if (method == HTTPMethod.get) {
      final useOptions =
          options != null ? options.copyWith(defaultOptions) : defaultOptions;
      uri = uri.replace(queryParameters: useOptions.toQueryParameters());
    }

    if (method == HTTPMethod.delete && options != null) {
      uri = uri.replace(queryParameters: options.toQueryParameters());
    }

    late Response response;
    print('');
    print('$method - ${uri.toString()}');
    final json = body != null ? jsonEncode(body) : null;

    if (json != null) {
      print(json);
    }

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

    _logResponse(response);

    if (response.statusCode == HttpStatus.created) {
      return {};
    }

    try {
      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode != HttpStatus.ok) {
        throw BigCommerceException(response.statusCode, jsonResponse);
      }

      if (fetchAllPages) {
        final pagination =
            Pagination.fromJson(jsonResponse['meta']['pagination']);
        if (pagination.totalPages > 1) {
          return _pullAllPages(
              jsonResponse: jsonResponse,
              method: method,
              path: path,
              body: body,
              pagination: pagination);
        }
        return jsonResponse['data'];
      }

      return jsonResponse;
    } catch (e) {
      if (response.statusCode != HttpStatus.noContent) {
        rethrow;
      }

      return {};
    }
  }

  void _logResponse(Response response) {
    print('');
    print('Finished');
    print('status: ${response.statusCode}');
    print(response.body);
  }

  Future _pullAllPages({
    required Map jsonResponse,
    required HTTPMethod method,
    String? path,
    Object? body,
    required Pagination pagination,
  }) async {
    final List data = jsonResponse['data'];
    for (int i = 2; i <= pagination.totalPages; i++) {
      final nextPage = await send(
        method: method,
        path: path,
        body: body,
        fetchAllPages: false,
        options: BigCommerceRequestOptions(page: i),
      );

      data.addAll(nextPage['data']);
    }

    return data;
  }
}

class BigCommerceException implements Exception {
  final int statusCode;
  final Map error;

  const BigCommerceException(this.statusCode, this.error) : super();

  @override
  String toString() {
    return 'BigCommerceException{statusCode: $statusCode, error: $error}';
  }
}

class BigCommerceRequestOptions {
  final int? page;
  final int? limit;
  final Map<String, String>? extras;

  const BigCommerceRequestOptions({
    this.page,
    this.limit,
    this.extras,
  });

  Map<String, dynamic> toQueryParameters() {
    return {
      if (page != null) 'page': page?.toString(),
      if (limit != null) 'limit': limit?.toString(),
      if (extras != null) ...extras!,
    };
  }

  BigCommerceRequestOptions copyWith(BigCommerceRequestOptions? other) {
    return BigCommerceRequestOptions(
      page: page ?? other?.page,
      limit: limit ?? other?.limit,
      extras: extras ?? other?.extras,
    );
  }
}

class Pagination {
  final int total;
  final int count;
  final int perPage;
  final int currentPage;
  final int totalPages;

  Pagination.fromJson(Map json)
      : total = json['total'],
        count = json['count'],
        perPage = json['per_page'],
        currentPage = json['current_page'],
        totalPages = json['total_pages'];
}

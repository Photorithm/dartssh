// Copyright 2019 dartssh developers
// Use of this source code is governed by a MIT-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html' as html;

import 'package:dartssh/http.dart';
import 'package:dartssh/transport.dart';

/// dart:html based alternative [HttpClient] implementation.
class HttpClientImpl extends HttpClient {
  static const String type = 'html';
  HttpClientImpl({StringCallback debugPrint}) : super(debugPrint: debugPrint);

  @override
  Future<HttpResponse> request(String url,
      {String method, String data, Map<String, String> headers}) {
    numOutstanding++;
    final Completer<HttpResponse> completer = Completer<HttpResponse>();
    html.HttpRequest.request(url, method: method, requestHeaders: headers)
        .then((r) {
      numOutstanding--;
      completer.complete(HttpResponse(r.status, text: r.responseText));
    });
    return completer.future;
  }
}

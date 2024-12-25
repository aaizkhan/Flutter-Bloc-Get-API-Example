import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_get_api_example/model/comment_model.dart';
import 'package:http/http.dart' as http;

class CommentsRepository {
  Future<List<CommentModel>> fetchComments() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
      final body = jsonDecode(response.body) as List;
      if (kDebugMode) {
        print(body.toString());
      }
      if (response.statusCode == 200) {
        return body.map((dynamic json) {
          final map = json as Map<String, dynamic>;
          return CommentModel(
            postId: map['postId'] as int,
            id: map['id'] as int,
            name: map['name'] as String,
            body: map['body'] as String,
          );
        }).toList();
      }
    } on SocketException {
      await Future.delayed(const Duration(milliseconds: 1800));
      throw Exception('No Internet Connection');
    } on TimeoutException {
      throw Exception('Timeout');
    }

    throw Exception('error fetching data');
  }
}

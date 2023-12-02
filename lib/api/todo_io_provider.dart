import 'dart:convert';
import 'dart:io';

import 'package:todotee_app/api/todo_provider.dart';
import 'package:todotee_app/constants.dart';
import 'package:todotee_app/dto/todo_request_dto.dart';
import 'package:todotee_app/dto/todo_response_dto.dart';

class TodoIoProvider implements TodoProvider {
  static const String _path = 'todos';

  final HttpClient client;

  TodoIoProvider({required this.client});

  @override
  Future<TodoResponseDto> create(TodoRequestDto body) async {
    Uri uri = Uri.parse("${Constants.apiRoute}/$_path");
    HttpClientRequest request = await client.postUrl(uri);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(body));

    HttpClientResponse response = await request.close();

    final String jsonString = await response.transform(utf8.decoder).join();
    final Map<String, dynamic> responseBody = jsonDecode(jsonString);

    return TodoResponseDto.fromJson(responseBody);
  }

  @override
  Future<List<TodoResponseDto>> getTodos() async {
    Uri uri = Uri.parse("${Constants.apiRoute}/$_path");
    HttpClientRequest request = await client.getUrl(uri);

    HttpClientResponse response = await request.close();

    final String jsonString = await response.transform(utf8.decoder).join();
    final List<Map<String, dynamic>> responseBody = jsonDecode(jsonString);

    return responseBody.map(TodoResponseDto.fromJson).toList();
  }

  @override
  Future<TodoResponseDto> getTodoById(int id) async {
    Uri uri = Uri.parse('${Constants.apiRoute}/$_path/$id');
    HttpClientRequest request = await client.getUrl(uri);

    HttpClientResponse response = await request.close();

    final String jsonString = await response.transform(utf8.decoder).join();
    final Map<String, dynamic> responseBody = jsonDecode(jsonString);

    return TodoResponseDto.fromJson(responseBody);
  }

  @override
  Future modifyTodo(int id, TodoRequestDto body) async {
    Uri uri = Uri.parse('${Constants.apiRoute}/$_path/$id');
    HttpClientRequest request = await client.patchUrl(uri);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(body));

    await request.close();
  }

  @override
  Future deleteTodoById(int id) async {
    Uri uri = Uri.parse('${Constants.apiRoute}/$_path/$id');
    HttpClientRequest request = await client.deleteUrl(uri);

    await request.close();
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:todotee_app/api/todo_provider.dart';
import 'package:todotee_app/dto/todo_request_dto.dart';
import 'package:todotee_app/dto/todo_response_dto.dart';

class TodoDioProvider implements TodoProvider {
  static const String _path = 'todos';

  final Dio _client;

  TodoDioProvider({required Dio client}) : _client = client;

  @override
  Future<TodoResponseDto> create(TodoRequestDto body) async {
    try {
      Response response = await _client.post('/$_path', data: body.toJson());
      Map<String, dynamic> responseBody = jsonDecode(response.data);
      return TodoResponseDto.fromJson(responseBody);
    } on DioException catch (e) {
      if (e.response != null) {
        rethrow;
      } else {
        throw Exception('데이터 요청에 실패하였습니다.');
      }
    }
  }

  @override
  Future<List<TodoResponseDto>> getTodos() async {
    try {
      Response response = await _client.get('/$_path');
      List<Map<String, dynamic>> responseBody = jsonDecode(response.data);
      return responseBody.map(TodoResponseDto.fromJson).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        rethrow;
      } else {
        throw Exception('데이터 요청에 실패하였습니다.');
      }
    }
  }

  @override
  Future<TodoResponseDto> getTodoById(int id) async {
    try {
      Response response = await _client.get('/$_path/$id');
      Map<String, dynamic> responseBody = jsonDecode(response.data);
      return TodoResponseDto.fromJson(responseBody);
    } on DioException catch (e) {
      if (e.response != null) {
        rethrow;
      } else {
        throw Exception('데이터 요청에 실패하였습니다.');
      }
    }
  }

  @override
  Future modifyTodo(int id, TodoRequestDto body) async {
    try {
      await _client.patch('/$_path/$id', data: body.toJson());
    } on DioException catch (e) {
      if (e.response != null) {
        rethrow;
      } else {
        throw Exception('데이터 요청에 실패하였습니다.');
      }
    }
  }

  @override
  Future deleteTodoById(int id) async {
    try {
      await _client.delete('/$_path/$id');
    } on DioException catch (e) {
      if (e.response != null) {
        rethrow;
      } else {
        throw Exception('데이터 요청에 실패하였습니다.');
      }
    }
  }
}

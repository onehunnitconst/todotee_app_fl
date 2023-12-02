import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:todotee_app/api/memo_provider.dart';
import 'package:todotee_app/dto/memo_request_dto.dart';
import 'package:todotee_app/dto/memo_response_dto.dart';

class MemoDioProvider implements MemoProvider {
  static const String _path = 'memos';

  final Dio _client;

  MemoDioProvider({required Dio client}) : _client = client;

  @override
  Future<MemoResponseDto> create(MemoRequestDto body) async {
    try {
      Response response = await _client.post('/$_path', data: body.toJson());
      Map<String, dynamic> responseBody = jsonDecode(response.data);
      return MemoResponseDto.fromJson(responseBody);
    } on DioException catch (e) {
      if (e.response != null) {
        rethrow;
      } else {
        throw Exception('데이터 요청에 실패하였습니다.');
      }
    }
  }

  @override
  Future<List<MemoResponseDto>> getMemos() async {
    try {
      Response response = await _client.get('/$_path');
      List<Map<String, dynamic>> responseBody = jsonDecode(response.data);
      return responseBody.map(MemoResponseDto.fromJson).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        rethrow;
      } else {
        throw Exception('데이터 요청에 실패하였습니다.');
      }
    }
  }

  @override
  Future<MemoResponseDto> getMemoById(int id) async {
    try {
      Response response = await _client.get('/$_path/$id');
      Map<String, dynamic> responseBody = jsonDecode(response.data);
      return MemoResponseDto.fromJson(responseBody);
    } on DioException catch (e) {
      if (e.response != null) {
        rethrow;
      } else {
        throw Exception('데이터 요청에 실패하였습니다.');
      }
    }
  }

  @override
  Future modifyMemo(int id, MemoRequestDto body) async {
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
  Future deleteMemoById(int id) async {
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

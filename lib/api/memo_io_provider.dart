import 'dart:convert';
import 'dart:io';

import 'package:todotee_app/api/memo_provider.dart';
import 'package:todotee_app/constants.dart';
import 'package:todotee_app/dto/memo_request_dto.dart';
import 'package:todotee_app/dto/memo_response_dto.dart';

class MemoIoProvider implements MemoProvider {
  static const String _path = 'memos';

  final HttpClient client;

  MemoIoProvider({required this.client});

  @override
  Future<MemoResponseDto> create(MemoRequestDto body) async {
    Uri uri = Uri.parse("${Constants.apiRoute}/$_path");
    HttpClientRequest request = await client.postUrl(uri);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(body));

    HttpClientResponse response = await request.close();

    final String jsonString = await response.transform(utf8.decoder).join();
    final Map<String, dynamic> responseBody = jsonDecode(jsonString);

    return MemoResponseDto.fromJson(responseBody);
  }

  @override
  Future<List<MemoResponseDto>> getMemos() async {
    Uri uri = Uri.parse("${Constants.apiRoute}/$_path");
    HttpClientRequest request = await client.getUrl(uri);

    HttpClientResponse response = await request.close();

    final String jsonString = await response.transform(utf8.decoder).join();
    final List<Map<String, dynamic>> responseBody = jsonDecode(jsonString);

    return responseBody.map(MemoResponseDto.fromJson).toList();
  }

  @override
  Future<MemoResponseDto> getMemoById(int id) async {
    Uri uri = Uri.parse('${Constants.apiRoute}/$_path/$id');
    HttpClientRequest request = await client.getUrl(uri);

    HttpClientResponse response = await request.close();

    final String jsonString = await response.transform(utf8.decoder).join();
    final Map<String, dynamic> responseBody = jsonDecode(jsonString);

    return MemoResponseDto.fromJson(responseBody);
  }

  @override
  Future modifyMemo(int id, MemoRequestDto body) async {
    Uri uri = Uri.parse('${Constants.apiRoute}/$_path/$id');
    HttpClientRequest request = await client.patchUrl(uri);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(body));

    await request.close();
  }

  @override
  Future deleteMemoById(int id) async {
    Uri uri = Uri.parse('${Constants.apiRoute}/$_path/$id');
    HttpClientRequest request = await client.deleteUrl(uri);

    await request.close();
  }
}

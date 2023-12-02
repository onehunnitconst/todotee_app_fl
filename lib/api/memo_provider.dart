import '../dto/memo_request_dto.dart';
import '../dto/memo_response_dto.dart';

abstract class MemoProvider {
  Future<MemoResponseDto> create(MemoRequestDto body);
  Future<List<MemoResponseDto>> getMemos();
  Future<MemoResponseDto> getMemoById(int id);
  Future modifyMemo(int id, MemoRequestDto body);
  Future deleteMemoById(int id);
}

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotee_app/api/memo_provider.dart';

import '../../../dto/memo_response_dto.dart';
import 'memo_event.dart';
import 'memo_state.dart';

class MemoBloc extends Bloc<MemoEvent, MemoState> {
  final MemoProvider memoProvider;

  MemoBloc({required this.memoProvider}) : super(MemoStateInit()) {
    on<MemoEventInitialize>((event, emit) {
      emit(MemoStateInit());
    });

    on<GetMemosEvent>((event, emit) async {
      emit(MemoStateLoading(memoList: state.memoList));
      try {
        final List<MemoResponseDto> memoList = await memoProvider.getMemos();
        emit(MemoStateSuccess(memoList: memoList));
      } catch (error) {
        _processError(error, emit);
      }
    });

    on<CreateMemoEvent>((event, emit) async {
      emit(MemoStateLoading(memoList: state.memoList));
      try {
        final MemoResponseDto createdMemo =
            await memoProvider.create(event.body);
        state.memoList.add(createdMemo);
        emit(MemoStateSuccess(memoList: state.memoList));
      } catch (error) {
        _processError(error, emit);
      }
    });

    on<ModifyMemoEvent>((event, emit) async {
      emit(MemoStateLoading(memoList: state.memoList));
      try {
        await memoProvider.modifyMemo(event.id, event.body);

        final int index =
            state.memoList.indexWhere((element) => element.id == event.id);
        final MemoResponseDto modifiedMemo =
            await memoProvider.getMemoById(event.id);
        state.memoList[index] = modifiedMemo;

        emit(MemoStateSuccess(memoList: state.memoList));
      } catch (error) {
        _processError(error, emit);
      }
    });

    on<DeleteMemoEvent>((event, emit) async {
      emit(MemoStateLoading(memoList: state.memoList));
      try {
        await memoProvider.deleteMemoById(event.id);
        final int index =
            state.memoList.indexWhere((element) => element.id == event.id);
        state.memoList.removeAt(index);
        emit(MemoStateSuccess(memoList: state.memoList));
      } catch (error) {
        _processError(error, emit);
      }
    });
  }

  void _processError(Object error, Emitter<MemoState> emit) {
    if (kDebugMode) {
      print(error);
    }
    emit(MemoStateError(error: error));
  }
}

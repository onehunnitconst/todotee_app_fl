import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotee_app/pages/memo_detail/bloc/memo_detail_event.dart';
import 'package:todotee_app/pages/memo_detail/bloc/memo_detail_state.dart';

import '../../../api/memo_io_provider.dart';
import '../../../dto/memo_response_dto.dart';

class MemoDetailBloc extends Bloc<MemoDetailEvent, MemoDetailState> {
  final MemoIoProvider memoApi;

  MemoDetailBloc({required this.memoApi}) : super(MemoDetailStateInit()) {
    on<MemoEventInitialize>((event, emit) {
      emit(MemoDetailStateInit());
    });

    on<GetMemoEvent>((event, emit) async {
      emit(MemoDetailStateLoading(memo: state.memo));
      try {
        final MemoResponseDto memo = await memoApi.getMemoById(event.id);
        emit(MemoDetailStateSuccess(memo: memo));
      } catch (error) {
        _processError(error, emit);
      }
    });
  }

  void _processError(Object error, Emitter<MemoDetailState> emit) {
    if (kDebugMode) {
      print(error);
    }
    emit(MemoDetailStateError(error: error));
  }
}

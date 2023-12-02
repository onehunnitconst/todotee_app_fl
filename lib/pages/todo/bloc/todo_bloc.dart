import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotee_app/api/todo_provider.dart';
import 'package:todotee_app/pages/todo/bloc/todo_event.dart';
import 'package:todotee_app/pages/todo/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoProvider todoProvider;

  TodoBloc({required this.todoProvider}) : super(TodoStateInit()) {
    on<GetTodosEvent>((event, emit) async {
      emit(TodoStateLoading(todoList: state.todoList));
      try {
        final todoList = await todoProvider.getTodos();
        emit(TodoStateSuccess(todoList: todoList));
      } catch (error) {
        _processError(error, emit);
      }
    });

    on<CreateTodoEvent>((event, emit) async {
      emit(TodoStateLoading(todoList: state.todoList));
      try {
        final newTodo = await todoProvider.create(event.body);
        state.todoList.add(newTodo);
        emit(TodoStateSuccess(todoList: state.todoList));
      } catch (error) {
        _processError(error, emit);
      }
    });

    on<ModifyTodoEvent>((event, emit) async {
      emit(TodoStateLoading(todoList: state.todoList));
      try {
        await todoProvider.modifyTodo(event.id, event.body);
        final int index =
            state.todoList.indexWhere((element) => element.id == event.id);
        final modifiedTodo = await todoProvider.getTodoById(event.id);
        state.todoList[index] = modifiedTodo;
        emit(TodoStateSuccess(todoList: state.todoList));
      } catch (error) {
        _processError(error, emit);
      }
    });

    on<DeleteTodoEvent>((event, emit) async {
      emit(TodoStateLoading(todoList: state.todoList));
      try {
        await todoProvider.deleteTodoById(event.id);
        final int index =
            state.todoList.indexWhere((element) => element.id == event.id);
        state.todoList.removeAt(index);
        emit(TodoStateSuccess(todoList: state.todoList));
      } catch (error) {
        _processError(error, emit);
      }
    });
  }

  void _processError(Object error, Emitter<TodoState> emit) {
    if (kDebugMode) {
      print(error);
    }
    emit(TodoStateError(error: error));
  }
}

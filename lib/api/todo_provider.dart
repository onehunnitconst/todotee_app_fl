import '../dto/todo_request_dto.dart';
import '../dto/todo_response_dto.dart';

abstract class TodoProvider {
  Future<TodoResponseDto> create(TodoRequestDto body);
  Future<List<TodoResponseDto>> getTodos();
  Future<TodoResponseDto> getTodoById(int id);
  Future modifyTodo(int id, TodoRequestDto body);
  Future deleteTodoById(int id);
}

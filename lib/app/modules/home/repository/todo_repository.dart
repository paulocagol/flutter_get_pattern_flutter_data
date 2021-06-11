import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_get_pattern_flutter_data/app/modules/home/model/todo/todo_model.dart';
import 'package:flutter_get_pattern_flutter_data/app/modules/home/providers/todo_provider.dart';
import 'package:meta/meta.dart';

class TodoRepository {
  final TodoProvider _todoProvider;

  TodoRepository(this._todoProvider) : assert(_todoProvider != null);

  Future<Repository<Todo>> get repository async {
    return await _todoProvider.todoRepositoryProvider;
  }
}

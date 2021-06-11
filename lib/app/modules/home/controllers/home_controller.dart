import 'dart:math';

import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_get_pattern_flutter_data/app/modules/home/model/todo/todo_model.dart';
import 'package:flutter_get_pattern_flutter_data/app/modules/home/repository/todo_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TodoRepository _todoRepository;

  HomeController(this._todoRepository) : assert(_todoRepository != null);

  Rx<Repository<Todo>> _repository = Repository<Todo>(null).obs;

  @override
  void onInit() async {
    print('onInit()');
    _repository.value = await _todoRepository.repository;
    super.onInit();
  }

  Future<RxList<Todo>> getAll() async {
    print('getAll()');
    var todoList = await _repository.value.findAll(remote: false, syncLocal: false);
    return todoList.obs;
  }

  addTodoRandom() async {
    var id = Random().nextInt(999);
    await _repository.value.save(
      Todo(
        id: id,
        title: 'Task $id',
      ),
      remote: false,
    );
    _repository.refresh();
  }

  saveTodo(Todo todo) async {
    await _repository.value.save(
      todo,
      remote: false,
    );
    _repository.refresh();
  }

  deleteAll() async {
    print('deleteAll()');
    await _repository.value.clear();
    _repository.refresh();
  }

  delete(Todo todo) async {
    await _repository.value.delete(todo, remote: false);
    _repository.refresh();
  }
}

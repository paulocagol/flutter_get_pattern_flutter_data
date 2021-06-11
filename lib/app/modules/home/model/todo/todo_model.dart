import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_data_json_api_adapter/flutter_data_json_api_adapter.dart';
import 'package:flutter_get_pattern_flutter_data/app/modules/home/model/todo/adapter/todo_adapter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
@DataRepository([JSONTodoServerAdapter])
class Todo with DataModel<Todo> {
  final int id;
  final String title;
  final bool completed;
  final int userId;

  Todo({
    this.id,
    this.title,
    this.completed,
    this.userId,
  });
}

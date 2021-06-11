import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_get_pattern_flutter_data/app/modules/home/model/todo/todo_model.dart';

mixin JSONTodoServerAdapter on RemoteAdapter<Todo> {

  @override
  String get baseUrl => 'https://my-json-server.typicode.com/flutterdata/demo';
  
  @override
  String get identifierSuffix => 'Id';
}

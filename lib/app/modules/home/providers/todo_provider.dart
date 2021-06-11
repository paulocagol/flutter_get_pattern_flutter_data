import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_get_pattern_flutter_data/app/modules/home/model/todo/todo_model.dart';

class TodoProvider {
  final Future<ProviderContainer> Function() _providerContainerFn;

  TodoProvider(this._providerContainerFn) : assert(_providerContainerFn != null);

  Future<Repository<Todo>> get todoRepositoryProvider async {
    var provider = await _providerContainerFn();
    return await provider.read(todosRepositoryProvider);
  }
}

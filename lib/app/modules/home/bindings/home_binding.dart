import 'package:flutter_get_pattern_flutter_data/app/data/container/container_data.dart';
import 'package:flutter_get_pattern_flutter_data/app/modules/home/providers/todo_provider.dart';
import 'package:flutter_get_pattern_flutter_data/app/modules/home/repository/todo_repository.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        TodoRepository(
          TodoProvider(
            () async => await ContainerData.instace.providerContainer,
          ),
        ),
      ),
    );
  }
}

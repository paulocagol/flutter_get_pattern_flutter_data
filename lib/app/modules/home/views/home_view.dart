import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_get_pattern_flutter_data/app/modules/home/model/todo/todo_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:random_color/random_color.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              await controller.deleteAll();

              // await controller.repository.value.clear();
              // controller.repository.refresh();
            },
            icon: Icon(Icons.delete),
            label: Text(''),
          ),
        ],
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Container(
        child: Obx(
          () => FutureBuilder(
            future: controller.getAll(),
            builder: (context, AsyncSnapshot<RxList<Todo>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    child: Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: RandomColor().randomColor(),
                          child: Text(snapshot.data[index].id.toString()),
                          foregroundColor: Colors.white,
                        ),
                        title: Text(snapshot.data[index].title),
                      ),
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Editar',
                        color: Colors.black45,
                        icon: Icons.more_horiz,
                        onTap: () {
                          _controller.clear();
                          var _todo = snapshot.data[index];

                          Get.defaultDialog(
                            title: 'Editando tarefa número ${_todo.id}',
                            cancel: IconButton(
                              icon: Icon(Icons.cancel),
                              onPressed: () => Get.back(),
                            ),
                            confirm: IconButton(
                              icon: Icon(Icons.save),
                              onPressed: () {
                                print(_todo);
                                controller.saveTodo(
                                  Todo(
                                    id: _todo.id,
                                    title: _controller.text,
                                    completed: false,
                                  ),
                                );
                                Get.back();
                              },
                            ),
                            content: Container(
                              child: Center(
                                child: TextField(
                                  controller: _controller,
                                  onSubmitted: (value) {
                                    print(_todo);
                                    controller.saveTodo(
                                      Todo(
                                        id: _todo.id,
                                        title: value,
                                        completed: false,
                                      ),
                                    );
                                    Get.back();
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      IconSlideAction(
                        caption: 'Deletar',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () async {
                          var todo = snapshot.data[index];
                          await controller.delete(todo);
                          Get.showSnackbar(
                            GetBar(
                              duration: Duration(seconds: 1),
                              animationDuration: Duration(seconds: 1),
                              snackPosition: SnackPosition.BOTTOM,
                              message: 'Todo ${todo.id} deletado!!',
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: 'Adicionando tarefa',
            cancel: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () => Get.back(),
            ),
            confirm: IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                controller.saveTodo(
                  Todo(
                    id: Random().nextInt(999),
                    title: _controller.text,
                    completed: false,
                  ),
                );
                Get.back();
              },
            ),
            content: Container(
              child: Center(
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    controller.saveTodo(
                      Todo(
                        id: Random().nextInt(999),
                        title: value,
                        completed: false,
                      ),
                    );
                    Get.back();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

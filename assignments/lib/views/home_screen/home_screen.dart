import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignments/controllers/controller/task_controller.dart';
import 'package:assignments/views/home_screen/home_screen_widgets.dart';
import 'package:uuid/uuid.dart';

import '../../models/task_model/task_model.dart';

class HomeScreen extends StatelessWidget {
  final TaskController controller = Get.put(TaskController());
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController updateEditingController = TextEditingController();
  final Uuid uuid = const Uuid();
  final _key = GlobalKey<FormState>();
  final _updateKey = GlobalKey<FormState>();
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var view = HomeScreenWidgets(context, controller);
    return Scaffold(
      backgroundColor: Color(0xfff3f3f3),
      appBar: view.appBar(
        onAddTap: () {
          openAddNewTaskBottomSheet(context);
        },
      ),
      body: Column(
        children: [
          view.filterWidget(),
          Expanded(
            child: Obx(() {
              if (controller.filteredTodos.isEmpty) {
                return Center(
                  child: Text(
                      "${controller.filter.value.name.capitalize} Tasks Not Available"),
                );
              }
              return ListView.builder(
                  itemCount: controller.filteredTodos.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var task = controller.filteredTodos[index];
                    return view.taskWidget(
                        task: task,
                        index: index,
                        onEditTap: () {
                          updateEditingController.text = task.title;
                          onEditTaskTap(context, task, index);
                        },
                        onDeleteTap: () {
                          onDeleteTaskTap(context, task);
                        });
                  });
            }),
          ),
        ],
      ),
    );
  }

  void openAddNewTaskBottomSheet(BuildContext context) {
    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Form(
                key: _key,
                child: FadeInUp(
                  duration: Duration(seconds: 2),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "ADD TASK",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Task";
                                }
                                return null;
                              },
                              controller: titleEditingController,
                              decoration: InputDecoration(
                                labelText: 'Enter Task',
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            MaterialButton(
                              color: Colors.blueAccent,
                              onPressed: () {
                                if (_key.currentState!.validate()) {
                                  // if (titleEditingController.text.isNotEmpty) {
                                  controller.addToDo(
                                    TaskModel(
                                      id: uuid.v4(),
                                      title: titleEditingController.text,
                                    ),
                                  );
                                  titleEditingController.clear();
                                  Get.back();
                                  Get.snackbar('Task Added Successfully', '');
                                }
                              },
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))),
      ),
      isScrollControlled: true,
    );
  }

  void onDeleteTaskTap(BuildContext context, TaskModel todo) {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("Delete Task !"),
              content: Text("Are you sure you want to delete this task ?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      controller.deleteToDo(todo.id);
                      Get.snackbar("Deleted Successfully", '');
                      Navigator.pop(context);
                    },
                    child: Text("Confirm")),
              ],
            ));
  }

  void onEditTaskTap(BuildContext context, TaskModel todo, int index) {
    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Form(
                key: _updateKey,
                child: FadeInUp(
                  duration: Duration(seconds: 2),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Update Task",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Task";
                                }
                                return null;
                              },
                              controller: updateEditingController,
                              decoration: InputDecoration(
                                labelText: 'Enter Task',
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            MaterialButton(
                              color: Colors.blueAccent,
                              onPressed: () {
                                if (_updateKey.currentState!.validate()) {
                                  // if (titleEditingController.text.isNotEmpty) {
                                  controller.updateToDo(
                                      TaskModel(
                                          id: todo.id,
                                          title: updateEditingController.text,
                                          isDone: todo.isDone),
                                      index);
                                  updateEditingController.clear();
                                  Get.back();
                                  Get.snackbar('Task Update Successfully', '');
                                }
                              },
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))),
      ),
      isScrollControlled: true,
    );
  }
}

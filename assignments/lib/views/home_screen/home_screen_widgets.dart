import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignments/models/task_model/task_model.dart';
import '../../controllers/controller/task_controller.dart';

class HomeScreenWidgets{
  BuildContext context;
  TaskController controller;
  HomeScreenWidgets(this.context,this.controller);

  AppBar appBar({required VoidCallback onAddTap})=>AppBar(
    leading: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Hero(
        tag: "app_logo",
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 40,
          child: Icon(
            Icons.task,
            color: Colors.blueAccent,
            size: 40,
          ),
        ),
      ),
    ),
    leadingWidth: 90,
    title: const Text(
      'TODO APP',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.blueAccent,
    actions: [
      ElevatedButton.icon(
        onPressed: onAddTap,
        label: Text("Add"),
        icon: Icon(Icons.add),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7)),
            backgroundColor: Colors.white),
      ),
      const SizedBox(
        width: 10,
      )
    ],
  );

  Widget filterWidget() {
   return Padding(
      padding: const EdgeInsets.only(left: 5.0,top: 15,bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text("Filter"),
          const SizedBox(
            width: 5,
          ),
          const Icon(Icons.filter_alt),
          const SizedBox(
            width: 5,
          ),
          PopupMenuButton(
            color: Colors.blueAccent,
            offset: Offset(0, 40),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  "All",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  controller.updateFilter(Filter.all);
                },
              ),
              PopupMenuItem(
                  child: Text("InCompleted",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    controller.updateFilter(Filter.incomplete);
                  }),
              PopupMenuItem(
                  child: Text("Completed",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {controller.updateFilter(Filter.completed);}),
            ],
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border.all(color: Colors.blue.withOpacity(0.7)),
                  borderRadius: BorderRadius.circular(5)),
              child: Obx(() {
                return Text(
                  controller.filter.value.name.capitalize.toString(),
                  style: TextStyle(color: Colors.white),
                );
              }),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

  Widget taskWidget({required TaskModel task, required int index, required VoidCallback onEditTap, required onDeleteTap}) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Colors.blueAccent.withOpacity(0.3))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(6),
                          border: Border.all(
                              width: 1.2,
                              color: task.isDone
                                  ? Colors.green
                                  .withOpacity(0.3)
                                  : Colors.blueAccent
                                  .withOpacity(0.3))),
                      child: Text(
                        task.isDone
                            ? "Completed"
                            : "InComplete",
                        style: TextStyle(
                            color: task.isDone
                                ? Colors.green
                                : Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      )),
                  PopupMenuButton(
                    color: Colors.blueAccent,
                    offset: Offset(0, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    itemBuilder: (context) => [
                      PopupMenuItem(  child: Text("Edit",style: TextStyle(color: Colors.white),),onTap: onEditTap,),
                      PopupMenuItem(  child: Text("Delete",style: TextStyle(color: Colors.white),),onTap: onDeleteTap,),

                    ],),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0),
                child: Text(
                  "Task",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 0),
                      child: Text(
                        "${task.title.capitalize}",
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 190,
                    child: CheckboxListTile(
                        value: task.isDone,
                        activeColor: Colors.blueAccent,
                        title: Text(
                            "${task.isDone ? "Completed" : "InComplete"}"),
                        onChanged: (value) {
                          controller.updateToDoStatus(
                              task.id, value!);
                        }),
                  )
                ],
              ),
            ],
          ),
        ));
  }

}
import 'package:flutter/material.dart';
import 'package:todo_app/utils/components/button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({Key? key,required this.controller,required this.onCancel,required this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFFFFCACA),
      content: Container(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1,color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Add a new ToDo",
                  hintStyle: TextStyle(
                    color: Colors.black
                  )
                ),

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  ButtonWidget(buttonName: "Save",onPressed: onSave),
                  ButtonWidget(buttonName: "Cancel",onPressed: onCancel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

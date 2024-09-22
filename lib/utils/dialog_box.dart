import 'package:flutter/material.dart';
import 'package:todo/utils/my_button.dart';
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      backgroundColor: Colors.blue[100],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none
                ),
                hintText: "Add a new task",
              ),
            ),

            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                MyButton(onPressed: onSave, text: "Save"),

                SizedBox(width: 10,),

                //cancel button
                MyButton(onPressed: onCancel, text: "Cancel"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

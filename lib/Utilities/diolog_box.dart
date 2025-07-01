import 'package:flutter/material.dart';
import 'package:stateless_and_statefull/Utilities/Mybutton.dart';

class DiologBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onsave;
  final VoidCallback oncancel;

  const DiologBox({
    super.key,
    required this.controller,
    required this.onsave,
    required this.oncancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amber[200],
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a new task',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Mybutton(text: 'Save', onpressed: onsave),
                const SizedBox(width: 10),
                Mybutton(text: 'Cancel', onpressed: oncancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

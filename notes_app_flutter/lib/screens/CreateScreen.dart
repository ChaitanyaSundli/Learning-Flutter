import 'package:flutter/material.dart';

import '../services/ApiClient.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final api = ApiClient.api;
  final titleController = TextEditingController();
  final messageController = TextEditingController();
  var isPinned = false;
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2021, 7, 25),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }

  void save() async {
    await api.createNote({
      "note": {
        "title": titleController.text,
        "message": messageController.text,
      },
    });

    Navigator.pop(context);
  }

  Color getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.pressed,
      WidgetState.hovered,
      WidgetState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Theme.of(context).colorScheme.surfaceContainerHighest;
    }
    return Theme.of(context).colorScheme.surfaceContainerLowest;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note Details"),
        centerTitle: true,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Category"),
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      checkColor: Colors.white,
                      fillColor: WidgetStateProperty.resolveWith(getColor),
                      value: isPinned,
                      onChanged: (bool? value) {
                        setState(() {
                          isPinned = value!;
                        });
                      },
                    ),
                  ),
                  Text("Pin Note"),
                ],
              ),
              OutlinedButton.icon(
                onPressed: _selectDate,
                icon: const Icon(Icons.calendar_month),
                label: const Text('Add Reminder'),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

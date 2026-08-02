import 'package:alarm_app/alarm_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlarmHomeScreen extends StatelessWidget {
  AlarmHomeScreen({super.key});

  final AlarmController alarmController = AlarmController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alarm App'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: alarmController.titleController,
              decoration: InputDecoration(
                labelText: 'Alarm Title',
                border: OutlineInputBorder(),
                prefix: Icon(Icons.title),
              ),
            ),

            SizedBox(height: 30),
            // Time Display
            Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Obx(
                  () => Text(
                    'Selected Time: ${alarmController.selectedTime.value.format(context)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Button to open Time Picker
            ElevatedButton.icon(
              onPressed: () => alarmController.pickTime(context),
              icon: Icon(Icons.access_time),
              label: Text('Select Time'),
            ),
            SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: alarmController.setAlarm,
              child: Text(
                'Save & Enable Alarm',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlarmTriggeredScreen extends StatelessWidget {
  const AlarmTriggeredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.alarm_on, size: 120, color: Colors.white),
              SizedBox(height: 30),
              Text(
                'WAKE UP!',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your scheduled alarm is ringing.',
                style: TextStyle(fontSize: 18, color: Colors.white70),
              ),
              SizedBox(height: 60),

              // Dismiss button to turn off the screen
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'DISMISS',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

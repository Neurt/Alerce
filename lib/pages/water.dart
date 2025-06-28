import 'dart:async';
import 'package:flutter/material.dart';

class WaterReminder extends StatefulWidget {
  @override
  _WaterReminderState createState() => _WaterReminderState();
}

class _WaterReminderState extends State<WaterReminder> {
  int glassesDrunk = 0;
  Timer? reminderHour;

  @override
  void initState() {
    super.initState();
    reminderHour = Timer.periodic(const Duration(hours: 2), (Timer timer) {

      setState(() {
        glassesDrunk++;
      });
    });
  }

  @override
  void dispose() {
    reminderHour?.cancel();
    super.dispose();
  }

  void drinkWater() {
    setState(() {
      glassesDrunk++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Glasses Drunk: $glassesDrunk",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: drinkWater,
              child: const Text("Drink Water"),
            ),
          ],
        ),
      ),
    );
  }
}


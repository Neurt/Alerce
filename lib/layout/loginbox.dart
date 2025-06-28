import 'package:flutter/material.dart';
import 'package:alerce1/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alerce1/colour.dart';

class LoginBox extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController sicknessController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: mainBlue,
        ),
        width: 200,
        height: 300,
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: '', 
                hintStyle: TextStyle(color: Colors.white), 
                labelText: 'Name', 
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20,),
            TextField(
              controller: ageController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: '', 
                hintStyle: TextStyle(color: Colors.white), 
                labelText: 'Age', 
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: sicknessController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: '', 
                hintStyle: TextStyle(color: Colors.white), 
                labelText: 'Sickness', 
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                String username = usernameController.text;
                String sickness = sicknessController.text;
                String age = ageController.text;

                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      username: username,
                      age: age,
                      sickness: sickness)
                  )
                );
              },
              child: Text(
                'Login',
                style: GoogleFonts.openSans(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

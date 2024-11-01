import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showCustomSnackBar(BuildContext context, String title, String subTitle, Color color, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          height: 110,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(title, style: TextStyle(fontSize: 20, color: Colors.white)),
                  SizedBox(width: 10),
                  Icon(icon, color: Colors.white),
                ],
              ),
              Text(subTitle, style: TextStyle(fontSize: 15, color: Colors.white)),
            ],
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
}


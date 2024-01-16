import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteCube extends StatelessWidget {
  final String date;
  final String title;
  final VoidCallback function;

  NoteCube({required this.date, required this.title, required this.function });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: function,
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.brown.withOpacity(0.5),width: 1),
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0xFFE5DCC4), // Adjust the color as needed
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$date',
              ),
              SizedBox(height: 8.0),
              Text(
                '$title',
                style: TextStyle(
                  color: Colors.white, // Adjust the color as needed
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
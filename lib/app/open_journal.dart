import 'package:deardiary/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OpenJournal extends StatelessWidget {
  final String title;
  final String body;
  final String date;
  OpenJournal({required this.title, required this.body, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFDF1E3),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.push_pin),
            onPressed: () {
              // Handle pin button tap
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          //background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/newJournal2.png'),
                fit: BoxFit.cover, // fit as needed
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  // You can fetch today's date using a date/time library
                  '$date',
                  style: NewJournalStyles.kheader,
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  Text(
                  '$title',
                  style: NewJournalStyles.ktitle,
                  ), //title
                  SizedBox(height: 10,),
                  Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                      border: Border.all(
                        color: Colors.black26, // Adjust the border color
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Text('$body',
                           style: NewJournalStyles.kjournal,
                      ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

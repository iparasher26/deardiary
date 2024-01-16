import 'package:flutter/material.dart';

class ViewJournal extends StatelessWidget {
  final TextEditingController dateController;
  final TextEditingController titleController;

  const ViewJournal({
    Key? key,
    required this.dateController,
    required this.titleController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width / 3,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFFDF1E3),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Title:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

  // final TextEditingController dateController1 = TextEditingController();
  // final TextEditingController titleController1 = TextEditingController();
  // final TextEditingController dateController2 = TextEditingController();
  // final TextEditingController titleController2 = TextEditingController();


            // ViewJournal(
            //   dateController: dateController1,
            //   titleController: titleController1,






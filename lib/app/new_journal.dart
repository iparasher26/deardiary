import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deardiary/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:deardiary/firebase_functions.dart';
import 'package:deardiary/provider/newJournal_provider.dart';


class NewJournal extends StatefulWidget {
  const NewJournal({Key? key}) : super(key: key);

  @override
  State<NewJournal> createState() => _NewJournalState();
}

class _NewJournalState extends State<NewJournal> {

  TextEditingController _title = TextEditingController();
  TextEditingController _body = TextEditingController();

  //function
  Future<bool> enterJournal(String title,String entry) async{

   debugPrint(DateTime.now().toString()); // debug : does not print this at client end

  final journalNumber=FirebaseFirestore.instance.collection('Journal2');

  JournalCreation object = JournalCreation(
      date: DateTime.now().toString(),
      title: title,
      entry: entry,
      id: FirebaseFunction().getUserId()      // non-static function's object created using ()
  );

   final json = object.toJson();

   try{
     DocumentReference a = await journalNumber.add(json);  // click+ctrl = original function definition
     debugPrint(a.id);
   } catch(e,s){
     debugPrint(s.toString());
     debugPrint(e.toString());           // s prints which line has error
   }

   return true;
}

  String formattedDate = DateFormat('EEE, d-M-y').format(DateTime.now());

  @override
  Widget build(BuildContext context) {

    final newJournalProvider = Provider.of<NewJournalProvider>(context,listen: true);
    print("x  Add journal main build x ");

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
                "$formattedDate",
                style: NewJournalStyles.kheader,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Consumer<NewJournalProvider>(builder: (context, value, child){
            print("column rebuild");
            return
          Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: NewJournalStyles.ktitle,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
              controller: _title,
              onChanged: (title) {
                value.updateTitle(title);
              },
            ),
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
                 child:TextField(
                     maxLines: null,
                     keyboardType: TextInputType.multiline,
                     decoration: InputDecoration(
                       hintStyle: NewJournalStyles.kjournal,
                       hintText: 'Write your journal here...',
                       border: InputBorder.none,
                       focusedBorder: InputBorder.none,
                       enabledBorder: InputBorder.none, // Remove the underline border when enabled
                     ),
                     controller: _body,
                     onChanged: (body) {
                       value.updateBody(body);
                  },
                 ), //PROVIDER
                ),
              ),
            ),
          ],
          );
          }),
        ),
      ],
     ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF3F6F45),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.palette),
                  onPressed: () {
                    // Handle palette button tap
                  },
                ),
              ],
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Handle 3 dots button tap
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Consumer<NewJournalProvider>(builder: (context, value, child){
        print("add journal build");
        return
        (newJournalProvider.isTitleNotEmpty==true && newJournalProvider.isBodyNotEmpty==true) ?
        FloatingActionButton(
          backgroundColor: Color(0xFFFEFFE8),
          focusColor: Colors.transparent,
          onPressed: () async{
            if(await enterJournal(_title.text,_body.text))
            {
              newJournalProvider.clearAll();
              Navigator.pop(context);
            }
            else
            { print("FAILED");}
          },
          tooltip: 'Entry added',
          child: Icon(Icons.check_outlined),
        ) :
        Container();
      }),
    );
  }
}

class JournalCreation{

  String id;
  final String title;
  final String entry;
  final String date;

  JournalCreation({
    required this.id,
    required this.date,
    required this.title,
    required this.entry,
  });


  Map<String,dynamic> toJson()=>{
    'id':id,
    'date':date,
    'title':title,
    'entry':entry,
  };
}



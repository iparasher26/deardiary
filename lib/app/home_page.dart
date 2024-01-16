import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deardiary/app/open_journal.dart';
import 'package:deardiary/app/viewjournal_cubes.dart';
import 'package:deardiary/app_theme.dart';
import 'package:deardiary/firebase_functions.dart';
import 'package:deardiary/provider/addTask_provider.dart';
import 'package:deardiary/todo_components/addTask.dart';
import 'package:deardiary/todo_components/todoItems.dart';
import 'package:deardiary/user_authentication/login_page.dart';
import 'package:deardiary/widgets/note_cube.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isHoveredMenu = false;
  bool isHoveredCamera = false;

  late TabController _tabController; // nntr initialize

  @override
  void initState() {

    super.initState();
    _tabController=TabController(length: 2, vsync: this);
    final addTaskProvider=Provider.of<AddTaskProvider>(context,listen: false);

    _tabController.addListener(() {
      addTaskProvider.setMainAddButton(_tabController.index==0);//1 is for journal , 0 is for to-do list
    });

  }

  @override
  Widget build(BuildContext context) {
    //step4 - create variables and put value using on-changed
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    print("X  the MAIN home build  X");

    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search journal',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle the search icon press
              // build a stream with
            },
          ),
          ClipOval(
            child: Material(
              color: Color(0xFFFFFEB8).withOpacity(0.4),
              child: IconButton(
                icon: Icon(Icons.perm_identity),
                color: Colors.black,
                onPressed: () {
                  // Handle the trailing icon press
                },
              ),
            ),
          ),
        ],
      ),

      // Drawer widget for the side menu
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Drawer header with user information, if needed
              // Menu items
              ListTile(
                leading: Icon(Icons.heart_broken_outlined),
                title: Text('Daily Inspo'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.alarm),
                title: Text('Reminder'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () async{
                  await FirebaseFunction().logOut();
                  Navigator.pushNamed(context, 'sign-up');
                },
              ),
              // Add more menu items as needed
            ],
          ),
        ),
      ),

      body: Stack(
        children: [
          //background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/home_portrait.png'),
                fit: BoxFit.cover, // fit as needed
              ),
            ),
          ),

          Container(
            child: TabBar(
              splashBorderRadius: BorderRadius.circular(100),
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              isScrollable: false,
              controller: _tabController,
              tabs: [
                Tab(text: 'Journals'),
                Tab(text: 'To-do list',),
              ],
            ),
          ),
          Container(
            height: h,
            width: w,
            child: TabBarView(
              controller: _tabController,
              children: [

                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0,40, 0, 0),
                    child: Container(
                      height: h,
                      width: w,
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: StreamBuilder<QuerySnapshot>(
                            builder: (context,snapshot){
                              if(!snapshot.hasData)
                              {
                                return Text('no data');
                              }

                              return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),itemCount: snapshot.data?.docs?.length,   // 2 cubes in a row = sliverFIXEDCROSSAXIS
                                  itemBuilder: (BuildContext context, int index){
                                    //debugPrint('---------------------- ${snapshot.data?.docs!.length.toString()}');
                                    QueryDocumentSnapshot<Object?>? data = snapshot.data?.docs[index]; // all documents there, accessing one at a time VIA index
                                    String title=data?.get('title');
                                    String body=data?.get('entry');
                                    DateTime date=DateTime.parse(data?.get('date'));    //
                                    String formattedDate = DateFormat('EEE, d-M-y').format(date);

                                    return NoteCube(
                                      date: formattedDate,
                                      title: title,
                                      function: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => OpenJournal(
                                              date: formattedDate,
                                              title: title,
                                              body: body,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                              );
                            },stream: FirebaseFirestore.instance.collection('Journal2').where('id',isEqualTo:FirebaseFunction().getUserId()).snapshots(),)
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20,60,20,20),
                    child: Container(
                 height: h,
                 width: w,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     todoSearch(),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                       child: Text("To Do List", style: MyStyles.kmediumtext_auth,),
                     ),
                     Stack(
                       children:[
                         Container(
                             height: h*0.535,
                             child:  StreamBuilder<QuerySnapshot>(
                               builder: (context,snapshot){
                                 if(!snapshot.hasData)
                                 {
                                   return Text('no data');
                                 }

                                 return ListView.builder(itemCount: snapshot.data?.docs?.length,   // 2 cubes in a row = sliverFIXEDCROSSAXIS
                                     itemBuilder: (BuildContext context, int index){
                                       //debugPrint('---------------------- ${snapshot.data?.docs!.length.toString()}');
                                       QueryDocumentSnapshot<Object?>? data = snapshot.data?.docs[index]; // all documents there, accessing one at a time VIA index
                                       String task=data?.get('task');
                                       int checkBox=data?.get('checkbox');
                                       String id=data?.id??'';  // ??'' -> if null, then empty string

                                       return ToDoItem(id: id, task: task, checkBox: checkBox);
                                     }
                                 );
                               },stream: FirebaseFirestore.instance.collection('ToDoList').where('id',isEqualTo:FirebaseFunction().getUserId()).where('isActive',isEqualTo:1).snapshots(),)
                         ),
                       ],
                     ),
                     AddTaskBar(),
                   ],
                 ),
                    ),
                  ),
              ],
            ),
          ),
          // Design Elements on Top
        ],
      ),

      bottomNavigationBar:  BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildBottomAppBarIconButton(
              icon: Icons.check_box,
              onPressed: () {
                // Handle menu button tap
              },
              isHovered: isHoveredMenu,
            ),
            _buildBottomAppBarIconButton(
              icon: Icons.camera_alt_outlined,
              onPressed: () {
                // Handle camera button tap
              },
              isHovered: isHoveredCamera,
            ),
          ],
        ),
      ),
      floatingActionButton:
      Consumer<AddTaskProvider>(builder: (context, value, child) {
        return Visibility(
            visible: value.mainAddButtonVisibility,  // if tab is 0 i.e journal , then true
            child: FloatingActionButton(
              backgroundColor: Color(0xFFFEFFE8),
              onPressed: () {
                Navigator.pushNamed(context, 'newJournal');
              },
              tooltip: 'Add',
              child: Icon(Icons.add),
            ),
          );
        }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

Widget _buildBottomAppBarIconButton({
  required IconData icon,
  required VoidCallback onPressed,
  required bool isHovered,
}) {
  return MouseRegion(
    onEnter: (_) => _updateHover(icon, true),
    onExit: (_) => _updateHover(icon, false),
    child: IconButton(
      icon: Icon(icon),
      color: isHovered ? Colors.blue : Colors.black,
      onPressed: onPressed,
    ),
  );
}

void _updateHover(IconData icon, bool hover) {
  setState(() {
    if (icon == Icons.check_box) {
      isHoveredMenu = hover;
    } else if (icon == Icons.camera_alt_outlined) {
      isHoveredCamera = hover;
    }
  });
}
}

Widget todoSearch(){
  return Container(
    height: 60.0,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white.withOpacity(0.7),
    ),
    child: TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.black45, size: 20),
        prefixIconConstraints: BoxConstraints(maxHeight: 25, minWidth: 50),
        contentPadding: EdgeInsets.symmetric(vertical: 8.5),
        border: InputBorder.none,
        hintText: 'Search',
        //hintStyle:
      ),
    ),
  );
}

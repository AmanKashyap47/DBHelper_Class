import 'package:data_base/Data_Base/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //db_helper Class k object
  DBHelper dbHelper = DBHelper.getInstance();

  List<Map<String, dynamic>> allNotes = [];

  @override
  void initState() {
    super.initState();
    getMyNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Data_Base"),
      ),
      body: ListView.builder(
          itemCount: allNotes.length,
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(allNotes[index][DBHelper.COLUMN_NOTE_TITLE]),
              subtitle: Text(allNotes[index][DBHelper.COLUMN_NOTE_DESC]),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool check = await dbHelper.addNote(
              title: "DBHelper",
              desc:
                  "SmartStore Database Helper Singleton class that provides helpful methods ");

          if (check) {
            getMyNotes();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void getMyNotes() async {
    allNotes = await dbHelper.getAllNotes();

    setState(() {});
  }
}

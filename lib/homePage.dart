import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'InsertFromScreen.dart';
import 'Edit_Data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  final CollectionReference recipeRef =
      FirebaseFirestore.instance.collection('Recipes');
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Recipes').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                child: Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: 'Loading......',
                  ),
                ),
              );
            default:
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot document = snapshot.data.docs[index];
                    return ListTile(
                      title: Text(document["name"],style: TextStyle(
                        color: Colors.orange,
                      ),),
                      subtitle: Text(document["description"] + document["ingred"]),
                    );
                  });
          }
        },
      ),
    );
  }
}

class TwoTab extends StatefulWidget {
  const TwoTab({Key? key}) : super(key: key);

  @override
  State<TwoTab> createState() => _TwoTabState();
}

class _TwoTabState extends State<TwoTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.orange,
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(child: Text("แสดงรายการ"),),
              Tab(child: Text("เพิ่มข้อมูล")),
              Tab(child: Text("แก้ไขข้อมูล")),
            ],
          ),
          body: TabBarView(
            children: [
              HomePage(),
              InsertFormScreen(),
              Edit_DataPage(),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Edit_DataPage extends StatefulWidget {
  // const Edit_DataPage({Key? key}) : super(key: key);

  final CollectionReference recipeRef =
  FirebaseFirestore.instance.collection('Recipes');

  @override
  State<Edit_DataPage> createState() => _Edit_DataPageState();
}

class _Edit_DataPageState extends State<Edit_DataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('หน้าแก้ไขข้อมูล'),
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
                      title: Text(document["name"]),
                      trailing: FittedBox(
                        child: Row(
                          children: [
                            IconButton(onPressed: () {
                              updateData(
                                widget.recipeRef.doc(document.id),
                                  document["name"],
                                  document["description"],
                                  document["ingred"],
                              );
                            }, icon: Icon(
                              Icons.edit,
                              color: Colors.orangeAccent,
                            )),
                            IconButton(onPressed: () {
                              deleteData(
                                widget.recipeRef.doc(document.id),
                              );
                            }, icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            )),

                          ],
                        ),
                      ),
                    );
                  });

          }
        },

      ),
    );
  }
}

updateData(DocumentReference doc, String getname, String getDes, String getingred){
  TextEditingController name = TextEditingController();
}

deleteData(DocumentReference doc){
  // showDialog(context: context, builder: (BuildContext context) {
  //   return StatefulBuilder(builder: (BuildContext context, void Function()) setState){
  //     return AlertDialog(
  //
  //     )
  //   }
  // });
}




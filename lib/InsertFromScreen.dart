import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InsertFormScreen extends StatefulWidget {
  // const InsertFormScreen({Key? key}) : super(key: key);

  CollectionReference recipeCollection = FirebaseFirestore.instance.collection("Recipes");

  @override
  State<InsertFormScreen> createState() => _InsertFormScreenState();
}

class _InsertFormScreenState extends State<InsertFormScreen> {

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController ingred = TextEditingController();

  bool _isCheck = false;

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Recipe'),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                labelText: "ชื่อ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15)
                )
              ),
            ),
            const SizedBox(height: 18,),
            TextField(
              controller: description,
              decoration: InputDecoration(
                  labelText: "คำอธิบาย",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  )
              ),
            ),
            const SizedBox(height: 18,),
            TextField(
              controller: ingred,
              decoration: InputDecoration(
                  labelText: "ส่วนประกอบ",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  )
              ),
            ),
            const SizedBox(height: 18,),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: Colors.orange,
                onPressed: () async {
                  var _name = name.text.toString();
                  var _des = description.text.toString();
                  var _ingred = ingred.text.toString();

                  if (_name.isNotEmpty &&
                      _des.isNotEmpty &&
                      _ingred.isNotEmpty) {

                    setState(() {
                      _isCheck = true;
                    });

                    await widget.recipeCollection.add({
                      "name": _name,
                      "description": _des,
                      "ingred": _ingred,
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Save Completed"),
                        backgroundColor: Colors.green,
                      ));

                      name.text = "";
                      description.text = "";
                      ingred.text = "";

                      setState(() {
                        _isCheck = false;
                      });

                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Plese fill all input"),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: (_isCheck)
                    ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1.6,
                  ),
                )
                    : Text("เพิ่มข้อมูล"),
              ),
            )
          ],
        ),
      )
    );
  }
}

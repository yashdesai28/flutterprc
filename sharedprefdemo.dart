import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class sharedPref extends StatefulWidget {
  const sharedPref({super.key});

  @override
  State<sharedPref> createState() => _sharedPrefState();
}

class _sharedPrefState extends State<sharedPref> {
  TextEditingController txtName = new TextEditingController();
  var nameValue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValue();
  }
  getValue() async
  {
    //get the data from shared preferences

      SharedPreferences pref = await SharedPreferences.getInstance();
      var name  = pref.getString("name");
     // print(name);
      nameValue = name ?? 'No Data Found';
      print(nameValue);


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preference Demo'),
      ),
      body: Column(
        children: [
          TextField(
            controller: txtName ,
            decoration: InputDecoration(
              labelText: 'Enter Name',
              hintText: 'Enter Name'
            ),
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              ElevatedButton(onPressed: () async{
                setState(() async{
                  //save the data in shared preferences
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.setString("name", txtName.text.toString());
                });


              }, child: Text('Save')),
              ElevatedButton(onPressed: () {
                setState(() {
                  getValue();
                });

              }, child: Text('Get Data'))
            ],
          ),
          Text('${nameValue}')
        ],
      ),
    );
  }
}

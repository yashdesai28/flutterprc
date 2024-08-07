import 'package:cie2/showdata.dart';
import 'package:cie2/sqlhelper.dart';
import 'package:flutter/material.dart';

class reg extends StatefulWidget {
  const reg({super.key});

  @override
  State<reg> createState() => _regState();
}

class _regState extends State<reg> {
  String _slectedoptions = '';
  var name1,email1,pho1;
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController pho=TextEditingController();

  final List<String> option = ["cricket", "codeing", "sport"];

  final Map<String, bool> selectoption = {
    "cricket": false,
    "codeing": false,
    "sport": false
  };

  String selectop='';
   fun(){

     setState(() {
       name1=name.text;
       email1=email.text;
       pho1=pho.text;

       selectop=selectoption.entries.where((element) => element.value).map((e) => e.key).join(',');



     });



  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("login page"),
        ),
        body: Column(
          children: [
            Container(
              child: Container(
                height: MediaQuery.of(context).size.height - 600,
                width: MediaQuery.of(context).size.width,
                // color: Colors.blue,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    image: DecorationImage(
                        image: AssetImage('assets/Illustration.png'),
                        fit: BoxFit.contain)),
              ),
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: Column(
                  children: [
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                          hintText: "name",
                          labelText: "name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                          hintText: "email", labelText: "email"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: pho,
                      decoration: InputDecoration(
                          hintText: "phone", labelText: "phone"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                              value: "male",
                              title: Text("male"),
                              groupValue: _slectedoptions,
                              onChanged: (String? value) {
                                setState(() {
                                  _slectedoptions = value!;
                                });
                              }),
                        ),
                        Expanded(
                            child: RadioListTile(
                                value: "female",
                                title: Text("female"),
                                groupValue: _slectedoptions,
                                onChanged: (String? value) {
                                  setState(() {
                                    _slectedoptions = value!;
                                  });
                                }))
                      ],
                    ),
                    Row(
                      children: option.map((String _op) {
                        return Expanded(
                            child: CheckboxListTile(
                              title: Text(_op),
                                value: selectoption[_op],
                                onChanged: (bool? value) {
                                  setState(() {
                                    selectoption[_op] = value ?? false;
                                  });
                                }));
                      }).toList(),
                    ),
                    ElevatedButton(onPressed: ()async{
                      fun();
                          await addstudent();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>showdata()));
                      }, child: Text("submit"))
                  ],
                ),
              ),
            ),
            Text("$_slectedoptions + name= $name1 + email=$email1+pho=$pho1"+"selectd op+ $selectop")
          ],
        ),
      ),
    );
  }



  Future<void>addstudent()async{
     int id= await sqlhelper.addstudent(name1, email1, pho1,_slectedoptions,selectop);

     if(id>0){

       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('add suceful')));

     }
  }
}

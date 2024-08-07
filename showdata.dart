import 'package:cie2/sqlhelper.dart';
import 'package:flutter/material.dart';
class showdata extends StatefulWidget {
  const showdata({super.key});

  @override
  State<showdata> createState() => _showdataState();
}

class _showdataState extends State<showdata> {

List<Map<String,dynamic>>studlist=[];

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getstudent();
  }

  Future<void>getstudent()async{
  var data= await sqlhelper.getdata();
  print(data);
  setState(() {
    studlist=data;
  });

  }

  TextEditingController email=TextEditingController();
  TextEditingController name=TextEditingController();

  void showform(int?id)async{

     if(id!=null){
       final record=studlist.firstWhere((element) => element['id']==id);
       email.text=record['email'];
       name.text=record['name'];

     }
     print("yashhhh");
     showModalBottomSheet(context: context,elevation: 5,isScrollControlled: true, builder: (context)=>Container(
       padding: EdgeInsets.only(left: 15,right: 15,bottom: MediaQuery.of(context).viewInsets.bottom+120),child: Column(
       crossAxisAlignment: CrossAxisAlignment.end,
       mainAxisSize: MainAxisSize.min,
       children: [
          TextField(controller: name,
          decoration: InputDecoration(labelText: "name"),),
         TextField(controller: email,
           decoration: InputDecoration(labelText: "email"),),
         ElevatedButton(onPressed: ()async{
           update(id!);
           Navigator.of(context).pop();
         }, child: Text("update"))
       ],
     ),
     ),
     );

  }

  Future<void>update(int id)async {

    final result= await sqlhelper.update(id, name.text.toString(), email.text.toString());

    if(result>0){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("update")));
      getstudent();
    }
  }

  Future<void>deletestud(int id)async{

    final result=await sqlhelper.deletedata(id);
    if(result>0){

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("delete recode")));

      getstudent();

    }

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(title:Text("show data")),
        
        body: ListView.builder(itemBuilder: (context, index) => Card(
          child: ListTile(
            title: Text(studlist[index]['name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(studlist[index]['email']),
                Text(studlist[index]['pho']),
                Text(studlist[index]['gender']),
                Text(studlist[index]['hooby']),
              ],
            ),
            trailing: Container(
              width: 100,
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    print('jnjb');
                    showform(studlist[index]['id']);
                  }, icon: Icon(Icons.edit)),
                  IconButton(onPressed: (){
                    deletestud(studlist[index]['id']);
                  }, icon: Icon(Icons.delete))
                ],
              ),
            ),
          ),
        ),itemCount: studlist.length),
      ),
    );
  }
}

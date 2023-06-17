import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nba_app/model/team.dart';
class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}
List<Team>teams=[];
Future geteam() async{
  var response= await http.get(Uri.https("www.balldontlie.io","api/v1/teams"));
  print(response.body);
  var jsonData=jsonDecode(response.body);
  for(var eachteam in jsonData['data']){
    final team=Team(abbreviation: eachteam["abbreviation"], full_name: eachteam["full_name"]);
    teams.add(team);
  }
  print(teams.length);


}

class _homepageState extends State<homepage> { //List view is scrollable while column is not //Listview build the list dynamically

  @override

  Widget build(BuildContext context) {
    geteam();

    return Scaffold(

      body: FutureBuilder(
        future: geteam(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){

            return ListView.builder(
              itemCount: teams.length,
                itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.brown,
                    ),
                    child: ListTile(
                      leading: Icon(Icons.sports_basketball),
                      title:Text(teams[index].abbreviation) ,
                      subtitle: Text(teams[index].full_name),

                    ),
                  ),
                ),
              );
            }
            );
          }
          else{
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                  child: Center(
                    child: Expanded(
                        child: Text("Name And Abbreviation",
                      style: TextStyle(
                        fontSize: 30.0
                            ,color: Colors.red,
                        fontWeight:FontWeight.bold

                      ),
                    )),
                  ),
                ),
                
                Expanded(

                  child: Center(

                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );

          }
        }


      ),


    );
  }
}

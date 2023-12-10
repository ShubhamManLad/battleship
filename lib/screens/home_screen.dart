import 'package:battleship/screens/defence_screen.dart';
import 'package:battleship/styles/button_styles.dart';
import 'package:battleship/styles/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Home_Screen extends StatefulWidget {
  static final String id = 'Home_Screen';

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController gameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Battle Ship', style: logotext,),
                  Icon(Icons.directions_boat,size: 60,color: Colors.orangeAccent)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: nameController,
                      style: floatinglabeltext,
                      cursorColor: Colors.orangeAccent,
                      decoration: InputDecoration(
                          labelText: 'Player Name',
                          labelStyle: floatinglabeltext,
                          floatingLabelStyle: floatinglabeltext,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent, width: 3),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent, width: 3),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: gameController,
                      style: floatinglabeltext,
                      cursorColor: Colors.orangeAccent,
                      decoration: InputDecoration(
                          labelText: 'Game ID',
                          labelStyle: floatinglabeltext,
                          floatingLabelStyle: floatinglabeltext,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent, width: 3),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent, width: 3),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          )
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                        String name = nameController.text;
                        String game = gameController.text;
                        // DatabaseReference db = FirebaseDatabase.instance.ref(game);
                        // db.child(name).set({'name':name});

                        FirebaseFirestore db = FirebaseFirestore.instance;
                        var coll = await db.collection(game).get();
                        if(coll.size == 0) {
                          final data = {"players": [name]};
                          db.collection(game).doc("0#game").set(data);
                        }
                        else{
                          List<dynamic> players = coll.docs.first.get("players");
                          print(players);
                          if(!players.contains(name)) {
                            players.add(name);
                          }
                          final data = {"players":players};
                          db.collection(game).doc("0#game").set(data);
                        }

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Defence_Screen(gameID: game,name: name)));
                      },
                    child: Text('Join Game'),
                    style: flatButtonStyle,
                  ),
                ],
              ),
              Image(image: AssetImage('images/battleship.png'))
            ],
          ),
        ),
      ),
    );
  }
}

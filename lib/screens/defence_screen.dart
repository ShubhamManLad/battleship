import 'package:battleship/components/pixels.dart';
import 'package:battleship/screens/attack_screen.dart';
import 'package:battleship/styles/button_styles.dart';
import 'package:battleship/styles/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:firebase_database/firebase_database.dart';

class Defence_Screen extends StatefulWidget {

  static final String id = 'Defence_Screen';

  String gameID;
  String name;

  Defence_Screen({required this.gameID, required this.name});

  @override
  State<Defence_Screen> createState() => _Defence_ScreenState();
}

class _Defence_ScreenState extends State<Defence_Screen> {

  int rows = 10;
  int cols = 10;
  int selected_ship = 3;
  bool horizontal = false;
  bool player_ready = false;
  String player_status = "SETUP";
  String opponent_status = "SETUP";
  bool opponent_ready = false;
  List<int> ship_positions = [];
  List<dynamic> players =[];
  late String gameID;
  late String name;
  late String opponent='';


  List<int> s2_b1_h = [];
  List<int> s2_b2_h = [];

  List<int> s3_b2_h = [];

  List<int> s4_b2_h = [];
  List<int> s4_b3_h = [];


  List<int> s2_b1_v = [];
  List<int> s2_b2_v = [];

  List<int> s3_b2_v = [];

  List<int> s4_b2_v = [];
  List<int> s4_b3_v = [];






  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gameID = widget.gameID;
    name = widget.name;
    print(gameID+":"+name);

    updateStatus("SETUP",[],[]);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white12,
        body: Container(
          margin: EdgeInsets.all(12),
          child: Column(

            children: [
              // Opponent
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Opponent:$opponent",style: labeltext,),
                  Text("Status:$opponent_status", style: labeltext,)
                ],
              ),

              // Grid
              Expanded(
                child: Container(
                  decoration: BoxDecoration(),
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: rows*cols,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cols),
                      itemBuilder: (context, index){
                        if(ship_positions.contains(index)){
                          if(s2_b1_h.contains(index)){
                            return Ship_Head_H_Pixel();
                          }
                          else if(s2_b2_h.contains(index)){
                            return Ship_Tail_H_Pixel();
                          }
                          else if(s2_b1_h.contains(index)){
                            return Ship_Head_H_Pixel();
                          }
                          else if(s3_b2_h.contains(index)){
                            return Ship_Body_H_Pixel();
                          }
                          else if(s2_b2_h.contains(index)){
                            return Ship_Tail_H_Pixel();
                          }
                          else if(s2_b1_h.contains(index)){
                            return Ship_Head_H_Pixel();
                          }
                          else if(s4_b2_h.contains(index)){
                            return Ship_Body2_H_Pixel();
                          }
                          else if(s4_b3_h.contains(index)){
                            return Ship_Body3_H_Pixel();
                          }
                          else if(s2_b2_h.contains(index)){
                            return Ship_Tail_H_Pixel();
                          }
                          else if(s2_b1_h.contains(index)){
                            return Ship_Head_H_Pixel();
                          }
                          else if(s4_b2_h.contains(index)){
                            return Ship_Body2_H_Pixel();
                          }
                          else if(s4_b3_h.contains(index)){
                            return Ship_Body3_H_Pixel();
                          }
                          else if(s3_b2_h.contains(index)){
                            return Ship_Body_H_Pixel();
                          }
                          else if(s2_b2_h.contains(index)){
                            return Ship_Tail_H_Pixel();
                          }

                          if(s2_b1_v.contains(index)){
                            return Ship_Head_V_Pixel();
                          }
                          else if(s2_b2_v.contains(index)){
                            return Ship_Tail_V_Pixel();
                          }
                          else if(s2_b1_v.contains(index)){
                            return Ship_Head_V_Pixel();
                          }
                          else if(s3_b2_v.contains(index)){
                            return Ship_Body_V_Pixel();
                          }
                          else if(s2_b2_v.contains(index)){
                            return Ship_Tail_V_Pixel();
                          }
                          else if(s2_b1_v.contains(index)){
                            return Ship_Head_V_Pixel();
                          }
                          else if(s4_b2_v.contains(index)){
                            return Ship_Body2_V_Pixel();
                          }
                          else if(s4_b3_v.contains(index)){
                            return Ship_Body3_V_Pixel();
                          }
                          else if(s2_b2_v.contains(index)){
                            return Ship_Tail_V_Pixel();
                          }
                          else if(s2_b1_v.contains(index)){
                            return Ship_Head_V_Pixel();
                          }
                          else if(s4_b2_v.contains(index)){
                            return Ship_Body2_V_Pixel();
                          }
                          else if(s4_b3_v.contains(index)){
                            return Ship_Body3_V_Pixel();
                          }
                          else if(s3_b2_v.contains(index)){
                            return Ship_Body_V_Pixel();
                          }
                          else if(s2_b2_v.contains(index)){
                            return Ship_Tail_V_Pixel();
                          }


                          return Ship_Pixel();
                        }
                        return GestureDetector(
                          child: Water_Pixel(),
                          onTap: (){setState(() {placeShip(index);});
                            },
                        );
                      }
                  ),
                ),
              ),


              // Size
              Column(
                children: [
                  Row(
                    children: [
                      Text('Ship Size:', style: labeltext,),
                    ],
                  ),
                  NumberPicker(
                      minValue: 2,
                      maxValue: 5,
                      value: selected_ship,
                      itemHeight: 50,
                      axis: Axis.horizontal,
                      selectedTextStyle: labeltext,
                      textStyle: subtext,
                      itemWidth: 50,
                      onChanged:(value) => setState(() => selected_ship = value)
                  ),
                ],
              ),


              // Switch
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Ship Orientation:', style: labeltext,),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Vertical',style: subtext,),
                      Switch(
                          activeColor: Colors.blueAccent,
                          inactiveTrackColor: Colors.black12,
                          inactiveThumbColor: Colors.blueAccent,
                          value: horizontal,
                          onChanged: (value){
                            setState(() {
                              horizontal = value;
                            });
                          }),
                      Text('Horizontal',style: subtext,)
                    ],
                  ),
                ],
              ),

              // Ready/Attack
              getAction(), // Button

            ],
          ),
        ),
      ),
    );
  }

  int moveUp(int current){
    if(current>9){
      return current - rows;
    }
    return -1;
  }

  int moveRight(int current){
    if(current%10==9){
      return -1;
    }
    return current+1;
  }

  bool isPossible(int position){
    int temp = position;
    for (int i =0; i<selected_ship-1; i++){
      if(horizontal){
        temp = moveRight(temp);
        if(temp==-1 || ship_positions.contains(temp)){
          return false;
        }

      }
      else{
        temp = moveUp(temp);
        if (temp==-1 || ship_positions.contains(temp)){
          return false;
        }
      }
    }
    return true;
  }

  void placeShip(int positon) {
    if(isPossible(positon)){
      int temp = positon;
      for (int i =0; i<selected_ship; i++){
        if(horizontal){
          ship_positions.add(temp);
          temp = moveRight(temp);

        }
        else{
          ship_positions.add(temp);
          temp = moveUp(temp);
        }
      }
      if (horizontal){
        switch(selected_ship){
          case 2:
            s2_b2_h.add(positon);
            s2_b1_h.add(moveRight(positon));
          case 3:
            s2_b2_h.add(positon);
            s3_b2_h.add(moveRight(positon));
            s2_b1_h.add(moveRight(moveRight(positon)));
          case 4:
            s2_b2_h.add(positon);
            s4_b3_h.add(moveRight(positon));
            s4_b2_h.add(moveRight(moveRight(positon)));
            s2_b1_h.add(moveRight(moveRight(moveRight(positon))));
          case 5:
            s2_b2_h.add(positon);
            s3_b2_h.add(moveRight(positon));
            s4_b3_h.add(moveRight(moveRight(positon)));
            s4_b2_h.add(moveRight(moveRight(moveRight(positon))));
            s2_b1_h.add(moveRight(moveRight(moveRight(moveRight(positon)))));

        }
      }
      else{
        switch(selected_ship){
          case 2:
            s2_b2_v.add(positon);
            s2_b1_v.add(moveUp(positon));
          case 3:
            s2_b2_v.add(positon);
            s3_b2_v.add(moveUp(positon));
            s2_b1_v.add(moveUp(moveUp(positon)));
          case 4:
            s2_b2_v.add(positon);
            s4_b3_v.add(moveUp(positon));
            s4_b2_v.add(moveUp(moveUp(positon)));
            s2_b1_v.add(moveUp(moveUp(moveUp(positon))));
          case 5:
            s2_b2_v.add(positon);
            s3_b2_v.add(moveUp(positon));
            s4_b3_v.add(moveUp(moveUp(positon)));
            s4_b2_v.add(moveUp(moveUp(moveUp(positon))));
            s2_b1_v.add(moveUp(moveUp(moveUp(moveUp(positon)))));

        }
      }
    }
  }

  void saveData() async{
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");
    await ref.set({
      "name": "John",
      "age": 18,
      "address": {
        "line1": "100 Mountain View"
      }
    });
  }

  void getData() async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection(gameID);
    var data;
    docRef.doc("0#game").snapshots().listen((event) {
      data = (event.data());
      event.data()?.forEach((key, value) {
        if(key=="players"){
          setState(() {
            players = value;
            players.forEach((element) {
              if(element!=name){
                  opponent = element;
                //print(opponent);
              }
            });
          });
        }
      });
    });

    docRef.doc(opponent).snapshots().listen((event) {
      data = (event.data());
      //print(event.data());
      event.data()?.forEach((key, value) {
        event.data()?.forEach((key, value) {
          if(key=="status"){
            setState(() {
              if(value=="READY"){
                opponent_ready = true;
                opponent_status = value;
              }
            });
          }
        });
      });
    });

  }

  void updateStatus(String status, List<int>ships, List<int>attacks){
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docRef = db.collection(gameID).doc(name);
    final data ={
      "status":status,
      "ships":ships,
      "attacks":attacks
    };
    docRef.set(data);
  }
  
  void deployShips(){
    updateStatus("READY", ship_positions, []);
  }

  Widget getAction(){
    if(!player_ready){
      return TextButton(
        onPressed: (){
            setState(() {
              player_ready = true;
              deployShips();
            });
          },
        child: Text("Ready"),
        style: flatButtonStyle,
      );
    }
    else if(opponent_ready){
      return TextButton(
        onPressed: ()async{
            print(players);
            FirebaseFirestore db = FirebaseFirestore.instance;
            var p1 = await db.collection(gameID).doc(players[0]).get();
            var p2 = await db.collection(gameID).doc(players[1]).get();
            var P1 = (p1.data());
            var P2 = p2.data();
            List<int> enemy_ships = [];
            Map<String,dynamic> data1 ={};
            Map<String,dynamic> data2 ={};
            P1?.forEach((key, value) {
              data1[key]=value;
              if(key=='status'){
                data1[key]='ATTACK';
              }
              if(opponent == players[0]){
                print('opp p1');
                if (key=='ships'){
                  List temp = value;
                  temp.forEach((element) {enemy_ships.add(element);});
                }
              }
            });

            P2?.forEach((key, value) {
              data2[key]=value;
              if(key=='status'){
                data2[key]='DEFEND';
              }
              if(opponent == players[1]){
                print('opp p2');
                if (key=='ships'){
                  List temp = value;
                  temp.forEach((element) {enemy_ships.add(element);});
                }
              }
            });
            print(enemy_ships);
            db.collection(gameID).doc(players[0]).set(data1);
            db.collection(gameID).doc(players[1]).set(data2);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=>Attack_Screen(
                        gameID: gameID, name: name, opponent: opponent,
                        ship_positions:ship_positions, enemy_ships:enemy_ships,
                        s2_b1_h:s2_b1_h,s2_b2_h:s2_b2_h,s3_b2_h:s3_b2_h,s4_b2_h:s4_b2_h,s4_b3_h:s4_b3_h,
                        s2_b1_v:s2_b1_v,s2_b2_v:s2_b2_v,s3_b2_v:s3_b2_v,s4_b2_v:s4_b2_v,s4_b3_v:s4_b3_v
                    )
                )
            );
          },
        child: Text("Attack"),
        style: flatButtonStyle,
      );
    }
    else{
      return TextButton(
        onPressed: (){},
        child: Text("Opponent Not ready"),
        style: flatButtonStyle,
      );
    }
  }
}

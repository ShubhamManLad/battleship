import 'package:battleship/components/pixels.dart';
import 'package:battleship/styles/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:firebase_database/firebase_database.dart';

class Attack_Screen extends StatefulWidget {

  static final String id = 'Attack_Screen';

  String gameID;
  String name;
  String opponent;
  List<int> ship_positions;

  List<int> enemy_ships;

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


  Attack_Screen(
      {required this.gameID, required this.name, required this.opponent,
        required this.ship_positions, required this.enemy_ships,
        required this.s2_b1_h,required this.s2_b2_h,required this.s3_b2_h,required this.s4_b2_h,required this.s4_b3_h,
        required this.s2_b1_v,required this.s2_b2_v,required this.s3_b2_v,required this.s4_b2_v,required this.s4_b3_v}
      );

  @override
  State<Attack_Screen> createState() => _Attack_ScreenState();
}

class _Attack_ScreenState extends State<Attack_Screen> {

  int rows = 10;
  int cols = 10;
  int selected_ship = 3;
  bool horizontal = false;
  bool player_ready = false;
  String player_status = "SETUP";
  String opponent_status = "SETUP";
  bool opponent_ready = false;
  List<int> ship_positions = [];
  List<int> attack_positions = [];
  List<int> enemy_ships = [];
  List<int> enemy_attacks = [];
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
    opponent = widget.opponent;
    ship_positions = widget.ship_positions;
    enemy_ships = widget.enemy_ships;

    s2_b1_h = widget.s2_b1_h;
    s2_b2_h = widget.s2_b2_h;

    s3_b2_h = widget.s3_b2_h;

    s4_b2_h = widget.s4_b2_h;
    s4_b3_h = widget.s4_b3_h;


    s2_b1_v = widget.s2_b1_v;
    s2_b2_v = widget.s2_b2_v;

    s3_b2_v = widget.s3_b2_v;

    s4_b2_v = widget.s4_b2_v;
    s4_b3_v = widget.s4_b3_v;

    print(enemy_ships);
    //updateStatus("SETUP",[],[]);
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
                  Text("Opponent:$opponent", style: labeltext,),
                  Text("Status:$opponent_status", style: labeltext,)
                ],
              ),

              // Enemy Grid
              Expanded(
                child: Container(
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: rows*cols,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cols),
                      itemBuilder: (context, index){
                        if(attack_positions.contains(index)){
                          return getAttackPixel(index);
                        }
                        return GestureDetector(
                          child: Enemy_Water_Pixel(),
                          onTap: (){setState(() {attackShip(index);});
                          },
                        );
                      }
                  ),
                ),
              ),

              Container(
                height: 10,
                width: double.infinity,
                color: Colors.red,
              ),

              // My Grid
              Expanded(
                child: Container(
                  decoration: BoxDecoration(),
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: rows*cols,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cols),
                      itemBuilder: (context, index){
                        if(enemy_attacks.contains(index)){
                          if (ship_positions.contains(index)) {
                            return AttackHit_Pixel();
                          }
                          else{
                            return AttackMiss_Pixel();
                          }
                        }
                        else if(ship_positions.contains(index)){

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
                        if(enemy_attacks.contains(index)){

                        }
                        return GestureDetector(
                          child: Water_Pixel(),
                          onTap: (){},
                        );
                      }
                  ),
                ),
              ),

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
    }
  }

  void attackShip(int position) async{
    print(opponent_ready);
    if(!opponent_ready) {
      print('Attacking');
      FirebaseFirestore db = FirebaseFirestore.instance;
      var p1 = await db.collection(gameID).doc(opponent).get();

      setState(() {
        attack_positions.add(position);
        updateStatus("DEFEND", ship_positions, attack_positions);


        var P1 = p1.data();
        Map<String,dynamic> data1 ={};
        P1?.forEach((key, value) {
          data1[key]=value;
          if(key=='status'){
            data1[key]='ATTACK';
          }

        });

        //print(enemy_ships);
        db.collection(gameID).doc(opponent).set(data1);


      });
    }
  }

  Widget getAttackPixel(int position){

    if (enemy_ships.contains(position)){
      return AttackHit_Pixel();
    }
    return AttackMiss_Pixel();

  }

  Widget getDefendPixel(int position){
    if (ship_positions.contains(position)){
      return AttackHit_Pixel();
    }
    return AttackMiss_Pixel();
  }

  void getData() async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    print(gameID);
    print(opponent);
    final docRef = db.collection(gameID);

    docRef.doc(opponent).snapshots().listen((event) {

      //print(event.data());
      event.data()?.forEach((key, value) {
        event.data()?.forEach((key, value) {
          //print(value);
          if(key=="status"){
            setState(() {
              if(value=="ATTACK"){
                opponent_ready = true;
              }
              else{
                opponent_ready = false;
              }
              opponent_status = value;
            });
          }
          if(key=='attacks'){
            setState(() {
              enemy_attacks = [];
              List temp = value;
              temp.forEach((element) { enemy_attacks.add(element);});
            });
            //print(enemy_attacks);
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

}

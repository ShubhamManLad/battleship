import 'package:flutter/material.dart';

class Water_Pixel extends StatelessWidget {
  const Water_Pixel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.blue[500],
      ),
    );
  }
}


class Enemy_Water_Pixel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.blue[800],
      ),
    );
  }
}

class Ship_Pixel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.green
      ),
    );
  }
}

class Ship_Head_H_Pixel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Image(image: AssetImage('images/s2_b1_h.png'),),
    );
  }
}

class Ship_Body_H_Pixel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Image(image: AssetImage('images/s3_b2_h.png'),),
    );
  }
}

class Ship_Body2_H_Pixel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Image(image: AssetImage('images/s4_b2_h.png'),),
    );
  }
}

class Ship_Body3_H_Pixel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Image(image: AssetImage('images/s4_b3_h.png'),),
    );
  }
}

class Ship_Tail_H_Pixel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Image(image: AssetImage('images/s2_b2_h.png'),),
    );
  }
}


class Ship_Head_V_Pixel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Image(image: AssetImage('images/s2_b1_v.png'),),
    );
  }
}

class Ship_Body_V_Pixel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Image(image: AssetImage('images/s3_b2_v.png'),),
    );
  }
}

class Ship_Body2_V_Pixel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Image(image: AssetImage('images/s4_b2_v.png'),),
    );
  }
}

class Ship_Body3_V_Pixel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Image(image: AssetImage('images/s4_b3_v.png'),),
    );
  }
}

class Ship_Tail_V_Pixel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Image(image: AssetImage('images/s2_b2_v.png'),),
    );
  }
}


class AttackHit_Pixel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[500],
      margin: EdgeInsets.all(1.5),
      child: Image(image: AssetImage('images/blast.png'),),
    );
  }
}

class AttackMiss_Pixel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      color: Colors.white12,
      child: Icon(Icons.cancel),
    );
  }
}

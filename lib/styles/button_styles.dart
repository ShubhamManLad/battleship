import 'package:battleship/styles/text_styles.dart';
import 'package:flutter/material.dart';


final ButtonStyle flatButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.white,
  backgroundColor: Color(0xFF1448F4),
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
  ),
  textStyle: labeltext,
);

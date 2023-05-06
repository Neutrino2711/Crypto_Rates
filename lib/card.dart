import 'package:flutter/material.dart';
import 'price_screen.dart';
import 'coin_data.dart';

class CardCur extends StatelessWidget {
  const CardCur({this.curRate, this.dropdownCurrency,this.crypto});

  final String? curRate, dropdownCurrency,crypto;

  
  

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto = $curRate $dropdownCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

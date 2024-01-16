import 'package:flutter/material.dart';

class MyStyles
{
  static const TextStyle kbigtext_auth = TextStyle(
      fontSize: 50.0,
      fontWeight: FontWeight.bold,
      color: Color(0xFF27672E), //23812D
      fontFamily: 'Libre Baskerville',
  );

  static const TextStyle kmediumtext_auth = TextStyle(
    fontSize: 35.0,
    fontWeight: FontWeight.bold,
    color: Color(0xFF27672E), //23812D
    fontFamily: 'Libre Baskerville',
  );

  static const TextStyle khinttext_auth = TextStyle(
    fontSize: 18.0,
    color: Color(0xFF3F6F45),
    fontWeight: FontWeight.w400,
    fontFamily: 'Montserrat',

  );
}

class NewJournalStyles{

  static const TextStyle ktitle = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    color: Color(0xFF27672E), //23812D
    fontFamily: 'Libre Baskerville',
  );

  static TextStyle ktitleF = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.w400,
    color: Color(0xFF27672E).withOpacity(0.5), //23812D
    fontFamily: 'Libre Baskerville',
  );

  static const TextStyle kjournal = TextStyle(
    fontSize: 18.0,
    color: Color(0xFF3F6F45),
    fontWeight: FontWeight.w500,
    fontFamily: 'Montserrat',
  );

  static TextStyle kjournalF = TextStyle(
    fontSize: 18.0,
    color: Color(0xFF3F6F45).withOpacity(0.5),
    fontWeight: FontWeight.w200,
    fontFamily: 'Montserrat',
  );

  static const TextStyle kheader = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Color(0xFF27672E), //23812D
    fontFamily: 'Noto Sans Japanese',
  );

  static const TextStyle kCubeDate = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.bold,
    color: Color(0xFF27672E), //23812D
    fontFamily: 'Noto Sans Japanese',
  );

  static const TextStyle kCubeTitle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: Color(0xFF27672E), //23812D
    fontFamily: 'Noto Sans Japanese',
  );

}
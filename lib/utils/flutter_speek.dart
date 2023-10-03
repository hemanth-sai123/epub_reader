import 'package:epub_reader/utils/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

class FlutterMySpeak{
  static TextToSpeech tts = TextToSpeech();

  static void speak(String text){

    tts.speak(text);

  }

  static void snackBar(String text,BuildContext context, SnackType info){
    Snack.show(content: text,context: context, snackType: info, behavior: SnackBarBehavior.floating);
    speak(text);
  }

}
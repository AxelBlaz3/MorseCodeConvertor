import 'package:flutter/material.dart';

class HomeState extends ChangeNotifier {
  // Map for morse code to plain text.
  final morseToCharMap = {
    '.-': 'A',
    '-...': 'B',
    '-.-.': 'C',
    '-..': 'D',
    '.': 'E',
    '..-.': 'F',
    '--.': 'G',
    '....': 'H',
    '..': 'I',
    '.---': 'J',
    '-.-': 'K',
    '.-..': 'L',
    '--': 'M',
    '-.': 'N',
    '---': 'O',
    '.--.': 'P',
    '--.-': 'Q',
    '.-.': 'R',
    '...': 'S',
    '-': 'T',
    '..-': 'U',
    '...-': 'V',
    '.--': 'W',
    '-..-': 'X',
    '-.--': 'Y',
    '--..': 'Z',
    '.----': '1',
    '..---': '2',
    '...--': '3',
    '....-': '4',
    '.....': '5',
    '-....': '6',
    '--...': '7',
    '---..': '8',
    '----.': '9',
    '-----': '0',
    '.-.-.-': '.',
    '--..--': ',',
    '..--..': '?'
  };

  // Default event for empty string.
  HomeEvent event = ConvertedMorseCodeEvent(text: "");

  // Convert morse code to plain text. Emit events based on valid input.
  void convertMorseCode(String morseCode) {
    // Words are delimited by three space characters.
    List<String> words = morseCode.split("   ");
    List<String> letters = [];

    // Letters are delimited by a space character.
    for (final word in words) {
      letters.addAll(word.split(' '));
    }

    String text = "";

    for (final letter in letters) {
      // Check if the letter is invalid.
      if (!morseToCharMap.containsKey(letter)) {
        // Update event to InvalidMorseCodeEvent.
        event = InvalidMorseCodeEvent();

        // Notify the widgets listening to this event.
        notifyListeners();

        return;
      }

      text += morseToCharMap[letter]!;
    }

    // If we're here, our morse code is converted.
    event = ConvertedMorseCodeEvent(text: text);
    notifyListeners();
  }
}

/// HomeEvent for classifying invalid or valid morse code.
abstract class HomeEvent {}

/// InvalidMorseCodeEvent is emitted when conversion fails.
class InvalidMorseCodeEvent extends HomeEvent {}

/// ConvertedMorseCodeEvent is emitted when the conversion is successful.
class ConvertedMorseCodeEvent extends HomeEvent {
  final String text;

  ConvertedMorseCodeEvent({required this.text});
}

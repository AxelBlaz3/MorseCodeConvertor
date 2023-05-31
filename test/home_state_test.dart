import 'package:morse_text/home_state.dart';
import 'package:test/test.dart';

void main() {
  group('Home state unit tests', () {
    test('Intial event should be ConvertedMorseCodeEvent', () {
      final state = HomeState();

      expect(true, state.event is ConvertedMorseCodeEvent);
    });

    test('Initial text should be an empty string', () {
      final state = HomeState();
      final event = state.event as ConvertedMorseCodeEvent;

      expect("", event.text);
    });
  });
}

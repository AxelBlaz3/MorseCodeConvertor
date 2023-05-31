import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_state.dart';

/// A simple widget for showing Title.
class MorseTitle extends StatelessWidget {
  const MorseTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      title,
      style: theme.typography.englishLike.headlineLarge
          ?.copyWith(color: theme.colorScheme.onSurface),
    );
  }
}

/// A simple widget for taking the morse code input.
class MorseTextField extends StatelessWidget {
  const MorseTextField(
      {super.key, required TextEditingController morseTextFieldController})
      : _morseTextFieldController = morseTextFieldController;

  final TextEditingController _morseTextFieldController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: _morseTextFieldController,
      decoration: InputDecoration(
        labelText: 'Morse code',
        hintText: 'Enter morse code',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.secondary)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.primary)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.primary)),
      ),
    );
  }
}

class MorseElevatedButton extends StatelessWidget {
  const MorseElevatedButton({
    super.key,
    required TextEditingController morseTextFieldController,
  }) : _morseTextFieldController = morseTextFieldController;

  final TextEditingController _morseTextFieldController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<HomeState>();

    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            minimumSize: const Size.fromHeight(48)),
        onPressed: () {
          state.convertMorseCode(_morseTextFieldController.text.trim());
        },
        child: const Text("Convert"));
  }
}

class MorsePlaceholder extends StatelessWidget {
  const MorsePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Nothing",
          style: theme.textTheme.displayMedium
              ?.copyWith(color: theme.colorScheme.onSecondaryContainer),
        ),
        const SizedBox(
          height: 24.0,
        ),
        Text("(>.<)",
            style: theme.textTheme.displayMedium
                ?.copyWith(color: theme.colorScheme.onSecondaryContainer)),
      ],
    );
  }
}

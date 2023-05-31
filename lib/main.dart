import 'package:flutter/material.dart';
import 'package:morse_text/home_state.dart';
import 'package:provider/provider.dart';

import 'color_scheme.dart';
import 'morse_widgets.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => HomeState(), child: const MorseToTextApp()));
}

class MorseToTextApp extends StatefulWidget {
  const MorseToTextApp({super.key});

  @override
  State<MorseToTextApp> createState() => _MorseToTextAppState();
}

class _MorseToTextAppState extends State<MorseToTextApp> {
  final TextEditingController _morseTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: Scaffold(
        body: HomeScreen(morseTextFieldController: _morseTextFieldController),
      ),
    );
  }

  @override
  void dispose() {
    _morseTextFieldController.dispose();
    super.dispose();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required TextEditingController morseTextFieldController,
  }) : _morseTextFieldController = morseTextFieldController;

  final TextEditingController _morseTextFieldController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => constraints.maxWidth >= 600
            ? TabletScreen(
                morseTextFieldController: _morseTextFieldController,
              )
            : MobileScreen(
                morseTextFieldController: _morseTextFieldController,
              ));
  }
}

class TabletScreen extends StatelessWidget {
  const TabletScreen({
    super.key,
    required TextEditingController morseTextFieldController,
  }) : _morseTextFieldController = morseTextFieldController;

  final TextEditingController _morseTextFieldController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const MorseTitle(title: "Morse Code Convertor"),
                const SizedBox(
                  height: 32.0,
                ),
                MorseTextField(
                  morseTextFieldController: _morseTextFieldController,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                MorseElevatedButton(
                    morseTextFieldController: _morseTextFieldController),
                const SizedBox(
                  height: 16.0,
                )
              ],
            ),
          ),
        ),
        const Expanded(
          child: PlainTextTabletScreen(),
        )
      ],
    );
  }
}

class PlainTextTabletScreen extends StatelessWidget {
  const PlainTextTabletScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<HomeState>();

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: theme.colorScheme.secondaryContainer,
      child: Center(
          child: state.event is ConvertedMorseCodeEvent &&
                  (state.event as ConvertedMorseCodeEvent).text.isNotEmpty
              ? Text(
                  (state.event as ConvertedMorseCodeEvent).text,
                  style: theme.textTheme.displayMedium
                      ?.copyWith(color: theme.colorScheme.onSecondaryContainer),
                )
              : const MorsePlaceholder()),
    );
  }
}

class MobileScreen extends StatelessWidget {
  const MobileScreen({
    super.key,
    required TextEditingController morseTextFieldController,
  }) : _morseTextFieldController = morseTextFieldController;

  final TextEditingController _morseTextFieldController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const MorseTitle(
            title: "Morse Code Convertor",
          ),
          const SizedBox(
            height: 24.0,
          ),
          const Expanded(child: PlainTextMobileScreen()),
          const SizedBox(
            height: 32.0,
          ),
          MorseTextField(
            morseTextFieldController: _morseTextFieldController,
          ),
          const SizedBox(
            height: 16.0,
          ),
          MorseElevatedButton(
              morseTextFieldController: _morseTextFieldController),
          const SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }
}

class PlainTextMobileScreen extends StatelessWidget {
  const PlainTextMobileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeState>();
    final theme = Theme.of(context);

    return Container(
        decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(24.0)),
        width: double.infinity,
        child: Center(
            child: state.event is ConvertedMorseCodeEvent &&
                    (state.event as ConvertedMorseCodeEvent).text.isNotEmpty
                ? Text(
                    (state.event as ConvertedMorseCodeEvent).text,
                    style: theme.textTheme.headlineMedium?.copyWith(
                        color: theme.colorScheme.onSecondaryContainer),
                  )
                : const MorsePlaceholder()));
  }
}

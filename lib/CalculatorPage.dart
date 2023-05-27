import 'package:calculator/Providers/CurrentCalculations.dart';
import 'package:calculator/Util/CalculatorButton.dart';
import 'package:calculator/Util/HexToColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> values = [
  "AC",
  "\( \)",
  "%",
  "÷",
  "7",
  "8",
  "9",
  "×",
  "4",
  "5",
  "6",
  "-",
  "1",
  "2",
  "3",
  "+",
  "+/-",
  "0",
  ".",
  "="
];

class CalculatorPage extends ConsumerWidget {
  CalculatorPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var currentCalculations = ref.watch(currentCalculationsProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Text(currentCalculations),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(40)),
                color: isDarkMode ? HexColor("#292D36") : HexColor("#F9F9F9")),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: CalculatorButton(values[index], index),
                );
              },
              itemCount: 20,
            ),
          )
        ],
      ),
    );
  }
}

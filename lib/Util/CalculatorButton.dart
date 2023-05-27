import 'package:calculator/Providers/CurrentCalculations.dart';
import 'package:calculator/Util/HexToColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculatorButton extends ConsumerWidget {
  CalculatorButton(this.value, this.index, {super.key});
  String value;
  int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    int i;
    Color buttonColor;
    if ([0, 1, 2].contains(index)) {
      i = 1;
    } else if ([3, 7, 11, 15, 19].contains(index)) {
      i = 2;
    } else {
      i = 3;
    }
    switch (i) {
      case 1:
        buttonColor = HexColor("#51FAD9");
        break;
      case 2:
        buttonColor = HexColor("#EB6566");
        break;
      default:
        buttonColor = isDarkMode ? Colors.white.withOpacity(0.9) : Colors.black;
    }
    return ElevatedButton(
      onPressed: () {
        ref.read(currentCalculationsProvider.notifier).addCalculations(value);
      },
      child: Text(
        value,
        style: i == 2
            ? Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: buttonColor)
            : Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w500, color: buttonColor),
      ),
    );
  }
}

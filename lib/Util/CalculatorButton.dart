import 'package:calculator/Providers/CalculatorProvider.dart';
import 'package:calculator/Util/HexToColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String format(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
}

class CalculatorButton extends ConsumerWidget {
  CalculatorButton(this.value, this.index, {super.key});
  String value;
  int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    int i;
    Color buttonTextColor;
    if (index == 0) {
      i = 1;
    } else if ([1, 2, 3, 7, 11, 15, 19].contains(index)) {
      i = 2;
    } else {
      i = 3;
    }
    switch (i) {
      case 1:
        buttonTextColor = HexColor("#F76C60");
        break;
      case 2:
        if (index == 19) {
          buttonTextColor = Colors.white;
        } else {
          buttonTextColor = HexColor("#79D740");
        }
        break;
      default:
        buttonTextColor =
            isDarkMode ? Colors.white.withOpacity(0.9) : Colors.black;
    }
    return ElevatedButton(
      style: index == 19
          ? Theme.of(context).elevatedButtonTheme.style!.copyWith(
              backgroundColor: MaterialStatePropertyAll(HexColor("#437D03")))
          : Theme.of(context).elevatedButtonTheme.style,
      onPressed: () {
        OnPress(value, ref);
        // String exp = ref.read(equationProvider.notifier).addEquation(value);
        // ref.read(resultProvider.notifier).calculateEquation(exp);
      },
      child: Text(
        value,
        style: [3, 7, 11, 15, 19].contains(index)
            ? Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: buttonTextColor)
            : Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w500, color: buttonTextColor),
      ),
    );
  }
}

void OnPress(String value, WidgetRef ref) {
  if (value == "=") {
    var result = double.tryParse(ref.watch(resultProvider)) != null
        ? format(double.parse(ref.watch(resultProvider)))
        : "";
    ref.read(equationProvider.notifier).updateEquation(result);
    ref.read(resultProvider.notifier).updateResult("");
  } else if (value == "AC") {
    ref.read(equationProvider.notifier).updateEquation("");
    ref.read(resultProvider.notifier).updateResult("");
  }
  // else if (value == "( )") {
  //   String expression = ref.read(equationProvider);
  //   print(expression[expression.length - 1]);
  //   if (RegExp(r"[]").hasMatch(expression[expression.length - 1])) {
  //     value = "×(";
  //   }
  //   if (RegExp(r"\+-%×÷").hasMatch(expression[expression.length - 1])) {
  //     value = "(";
  //   } else {
  //     value = ")";
  //   }
  //   String exp = ref.read(equationProvider.notifier).addEquation(value);
  //   ref.read(resultProvider.notifier).calculateEquation(exp);
  // }
  else {
    String exp = ref.read(equationProvider.notifier).addEquation(value);
    ref.read(resultProvider.notifier).calculateEquation(exp);
  }
}

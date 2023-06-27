import 'package:calculator/Providers/CalculatorProvider.dart';
import 'package:calculator/Util/BottomHistorySheet.dart';
import 'package:calculator/Util/CalculatorButton.dart';
import 'package:calculator/Util/HexToColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> values = [
  "AC",
  "( )",
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
String format(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
}

class CalculatorPage extends ConsumerWidget {
  CalculatorPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    var equation = ref.watch(equationProvider);
    var result = double.tryParse(ref.watch(resultProvider)) != null
        ? format(double.parse(ref.watch(resultProvider)))
        : "";
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(bottom: 30, right: 20),
              child: Hero(
                transitionOnUserGestures: true,
                tag: 1,
                child: Text(
                  equation,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(bottom: 30, right: 25),
              child: Hero(
                transitionOnUserGestures: true,
                tag: 1,
                child: Text(
                  "${result}",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => showModalBottomSheet(
                          isDismissible: true,
                          barrierColor: Colors.transparent,
                          backgroundColor: Colors.redAccent,
                          context: context,
                          builder: (context) {
                            return BottomHistorySheet();
                          },
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.5)),
                      icon: Icon(
                        Icons.watch_later_outlined,
                        color: Theme.of(context).iconTheme.color,
                      )),
                  IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.backspace_outlined,
                        color: HexColor("#79D740"),
                      ))
                ],
              ),
            ),
            const Divider(
              indent: 15,
              thickness: 2,
              endIndent: 15,
            ),
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: CalculatorButton(values[index], index),
                );
              },
              itemCount: 20,
            )
          ],
        ),
      )),
    );
  }
}

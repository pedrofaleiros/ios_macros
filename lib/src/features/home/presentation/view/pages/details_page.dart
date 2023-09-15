import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  static const routeName = '/meal-details';
  @override
  Widget build(BuildContext context) {
    final meals = context.read<MealViewmodel>().meals;

    Map<String, double> map = calculateMacros(meals);

    Map<String, double> dataMap = {
      "carb": map['carb'] ?? 0,
      "prot": map['prot'] ?? 0,
      "fat": map['fat'] ?? 0,
    };

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Detalhes'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PieChart(
                legendOptions: const LegendOptions(
                  showLegends: false,
                ),
                chartRadius: 200,
                dataMap: dataMap,
                colorList: const [
                  CupertinoColors.systemRed,
                  CupertinoColors.systemBlue,
                  CupertinoColors.systemOrange,
                ],
              ),
              const SizedBox(height: 8),
              _carb(map),
              const _divider(),
              _prot(map),
              const _divider(),
              _fat(map),
              const _divider(),
              _kcal(map),
              const SizedBox(height: 16),
              PercentList(map: map),
            ],
          ),
        ),
      ),
    );
  }

  Row _kcal(Map<String, double> map) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Calorias: ",
          style: TextStyle(
            color: CupertinoColors.systemMint,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        Text(
          "${map['kcal']!.toInt()}",
          style: TextStyle(
            color: CupertinoColors.systemMint,
            // fontWeight: FontWeight.,
            fontSize: 24,
          ),
        ),
      ],
    );
  }

  Row _fat(Map<String, double> map) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Gorduras:",
          style: TextStyle(
            color: CupertinoColors.systemOrange,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        Text(
          "${map['fat']!.toInt()} g",
          style: TextStyle(
            color: CupertinoColors.systemOrange,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Row _prot(Map<String, double> map) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Proteínas: ",
          style: TextStyle(
            color: CupertinoColors.systemBlue,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        Text(
          "${map['prot']!.toInt()} g",
          style: TextStyle(
            color: CupertinoColors.systemBlue,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Row _carb(Map<String, double> map) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Carboidratos: ",
          style: TextStyle(
            color: CupertinoColors.systemRed,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        Text(
          "${map['carb']!.toInt()} g",
          style: TextStyle(
            color: CupertinoColors.systemRed,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}

class PercentList extends StatefulWidget {
  const PercentList({
    super.key,
    required this.map,
  });

  final Map<String, double> map;

  @override
  State<PercentList> createState() => _PercentListState();
}

class _PercentListState extends State<PercentList> {
  List<String> texts = [
    "Kcal",
    "Carboidratos",
    "Proteínas",
    "Gorduras",
  ];

  int selected = 0;
  double barWidth = 75.0;
  double barHeight = 7.0;

  @override
  Widget build(BuildContext context) {
    final meals = context.read<MealViewmodel>().meals;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selected++);
        },
        child: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (BuildContext context, int index) {
            double value = 0;
            double percent = 0;
            switch (selected % 4) {
              case 0:
                value = calculateMealMacros(meals[index])['kcal']!;
                if (widget.map['kcal']! == 0) {
                  percent = 0;
                } else {
                  percent = value / widget.map['kcal']!;
                }
                break;
              case 1:
                value = calculateMealMacros(meals[index])['carb']!;
                if (widget.map['kcal']! == 0) {
                  percent = 0;
                } else {
                  percent = value / widget.map['carb']!;
                }
                break;
              case 2:
                value = calculateMealMacros(meals[index])['prot']!;
                if (widget.map['kcal']! == 0) {
                  percent = 0;
                } else {
                  percent = value / widget.map['prot']!;
                }
                break;
              case 3:
                value = calculateMealMacros(meals[index])['fat']!;
                if (widget.map['kcal']! == 0) {
                  percent = 0;
                } else {
                  percent = value / widget.map['fat']!;
                }
                break;
              default:
                break;
            }

            return CupertinoListTile(
              padding: const EdgeInsets.all(0),
              title: Text(meals[index].name),
              subtitle: Text(
                texts[selected % 4],
                style: TextStyle(color: _getColor(selected % 4)),
              ),
              trailing: Row(
                children: [
                  Text(
                    '${(percent * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getColor(selected % 4),
                    ),
                  ),
                  SizedBox(width: 4),
                  Stack(
                    children: [
                      Container(
                        height: barHeight,
                        width: barWidth,
                        decoration: BoxDecoration(
                            color: CupertinoColors.systemGroupedBackground,
                            borderRadius: BorderRadius.circular(2)),
                      ),
                      Container(
                        height: barHeight,
                        width: barWidth * percent,
                        decoration: BoxDecoration(
                            color: _getColor(selected % 4),
                            borderRadius: BorderRadius.circular(2)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Color _getColor(int value) {
  if (value == 0) {
    return CupertinoColors.systemMint;
  }
  if (value == 1) {
    return CupertinoColors.systemRed;
  }
  if (value == 2) {
    return CupertinoColors.systemBlue;
  } else {
    return CupertinoColors.systemOrange;
  }
}

class _divider extends StatelessWidget {
  const _divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 0.2,
        width: double.infinity,
        color: CupertinoColors.systemGroupedBackground,
      ),
    );
  }
}

Map<String, double> calculateMacros(List<MealModel> meals) {
  if (meals.isEmpty) return {"kcal": 0, "carb": 0, "prot": 0, "fat": 0};
  double kcal = 0;
  double carb = 0;
  double prot = 0;
  double fat = 0;

  for (var meal in meals) {
    for (var item in meal.items) {
      kcal += item.food.kcal / 100 * item.amount;
      carb += item.food.carb / 100 * item.amount;
      prot += item.food.prot / 100 * item.amount;
      fat += item.food.fat / 100 * item.amount;
    }
  }

  return {
    "kcal": kcal,
    "carb": carb,
    "prot": prot,
    "fat": fat,
  };
}

Map<String, double> calculateMealMacros(MealModel meal) {
  double kcal = 0;
  double carb = 0;
  double prot = 0;
  double fat = 0;

  for (var item in meal.items) {
    kcal += item.food.kcal / 100 * item.amount;
    carb += item.food.carb / 100 * item.amount;
    prot += item.food.prot / 100 * item.amount;
    fat += item.food.fat / 100 * item.amount;
  }

  return {
    "kcal": kcal,
    "carb": carb,
    "prot": prot,
    "fat": fat,
  };
}

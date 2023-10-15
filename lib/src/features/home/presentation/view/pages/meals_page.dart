import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/meal_widget.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/meals_is_empty.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/meals_page_navbar.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthViewmodel>();
    final mealsViewmodel = context.read<MealViewmodel>();

    return CupertinoPageScaffold(
      child: Observer(
        builder: (_) => SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              const MealsPageNavBar(),
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  if (auth.isAuth) {
                    final token = auth.sessionUser!.token;
                    await mealsViewmodel.getMeals(token);
                  }
                },
              ),
              mealsViewmodel.meals.isEmpty
                  ? const MealsIsEmpty()
                  : _mealsList(mealsViewmodel.meals),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mealsList(List<MealModel> meals) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: meals.length,
        (context,
                index) => /* index == meals.length - 1
            ? Column(
                children: [
                  MealWidget(meal: meals[index]),
                  const TotalMacrosWidget(),
                ],
              )
            : */
            MealWidget(meal: meals[index]),
      ),
    );
  }
}

class TotalMacrosWidget extends StatelessWidget {
  const TotalMacrosWidget({
    super.key,
  });

  Map<String, double> getTotalMacros(List<MealModel> list) {
    double kcal = 0;
    double carb = 0;
    double prot = 0;
    double fats = 0;

    for (var meal in list) {
      for (var item in meal.items) {
        kcal += item.food.kcal / 100 * item.amount;
        carb += item.food.carb / 100 * item.amount;
        prot += item.food.prot / 100 * item.amount;
        fats += item.food.fat / 100 * item.amount;
      }
    }

    return {
      "kcal": kcal,
      "carb": carb,
      "prot": prot,
      "fats": fats,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final meals = context.read<MealViewmodel>().meals;

        final map = getTotalMacros(meals);

        final double kcal = map["kcal"]!;
        final double carb = map["carb"]!;
        final double prot = map["prot"]!;
        final double fats = map["fats"]!;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const Text(
                    ' ',
                    style: TextStyle(
                      fontSize: 22,
                      color: CupertinoColors.systemMint,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${kcal.toInt()} Kcals',
                    style: const TextStyle(
                      fontSize: 22,
                      color: CupertinoColors.systemMint,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "C: ${carb.toStringAsFixed(1)} g",
                    style: const TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.systemRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "P: ${prot.toStringAsFixed(1)} g",
                    style: const TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.systemBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "G: ${fats.toStringAsFixed(1)} g",
                    style: const TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.systemOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

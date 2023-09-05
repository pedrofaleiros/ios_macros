import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/create_meal_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/draggable_foods_page/meal_target.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

class MealsTargetList extends StatelessWidget {
  const MealsTargetList({
    super.key,
    required this.scrollController,
    // required this.opacity,
  });

  final ScrollController scrollController;
  // final double opacity;

  @override
  Widget build(BuildContext context) {
    final mealsController = context.read<MealViewmodel>();
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: mealsController.meals.length,
        itemBuilder: (context, index) {
          return (index == mealsController.meals.length - 1)
              ? Row(
                  children: [
                    MealTarget(meal: mealsController.meals[index]),
                    CupertinoButton(
                      child: const Icon(CupertinoIcons.add),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        CreateMealPage.routeName,
                      ),
                    )
                  ],
                )
              : MealTarget(meal: mealsController.meals[index]);
        },
      ),
    );
  }
}

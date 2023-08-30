import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/draggable_foods_page/meal_target.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

class MealsTargetList extends StatelessWidget {
  const MealsTargetList({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

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
          return MealTarget(meal: mealsController.meals[index]);
        },
      ),
    );
  }
}

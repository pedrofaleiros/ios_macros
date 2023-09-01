import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/draggable_foods_page/draggable_food.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/letter_label.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/draggable_foods_page/meals_target_list.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/food_viewmodel.dart';
import 'package:ios_macros/src/utils/widgets/loading_page.dart';
import 'package:provider/provider.dart';

class DraggablePageContent extends StatefulWidget {
  const DraggablePageContent({
    super.key,
  });

  @override
  State<DraggablePageContent> createState() => _DraggablePageContentState();
}

class _DraggablePageContentState extends State<DraggablePageContent> {
  TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  Widget _searchFoodTextField(FoodViewmodel foodsController, String token) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoSearchTextField(
        controller: textController,
        onSubmitted: (value) async => await foodsController.getFoodsWithName(
          token,
          textController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final token = context.read<AuthViewmodel>().sessionUser!.token;
    final foodsController = context.read<FoodViewmodel>();

    return Observer(
      builder: (_) => Column(
        children: [
          _searchFoodTextField(foodsController, token),
          Expanded(
            child: foodsController.isLoading
                ? const LoadingPage()
                : ListView.builder(
                    itemCount: foodsController.foods.length,
                    itemBuilder: (context, index) {
                      final food = foodsController.foods[index];

                      return Column(
                        children: [
                          if (_showLabel(index, foodsController))
                            LetterLabel(
                              text: food.name[0],
                            ),
                          DraggableFood(
                            scrollController: scrollController,
                            food: food,
                          ),
                        ],
                      );
                    },
                  ),
          ),
          MealsTargetList(scrollController: scrollController),
        ],
      ),
    );
  }

  bool _showLabel(int index, FoodViewmodel foodsController) {
    return index == 0 ||
        foodsController.foods[index].name[0].toUpperCase() !=
            foodsController.foods[index - 1].name[0].toUpperCase();
  }
}

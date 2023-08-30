import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/feedback.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/foods_list_tile.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/letter_label.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/meal_target.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/food_viewmodel.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:ios_macros/src/utils/widgets/loading_page.dart';
import 'package:provider/provider.dart';

class DraggableFoodsPage extends StatelessWidget {
  const DraggableFoodsPage({super.key});

  static const routeName = '/foods-drag';

  @override
  Widget build(BuildContext context) {
    final token = context.read<AuthViewmodel>().sessionUser!.token;
    final foodsController = context.read<FoodViewmodel>();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Adicione alimentos'),
      ),
      child: SafeArea(
        child: FutureBuilder(
          future: foodsController.getFoods(token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage(message: 'Carregando alimentos');
            }

            return const PageContent();
          },
        ),
      ),
    );
  }
}

class PageContent extends StatefulWidget {
  const PageContent({
    super.key,
  });

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final token = context.read<AuthViewmodel>().sessionUser!.token;
    final foodsController = context.read<FoodViewmodel>();
    final mealsController = context.read<MealViewmodel>();

    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              _searchFoodTextField(foodsController, token),
              Expanded(
                child: foodsController.isLoading
                    ? const LoadingPage()
                    : ListView.builder(
                        itemCount: foodsController.foods.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            if (index == 0 ||
                                foodsController.foods[index].name[0]
                                        .toUpperCase() !=
                                    foodsController.foods[index - 1].name[0]
                                        .toUpperCase())
                              LetterLabel(
                                  text: foodsController.foods[index].name[0]),
                            LongPressDraggable<FoodModel>(
                              onDragUpdate: (details) {
                                double scrollThreshold = 100.0;
                                double speed = 5;

                                // Verifica se o arrasto está dentro da área onde a rolagem deveria ocorrer
                                if (details.globalPosition.dy <
                                    MediaQuery.of(context).size.height -
                                        (MediaQuery.of(context).size.height *
                                            0.25)) return;

                                // Rola para a direita se não estivermos já no final
                                if (details.globalPosition.dx >
                                    (MediaQuery.of(context).size.width -
                                        scrollThreshold)) {
                                  if (scrollController.position.pixels <
                                      scrollController
                                          .position.maxScrollExtent) {
                                    scrollController.jumpTo(
                                        scrollController.position.pixels +
                                            speed);
                                  }
                                }

                                // Rola para a esquerda se não estivermos já no começo
                                if (details.globalPosition.dx <
                                    scrollThreshold) {
                                  if (scrollController.position.pixels >
                                      scrollController
                                          .position.minScrollExtent) {
                                    scrollController.jumpTo(
                                        scrollController.position.pixels -
                                            speed);
                                  }
                                }
                              },
                              // dragAnchorStrategy: pointerDragAnchorStrategy,
                              dragAnchorStrategy: childDragAnchorStrategy,
                              data: foodsController.foods[index],
                              feedback:
                                  FeedBack(food: foodsController.foods[index]),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: FoodListTile(
                                    food: foodsController.foods[index]),
                              ),
                            ),
                            if(index == foodsController.foods.length - 1) SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: double.infinity,
                              // color: CupertinoColors.activeGreen,
                            )
                          ],
                        ),
                      ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: mealsController.meals.length,
              itemBuilder: (context, index) {
                return MealTarget(meal: mealsController.meals[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _searchFoodTextField(FoodViewmodel foodsController, String token) {
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
}


/* 


 */
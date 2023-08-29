import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/domain/model/item_model.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/foods_list_tile.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/letter_label.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/macros_row.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/food_viewmodel.dart';
import 'package:ios_macros/src/utils/widgets/loading_page.dart';
import 'package:provider/provider.dart';

class FoodsPage extends StatefulWidget {
  const FoodsPage({super.key});

  static const routeName = '/foods';

  @override
  State<FoodsPage> createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final token = context.read<AuthViewmodel>().sessionUser!.token;
    final foodsController = context.read<FoodViewmodel>();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Alimentos'),
      ),
      child: SafeArea(
        child: FutureBuilder(
          future: foodsController.getFoods(token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage(message: 'Carregando alimentos');
            }

            return Observer(
                builder: (_) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CupertinoSearchTextField(
                            controller: textController,
                            onChanged: (value) async =>
                                await foodsController.getFoodsWithName(
                              token,
                              textController.text,
                            ),
                          ),
                        ),
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
                                              foodsController
                                                  .foods[index - 1].name[0]
                                                  .toUpperCase())
                                        LetterLabel(
                                          text: foodsController
                                              .foods[index].name[0],
                                        ),
                                      FoodListTile(
                                        food: foodsController.foods[index],
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ));
          },
        ),
      ),
    );
  }
}

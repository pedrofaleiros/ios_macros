import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/foods_list_tile.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/letter_label.dart';
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
    final auth = context.read<AuthViewmodel>();

    if (!auth.isAuth) {
      return const Placeholder();
    }

    final token = auth.sessionUser!.token;
    final foodsController = context.read<FoodViewmodel>();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Alimentos'),
      ),
      child: SafeArea(
        child: FutureBuilder(
          future: foodsController.getFoods(token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage(message: 'Carregando alimentos...');
            }

            return _content(foodsController, token);
          },
        ),
      ),
    );
  }

  Widget _content(FoodViewmodel foodsController, String token) {
    return Observer(
      builder: (_) => Column(
        children: [
          _searchTextField(foodsController, token),
          Expanded(
            child: foodsController.isLoading
                ? const LoadingPage(message: 'Carregando alimentos')
                : ListView.builder(
                    itemCount: foodsController.foods.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        if (showLabel(index, foodsController))
                          LetterLabel(
                            text: foodsController.foods[index].name[0],
                          ),
                        FoodListTile(
                          food: foodsController.foods[index],
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Padding _searchTextField(FoodViewmodel foodsController, String token) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoSearchTextField(
        placeholder: 'Buscar por nome',
        controller: textController,
        onChanged: (_) async =>
            await foodsController.getFoodsWithName(token, textController.text),
      ),
    );
  }

  bool showLabel(int index, FoodViewmodel foodsController) {
    return index == 0 ||
        foodsController.foods[index].name[0].toUpperCase() !=
            foodsController.foods[index - 1].name[0].toUpperCase();
  }
}

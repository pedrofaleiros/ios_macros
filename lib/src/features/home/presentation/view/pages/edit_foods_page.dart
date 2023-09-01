import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/create_food_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/foods_list_tile.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/letter_label.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/food_viewmodel.dart';
import 'package:ios_macros/src/utils/widgets/loading_page.dart';
import 'package:provider/provider.dart';

class EditFoodsPage extends StatefulWidget {
  const EditFoodsPage({super.key});

  static const routeName = '/edit-foods';

  @override
  State<EditFoodsPage> createState() => _EditFoodsPageState();
}

class _EditFoodsPageState extends State<EditFoodsPage> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthViewmodel>();
    if (!auth.isAuth || auth.sessionUser!.name != 'admin') {
      return const Placeholder();
    }
    final token = auth.sessionUser!.token;
    final foodsController = context.read<FoodViewmodel>();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Editar alimentos'),
        trailing: CupertinoButton(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(0),
          onPressed: () {
            Navigator.pushNamed(context, CreateFoodPage.routeName);
          },
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: SafeArea(
        child: FutureBuilder(
          future: foodsController.getFoods(token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage(message: 'Carregando alimentos');
            }

            return _content(foodsController, token);
          },
        ),
      ),
    );
  }

  Widget get _background => Container(
        color: CupertinoColors.systemRed,
        alignment: Alignment.centerRight,
        child: const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(
            CupertinoIcons.delete,
            color: CupertinoColors.white,
          ),
        ),
      );

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
                    itemBuilder: (context, index) {
                      final food = foodsController.foods[index];
                      return Column(
                        children: [
                          if (showLabel(index, foodsController))
                            LetterLabel(
                              text: food.name[0],
                            ),
                          Dismissible(
                            key: Key(food.id),
                            direction: DismissDirection.endToStart,
                            dismissThresholds: const {
                              DismissDirection.endToStart: 0.3,
                            },
                            onDismissed: (_) async =>
                                await foodsController.deleteFood(
                              token,
                              food.id,
                            ),
                            background: _background,
                            confirmDismiss: (_) async => await _showDialog(
                              context,
                              food.name,
                            ),
                            child: FoodListTile(
                              food: food,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context, String name) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Confirmar ação'),
        content: Text('Remover "$name" dos alimentos?'),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Padding _searchTextField(FoodViewmodel foodsController, String token) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoSearchTextField(
        onSuffixTap: () async {
          await foodsController.getFoods(token);
        },
        placeholder: 'Buscar por nome',
        controller: textController,
        onSubmitted: (_) async =>
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

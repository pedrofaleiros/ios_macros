import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/data/dto/item_dto.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/food_viewmodel.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:ios_macros/src/utils/last_amount_food.dart';
import 'package:ios_macros/src/utils/widgets/loading_page.dart';
import 'package:provider/provider.dart';

class CreateItemPage extends StatefulWidget {
  const CreateItemPage({super.key});

  static const routeName = '/create-item';

  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  bool isLiquid = false;

  Future<double> getLastAmount(String foodId) async {
    return await LastAmoutFood().getLastAmount(foodId);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    FoodModel food = args['food'] ?? FoodModel.empty();
    String mealId = args['mealId'] ?? '';

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(food.name),
      ),
      child: SafeArea(
        child: FutureBuilder(
          future: getLastAmount(food.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage(
                message: 'Carregando...',
              );
            }

            if (snapshot.hasData) {
              return PageContent(
                amount: snapshot.data!,
                food: food,
                mealId: mealId,
              );
            } else {
              return PageContent(
                amount: 100,
                food: food,
                mealId: mealId,
              );
            }
          },
        ),
      ),
    );
  }
}

class PageContent extends StatefulWidget {
  const PageContent({
    super.key,
    required this.amount,
    required this.food,
    required this.mealId,
  });

  final double amount;
  final FoodModel food;
  final String mealId;

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  TextEditingController textController = TextEditingController();

  double amount = 100;

  @override
  Widget build(BuildContext context) {
    final food = widget.food;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CupertinoTextField(
            controller: textController,
            onChanged: (value) => setState(
              () => amount = double.tryParse(value) ?? widget.amount,
            ),
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            placeholder: '${widget.amount}',
            prefix: const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                'Quantidade:',
                style: TextStyle(
                  color: CupertinoColors.systemGrey3,
                ),
              ),
            ),
            // prefixMode: OverlayVisibilityMode.notEditing,
          ),
          Macros(
            text: 'Kcal',
            amount: (food.kcal / 100 * amount).toStringAsFixed(0),
            color: CupertinoColors.systemMint,
          ),
          Macros(
            text: 'Carboidratos',
            amount: '${(food.carb / 100 * amount).toStringAsFixed(1)} g',
            color: CupertinoColors.systemRed,
          ),
          Macros(
            text: 'Proteínas',
            amount: '${(food.prot / 100 * amount).toStringAsFixed(1)} g',
            color: CupertinoColors.systemBlue,
          ),
          Macros(
            text: 'Gorduras',
            amount: '${(food.fat / 100 * amount).toStringAsFixed(1)} g',
            color: CupertinoColors.systemOrange,
          ),
          CupertinoButton.filled(
            onPressed: () async {
              if (textController.text.isEmpty) {
                amount = widget.amount;
              } else if (double.tryParse(textController.text) == null ||
                  double.parse(textController.text) <= 0) {
                return;
              }

              final auth = context.read<AuthViewmodel>();

              if (auth.isAuth) {
                final token = auth.sessionUser!.token;

                await context
                    .read<MealViewmodel>()
                    .createItem(
                      token,
                      ItemDTO(
                        mealId: widget.mealId,
                        foodId: food.id,
                        amount: amount,
                      ),
                    )
                    .then(
                  (value) async {
                    if (value) {
                      await LastAmoutFood()
                          .setLastAmount(
                            food.id,
                            amount,
                          )
                          .then(
                            (value) {
                              context.read<FoodViewmodel>().force();
                              Navigator.pop(context);
                            },
                          );
                    }
                  },
                );
              }
            },
            child: const Text(
              'Adicionar',
              style: TextStyle(
                color: CupertinoColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Macros extends StatelessWidget {
  const Macros({
    super.key,
    required this.amount,
    required this.color,
    required this.text,
  });

  final String text;
  final String amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        amount,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/domain/model/item_model.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

class EditItemPage extends StatefulWidget {
  const EditItemPage({super.key});

  static const routeName = '/edit-item';

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as ItemModel;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(item.food.name),
        transitionBetweenRoutes: false,
      ),
      child: SafeArea(
        child: PageContent(
          item: item,
          amount: item.amount,
          food: item.food,
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
    required this.item,
  });

  final double amount;
  final FoodModel food;
  final ItemModel item;

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  TextEditingController textController = TextEditingController();

  FocusNode focus = FocusNode();

  double amount = 100;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focus.requestFocus();
    });
  }

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final food = widget.food;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CupertinoTextField(
            focusNode: focus,
            controller: textController,
            onChanged: (value) => setState(
              () => amount = double.tryParse(value) ?? widget.amount,
            ),
            onSubmitted: (value) async {
              final token = context.read<AuthViewmodel>().sessionUser!.token;
              await context
                  .read<MealViewmodel>()
                  .updateItem(token, widget.item.copyWith(amount: amount))
                  .then((value) => {
                        if (value) {Navigator.pop(context)}
                      });
            },
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
          Observer(
            builder: (_) {
              final mealViewmodel = context.read<MealViewmodel>();
              return CupertinoButton.filled(
                onPressed: mealViewmodel.isLoading
                    ? null
                    : () async {
                        final token =
                            context.read<AuthViewmodel>().sessionUser!.token;
                        await context
                            .read<MealViewmodel>()
                            .updateItem(
                                token, widget.item.copyWith(amount: amount))
                            .then((value) => {
                                  if (value) {Navigator.pop(context)}
                                });
                      },
                child: mealViewmodel.isLoading
                    ? const CupertinoActivityIndicator()
                    : const Text(
                        'Adicionar',
                        style: TextStyle(
                          color: CupertinoColors.white,
                        ),
                      ),
              );
            },
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

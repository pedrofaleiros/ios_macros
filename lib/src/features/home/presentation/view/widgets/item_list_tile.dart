import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/domain/model/item_model.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/macros_row.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

class ItemListTile extends StatelessWidget {
  const ItemListTile({
    super.key,
    required this.item,
  });

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      dismissThresholds: const {
        DismissDirection.endToStart: 0.3,
      },
      confirmDismiss: (direction) async =>
          await _showDialog(context, item.food.name),
      onDismissed: (direction) async {
        final token = context.read<AuthViewmodel>().sessionUser!.token;
        await context.read<MealViewmodel>().deleteItem(token, item.id);
      },
      background: _background,
      child: _child,
    );
  }

  Future<dynamic> _showDialog(BuildContext context, String name) {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Confirmar ação'),
        content: Text('Remover "$name" da refeição?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, false),
            isDestructiveAction: true,
            child: const Text('Cancelar'),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, true),
            isDefaultAction: true,
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Widget get _child => CupertinoListTile(
        title: Text(
          item.food.name,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        subtitle: Text('${item.amount} ${item.food.liquid ? "ml" : "g"}'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${(item.food.kcal / 100 * item.amount).toStringAsFixed(0)} Kcal',
              style: const TextStyle(
                  fontSize: 14,
                  color: CupertinoColors.systemMint,
                  fontWeight: FontWeight.bold),
            ),
            MacrosRow(food: item.food, amount: item.amount,),
          ],
        ),
      );

  Widget get _background => Container(
        color: CupertinoColors.systemRed,
        height: 50,
        alignment: Alignment.centerRight,
        child: const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(
            CupertinoIcons.delete,
            color: CupertinoColors.white,
          ),
        ),
      );
}

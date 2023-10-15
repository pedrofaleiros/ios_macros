import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/domain/model/item_model.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/edit_item_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/macros_row.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

class ItemListTile extends StatelessWidget {
  const ItemListTile({
    super.key,
    required this.item,
  });

  final ItemModel item;

  Future<void> _deleteItem(BuildContext context) async {
    final auth = context.read<AuthViewmodel>();

    if (auth.isAuth) {
      final token = auth.sessionUser!.token;
      await context.read<MealViewmodel>().deleteItem(token, item.id);
    }
  }

  Future<dynamic> _showDialog(BuildContext context, String name) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Confirmar ação'),
        content: Text('Remover "$name" da refeição?'),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Navigator.pushNamed(context, EditItemPage.routeName, arguments: item);
      },
      child: Dismissible(
        key: Key(item.id),
        direction: DismissDirection.endToStart,
        dismissThresholds: const {
          DismissDirection.endToStart: 0.3,
        },
        onDismissed: (_) async => await _deleteItem(context),
        confirmDismiss: (_) async => await _showDialog(context, item.food.name),
        background: _background,
        child: _child,
      ),
    );
  }

  Widget get _child {
    String kcal = (item.food.kcal / 100 * item.amount).toStringAsFixed(0);
    String label = item.food.liquid ? "ml" : "g";
    return CupertinoListTile(
      title: Text(
        item.food.name,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      subtitle: Text('${item.amount} $label'),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _kcalText(kcal),
          MacrosRow(
            food: item.food,
            amount: item.amount,
          ),
        ],
      ),
    );
  }

  Text _kcalText(String kcal) => Text(
        '$kcal Kcal',
        style: const TextStyle(
          fontSize: 14,
          color: CupertinoColors.systemMint,
          fontWeight: FontWeight.bold,
        ),
      );

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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/draggable_foods_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/item_list_tile.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/macros_count.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/meal_title.dart';

class MealWidget extends StatelessWidget {
  const MealWidget({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => CupertinoListSection(
        header: MealTitle(meal: meal),
        // additionalDividerMargin: 0,
        dividerMargin: 0,
        hasLeading: false,
        topMargin: 4,
        children: [
          for (var item in meal.items) ItemListTile(item: item),
          // AddItemButton(),
          MacrosCount(meal: meal),
        ],
      ),
    );
  }
}

class AddItemButton extends StatelessWidget {
  const AddItemButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        Navigator.pushNamed(context, DraggableFoodsPage.routeName);
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Adicionar',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(width: 4),
          Icon(
            CupertinoIcons.add_circled_solid,
            size: 14,
          ),
        ],
      ),
    );
  }
}

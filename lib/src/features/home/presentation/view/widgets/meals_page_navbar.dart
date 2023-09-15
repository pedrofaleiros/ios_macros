import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/create_meal_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/details_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/draggable_foods_page.dart';

class MealsPageNavBar extends StatelessWidget {
  const MealsPageNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverNavigationBar(
      backgroundColor: CupertinoTheme.brightnessOf(context) == Brightness.dark
          ? CupertinoColors.systemBackground
          : null,
      stretch: false,
      // padding: const EdgeInsetsDirectional.all(1),
      largeTitle: const Text('Refeições'),
      leading: CupertinoButton(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0),
        onPressed: () => Navigator.pushNamed(context, DetailsPage.routeName),
        child: const Text('Detalhes'),
      ),
      // trailing: const AddItemButton(),
      trailing: const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AddItemButton(),
          AddMealButton(),
        ],
      ),
    );
  }
}

class AddMealButton extends StatelessWidget {
  const AddMealButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(4),
      onPressed: () => Navigator.pushNamed(
        context,
        CreateMealPage.routeName,
      ),
      child: const Icon(CupertinoIcons.add),
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
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(4),
      onPressed: () =>
          Navigator.pushNamed(context, DraggableFoodsPage.routeName),
      child: const Icon(CupertinoIcons.today_fill),
    );
  }
}

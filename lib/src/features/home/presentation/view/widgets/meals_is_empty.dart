import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/create_meal_page.dart';

class MealsIsEmpty extends StatelessWidget {
  const MealsIsEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: CupertinoButton(
          onPressed: () =>
              Navigator.pushNamed(context, CreateMealPage.routeName),
          child: const Text('Adicionar refeicao'),
        ),
      ),
    );
  }
}
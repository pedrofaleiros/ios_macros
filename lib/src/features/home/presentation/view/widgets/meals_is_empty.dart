import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/create_meal_page.dart';

class MealsIsEmpty extends StatelessWidget {
  const MealsIsEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 1,
        (context, index) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Nenhuma refeição'),
                CupertinoButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, CreateMealPage.routeName),
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

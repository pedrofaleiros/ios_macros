import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/create_meal_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/draggable_foods_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/meal_widget.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/meals_is_empty.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthViewmodel>();
    final mealsViewmodel = context.read<MealViewmodel>();

    return CupertinoPageScaffold(
      navigationBar: _navBar(context),
      child: Observer(
        builder: (_) => mealsViewmodel.meals.isEmpty
            ? const MealsIsEmpty()
            : SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    CupertinoSliverRefreshControl(
                      onRefresh: () async {
                        if (auth.isAuth) {
                          final token = auth.sessionUser!.token;
                          await mealsViewmodel.getMeals(token);
                        }
                      },
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: mealsViewmodel.meals.length,
                        (context, index) => MealWidget(
                          meal: mealsViewmodel.meals[index],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  CupertinoNavigationBar _navBar(BuildContext context) {
    return CupertinoNavigationBar(
      padding: const EdgeInsetsDirectional.all(0),
      trailing: CupertinoButton(
        padding: _padding,
        onPressed: () =>
            Navigator.pushNamed(context, DraggableFoodsPage.routeName),
        child: const Icon(CupertinoIcons.today_fill),
      ),
      middle: const Text('Refeições'),
      leading: CupertinoButton(
        padding: _padding,
        onPressed: () async =>
            Navigator.pushNamed(context, CreateMealPage.routeName),
        child: const Icon(CupertinoIcons.add),
        // child: const Text('Sair'),
      ),
    );
  }

  EdgeInsets get _padding => const EdgeInsets.all(0);
}

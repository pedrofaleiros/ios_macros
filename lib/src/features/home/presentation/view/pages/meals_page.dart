import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
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
      // navigationBar: _navBar(context),
      child: Observer(
        builder: (_) => mealsViewmodel.meals.isEmpty
            ? const MealsIsEmpty()
            : SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    CupertinoSliverNavigationBar(
                      backgroundColor: CupertinoTheme.brightnessOf(context) ==
                              Brightness.dark
                          ? CupertinoColors.systemBackground
                          : null,
                      stretch: false,
                      // padding: const EdgeInsetsDirectional.all(0),
                      leading: CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          CreateMealPage.routeName,
                        ),
                        child: const Text('Adicionar'),
                      ),
                      largeTitle: const Text('Refeições'),
                      trailing: CupertinoButton(
                        alignment: Alignment.centerRight,
                        padding: _padding,
                        onPressed: () => Navigator.pushNamed(
                            context, DraggableFoodsPage.routeName),
                        child: const Icon(CupertinoIcons.today_fill),
                      ),
                    ),
                    CupertinoSliverRefreshControl(
                      onRefresh: () async {
                        if (auth.isAuth) {
                          final token = auth.sessionUser!.token;
                          await mealsViewmodel.getMeals(token);
                        }
                      },
                    ),
                    _mealsList(mealsViewmodel.meals),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _mealsList(List<MealModel> meals) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: meals.length,
        (context, index) => MealWidget(
          meal: meals[index],
        ),
      ),
    );

/* 
    lastItem(index, mealsViewmodel)
            ? _lastItemWidget(
                mealsViewmodel,
                index,
                context,
              )
            :  
*/
  }

  Widget _lastItemWidget(
    MealViewmodel mealsViewmodel,
    int index,
    BuildContext context,
  ) {
    return Column(
      children: [
        MealWidget(
          meal: mealsViewmodel.meals[index],
        ),
        CupertinoButton(
          onPressed: () => Navigator.pushNamed(
            context,
            CreateMealPage.routeName,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Adicionar refeição'),
              SizedBox(width: 4),
              Icon(CupertinoIcons.add)
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  bool lastItem(int index, MealViewmodel mealsViewmodel) =>
      index == mealsViewmodel.meals.length - 1;

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
    );
  }

  EdgeInsets get _padding => const EdgeInsets.all(0);
}

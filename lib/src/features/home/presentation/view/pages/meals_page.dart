import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/create_meal_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/draggable_foods_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/meal_widget.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:ios_macros/src/utils/widgets/loading_page.dart';
import 'package:provider/provider.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthViewmodel>();
    final mealsViewmodel = context.read<MealViewmodel>();

    return CupertinoPageScaffold(
      navigationBar: _navBar(context),
      child: SafeArea(
        child: Observer(
          builder: (context) {
            if (mealsViewmodel.isLoading) {
              return const LoadingPage();
            }

            return CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 300));
                    if (auth.isAuth) {
                      final token = auth.sessionUser!.token;
                      await mealsViewmodel.getMeals(token);
                    }
                  },
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => MealWidget(
                      meal: mealsViewmodel.meals[index],
                    ),
                    childCount: mealsViewmodel.meals.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  CupertinoNavigationBar _navBar(BuildContext context) {
    final auth = context.read<AuthViewmodel>();
    return CupertinoNavigationBar(
      padding: const EdgeInsetsDirectional.all(0),
      leading: CupertinoButton(
        alignment: Alignment.center,
        onPressed: () {
          Navigator.pushNamed(context, DraggableFoodsPage.routeName);
        },
        child: const Icon(CupertinoIcons.today_fill),
      ),
      middle: Text(auth.sessionUser!.name),
      trailing: CupertinoButton(
        padding: const EdgeInsets.all(0),
        alignment: Alignment.center,
        onPressed: () async {
          // await auth.logout();
          Navigator.pushNamed(context, CreateMealPage.routeName);
        },
        child: const Icon(CupertinoIcons.add),
        // child: const Text('Sair'),
      ),
    );
  }
}

// CupertinoSegmentedControl<int>(
//         groupValue: index,
//         children: const <int, Widget>{
//           0: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 4),
//             child: Text(
//               'Refeiçoes',
//               style: TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           1: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 4),
//             child: Text(
//               'Alimentos',
//               style: TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         },
//         onValueChanged: (value) {
//           setState(() {
//             index = value;
//           });
//         },
//       )
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/create_meal_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/draggable_foods_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/foods_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/meal_widget.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:ios_macros/src/utils/widgets/loading_page.dart';
import 'package:provider/provider.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _navBar(context),
      child: SafeArea(
        child: Observer(
          builder: (context) {
            final mealsViewmodel = context.read<MealViewmodel>();

            if(mealsViewmodel.isLoading){
              return LoadingPage();
            }

            return ListView.builder(
              itemCount: mealsViewmodel.meals.length,
              itemBuilder: (BuildContext context, int index) {
                return MealWidget(meal: mealsViewmodel.meals[index]);
              },
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
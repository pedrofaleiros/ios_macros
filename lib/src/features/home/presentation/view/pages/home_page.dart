import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/foods_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/meals_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/profile_page.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:ios_macros/src/utils/widgets/loading_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/home';

  Future<void> init(BuildContext context) async {
    if (context.read<AuthViewmodel>().sessionUser != null) {
      final token = context.read<AuthViewmodel>().sessionUser!.token;

      await context.read<MealViewmodel>().getMeals(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage(
            message: 'Carregando refeições...',
          );
        }

        return WillPopScope(
            onWillPop: () async {
              return await showCupertinoModalPopup(
                context: context,
                builder: (_) => CupertinoAlertDialog(
                  title: const Text('Deseja sair do app?'),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.pop(context, false),
                      isDestructiveAction: true,
                      child: const Text('Não'),
                    ),
                    CupertinoDialogAction(
                      onPressed: () => Navigator.pop(context, true),
                      isDefaultAction: true,
                      child: const Text('Sim'),
                    ),
                  ],
                ),
              );
            },
            child: const HomePageContent());
      },
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({
    super.key,
  });

  List<Widget> get pages => const [
        ProfilePage(),
        MealsPage(),
        FoodsPage(),
      ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: 1,
        iconSize: 24,
        border: null,
        backgroundColor: CupertinoColors.systemBackground,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            activeIcon: Icon(CupertinoIcons.house_fill),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.chartSimple),
          ),
        ],
      ),
      tabBuilder: (context, index) => pages[index],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/controller/login_controller.dart';
import 'package:ios_macros/src/features/auth/presentation/view/pages/login_page.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/create_meal_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/draggable_foods_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/foods_page.dart';
import 'package:ios_macros/src/features/home/presentation/view/pages/home_page.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/food_viewmodel.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:ios_macros/src/splash_page.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthViewmodel>(
          create: (_) => AuthViewmodel(),
        ),
        Provider<LoginController>(
          create: (context) => LoginController(),
        ),
        Provider<MealViewmodel>(
          create: (context) => MealViewmodel(),
        ),
        Provider<FoodViewmodel>(
          create: (context) => FoodViewmodel(),
        ),
      ],
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        routes: {
          SplashPage.routeName: (_) => const SplashPage(),
          LoginPage.routeName: (_) => const LoginPage(),
          // SignupPage.routeName: (_) => const SignupPage(),
          HomePage.routeName: (_) => const HomePage(),
          FoodsPage.routeName: (_) => const FoodsPage(),
          DraggableFoodsPage.routeName: (_) => const DraggableFoodsPage(),
          CreateMealPage.routeName: (_) => const CreateMealPage(),
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/draggable_foods_page/draggable_page_content.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/food_viewmodel.dart';
import 'package:ios_macros/src/utils/widgets/loading_page.dart';
import 'package:provider/provider.dart';

class DraggableFoodsPage extends StatelessWidget {
  const DraggableFoodsPage({super.key});

  static const routeName = '/foods-drag';

  @override
  Widget build(BuildContext context) {
    final token = context.read<AuthViewmodel>().sessionUser!.token;
    final foodsController = context.read<FoodViewmodel>();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Adicione alimentos'),
      ),
      child: SafeArea(
        child: FutureBuilder(
          future: foodsController.getFoods(token),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingPage(message: 'Carregando alimentos');
            }

            return const DraggablePageContent();
          },
        ),
      ),
    );
  }
}

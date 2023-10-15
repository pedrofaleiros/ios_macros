import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/data/dto/food_dto.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/food_viewmodel.dart';
import 'package:provider/provider.dart';

class CreateFoodPage extends StatefulWidget {
  const CreateFoodPage({super.key});

  static const routeName = '/create-food';

  @override
  State<CreateFoodPage> createState() => _CreateFoodPageState();
}

class _CreateFoodPageState extends State<CreateFoodPage> {
  final TextEditingController nameTF = TextEditingController();
  final TextEditingController kcalTF = TextEditingController();
  final TextEditingController carbTF = TextEditingController();
  final TextEditingController protTF = TextEditingController();
  final TextEditingController fatTF = TextEditingController();
  final TextEditingController fiberTF = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode kcalFocus = FocusNode();
  final FocusNode carbFocus = FocusNode();
  final FocusNode protFocus = FocusNode();
  final FocusNode fatFocus = FocusNode();
  final FocusNode fiberFocus = FocusNode();

  bool isLiquid = false;

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthViewmodel>();
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemOrange,
        middle: Text('Criar alimento'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              MyTextField(
                focus: nameFocus,
                placeholder: 'Nome',
                controller: nameTF,
                nextFocus: kcalFocus,
              ),
              const SizedBox(height: 8),
              MyTextField(
                focus: kcalFocus,
                placeholder: 'Kcal',
                controller: kcalTF,
                type: TextInputType.number,
                nextFocus: carbFocus,
              ),
              const SizedBox(height: 8),
              MyTextField(
                nextFocus: protFocus,
                focus: carbFocus,
                controller: carbTF,
                placeholder: 'Carboidratos',
                type: TextInputType.number,
              ),
              // const SizedBox(height: 8),
              // MyTextField(
              //   nextFocus: protFocus,
              //   focus: fiberFocus,
              //   controller: fiberTF,
              //   placeholder: 'Fibras',
              //   type: TextInputType.number,
              // ),
              const SizedBox(height: 8),
              MyTextField(
                nextFocus: fatFocus,
                focus: protFocus,
                controller: protTF,
                placeholder: 'Proteínas',
                type: TextInputType.number,
              ),
              const SizedBox(height: 8),
              MyTextField(
                focus: fatFocus,
                controller: fatTF,
                placeholder: 'Gorduras',
                type: TextInputType.number,
              ),
              const SizedBox(height: 8),
              CupertinoListTile(
                title: const Text('Líquido?'),
                trailing: CupertinoSwitch(
                  value: isLiquid,
                  onChanged: (value) => setState(() => isLiquid = value),
                ),
              ),
              const SizedBox(height: 8),
              CupertinoButton.filled(
                onPressed: () async {
                  FoodDTO food = FoodDTO(
                    name: nameTF.text,
                    kcal: double.tryParse(kcalTF.text) ?? -1,
                    carb: double.tryParse(carbTF.text) ?? -1,
                    prot: double.tryParse(protTF.text) ?? -1,
                    fat: double.tryParse(fatTF.text) ?? -1,
                    fiber: 0,
                    liquid: isLiquid,
                  );

                  await context
                      .read<FoodViewmodel>()
                      .createFood(
                        auth.sessionUser!.token,
                        food,
                      )
                      .then(
                    (value) {
                      if (value == true) {
                        Navigator.pop(context);
                      }
                    },
                  );
                },
                child: const Text(
                  'Criar',
                  style: TextStyle(
                    color: CupertinoColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.placeholder,
    required this.controller,
    required this.focus,
    this.type,
    this.nextFocus,
  });

  final String placeholder;
  final TextEditingController controller;
  final TextInputType? type;

  final FocusNode focus;
  final FocusNode? nextFocus;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      onSubmitted: (value) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      keyboardType: type,
      focusNode: focus,
      controller: controller,
      placeholder: placeholder,
      clearButtonMode: OverlayVisibilityMode.editing,
    );
  }
}

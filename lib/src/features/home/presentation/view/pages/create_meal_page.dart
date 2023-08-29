import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:ios_macros/src/utils/widgets/loading_page.dart';
import 'package:provider/provider.dart';

class CreateMealPage extends StatefulWidget {
  const CreateMealPage({super.key});

  static const routeName = '/create-meal';

  @override
  State<CreateMealPage> createState() => _CreateMealPageState();
}

class _CreateMealPageState extends State<CreateMealPage> {
  // _showTimePicker(BuildContext context) async {
  //   final response = await showTimePicker(
  //     context: context,
  //     initialTime: const TimeOfDay(hour: 8, minute: 0),
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: Theme.of(context).colorScheme.copyWith(
  //               onSurface: Theme.of(context).colorScheme.onBackground),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );

  //   if (response != null) {
  //     setState(() {
  //       time = response;
  //     });
  //   }
  // }

  Duration time = const Duration(hours: 8, minutes: 0);
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  String? errorText;

  bool validText() {
    setState(() {
      errorText = null;
    });

    if (nameController.text == '' || nameController.text.length > 30) {
      setState(() {
        errorText = 'Nome inválido';
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   title: const Text('Criar refeição'),
      // ),
      navigationBar: CupertinoNavigationBar(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CupertinoTextField(
                onChanged: (value) {
                  validText();
                },
                controller: nameController,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Horário:'),
                  CupertinoButton(
                      // onPressed: () async => _showTimePicker(context),
                      onPressed: () async => {},
                      child: Text(
                        '${time}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  child: isLoading
                      ? LoadingPage()
                      : Text(
                          'Adicionar',
                        ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    if (errorText != null) {
                      setState(() {
                        isLoading = false;
                      });
                      return;
                    }

                    await context
                        .read<MealViewmodel>()
                        .createMeal(
                          nameController.text,
                          //time
                        )
                        .then(
                      (value) {
                        Navigator.pop(context);
                        setState(() {
                          isLoading = false;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/data/dto/meal_dto.dart';
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
  _showTimePicker(BuildContext context) async {
    timePicker = time;
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoTheme.brightnessOf(context) == Brightness.dark
            ? CupertinoColors.systemFill
            : CupertinoColors.white,
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: timePicker,
                  onTimerDurationChanged: (value) => timePicker = value,
                ),
              ),
              CupertinoButton(
                child: const Text('Confirmar'),
                onPressed: () {
                  setState(() => time = timePicker);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

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

  Duration time = const Duration(hours: 8, minutes: 0);
  Duration timePicker = const Duration(hours: 8, minutes: 0);

  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    int hour;
    int minute;
    hour = time.inHours;
    minute = time.inMinutes - (60 * time.inHours);

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Criar refeição'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CupertinoTextField(
                controller: nameController,
                placeholder: 'Digite o nome da refeição',
                clearButtonMode: OverlayVisibilityMode.editing,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Horário:',
                    style: TextStyle(
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  CupertinoButton(
                    onPressed: () async => _showTimePicker(context),
                    child: Row(
                      children: [
                        Text(
                          minute > 9 ? '$hour:$minute' : '$hour:0$minute',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(CupertinoIcons.clock),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  child: isLoading
                      ? const CupertinoActivityIndicator()
                      : const Text('Adicionar'),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    validText();

                    if (errorText != null) {
                      setState(() {
                        isLoading = false;
                      });
                      return;
                    }

                    final token =
                        context.read<AuthViewmodel>().sessionUser!.token;
                    await context
                        .read<MealViewmodel>()
                        .createMeal(
                          token,
                          MealDTO(
                            name: nameController.text,
                            hour: hour,
                            minutes: minute,
                          ),
                        )
                        .then(
                      (value) {
                        if (value == true) {
                          Navigator.pop(context);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              Text(
                errorText ?? '',
                style: const TextStyle(
                  color: CupertinoColors.systemRed,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

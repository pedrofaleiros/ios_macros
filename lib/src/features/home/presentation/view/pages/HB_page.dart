// ignore_for_file: file_names, non_constant_identifier_names, sized_box_for_whitespace, avoid_print

import 'package:flutter/cupertino.dart';

class HBPage extends StatefulWidget {
  const HBPage({super.key});

  static const routeName = '/harris-benedict';

  @override
  State<HBPage> createState() => _HBPageState();
}

enum SEX { male, female }

class ExerciseLevel {
  final String text;
  final String obs;
  final double value;

  ExerciseLevel({
    required this.text,
    required this.obs,
    required this.value,
  });
}

class _HBPageState extends State<HBPage> {
  final TextEditingController weightCtrl = TextEditingController();
  final TextEditingController heightCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();

  final FocusNode weightNode = FocusNode();
  final FocusNode heightNode = FocusNode();
  final FocusNode ageNode = FocusNode();

  SEX userSex = SEX.male;

  List<ExerciseLevel> levels = [
    ExerciseLevel(
        text: 'Sedentário', obs: 'Pouco ou nenhum exercicio', value: 1.2),
    ExerciseLevel(
        text: 'Pouco ativo',
        obs: 'Exercicios 1/3 dias na semana',
        value: 1.375),
    ExerciseLevel(
        text: 'Moderadamente ativo',
        obs: 'Exercicios 3/5 dias na semana',
        value: 1.55),
    ExerciseLevel(
        text: 'Ativo', obs: 'Exercicios 6/7 dias na semana', value: 1.725),
    ExerciseLevel(
        text: 'Muito ativo',
        obs: 'Exercicios diários ou trabalho físico',
        value: 1.9),
  ];

  ExerciseLevel userExercise = ExerciseLevel(text: '', obs: '', value: 1.0);

  @override
  void initState() {
    super.initState();
    userExercise = levels[2];
  }

  double? result;

  void _calcula() {
    double weight = double.tryParse(weightCtrl.text) ?? 0;
    double height = double.tryParse(heightCtrl.text) ?? 0;
    double age = double.tryParse(ageCtrl.text) ?? 0;

    setState(
      () {
        if (userSex == SEX.male) {
          result = 66.5 + (13.75 * weight) + (5 * height) - (6.75 * age);
        } else {
          result = 655.1 + (9.563 * weight) + (1.85 * height) - (4.676 * age);
        }
        result = result! * userExercise.value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Harris-Benedict'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              WeightTextField(context),
              _div(),
              HeightTextField(context),
              _div(),
              AgeTextField(),
              _div(),
              SetSexButton(context),
              _div(),
              SetExerciceLevelButton(context),
              _div(),
              CalculateButton(),
              _div(),
              if (result != null)
                Text('Resultado: ${result!.toStringAsFixed(0)}')
            ],
          ),
        ),
      ),
    );
  }

  SizedBox SetExerciceLevelButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        onPressed: () => _showExercisePicker(context),
        child: Text("Nivel de exercicio: ${userExercise.text}"),
      ),
    );
  }

  SizedBox SetSexButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        onPressed: () => _showSexPicker(context),
        child: Text(userSex == SEX.male ? 'Sexo: Masculino' : 'Sexo: Feminino'),
      ),
    );
  }

  SizedBox _div() => const SizedBox(height: 8);

  CupertinoTextField AgeTextField() {
    return CupertinoTextField(
      prefix: const Padding(
        padding: EdgeInsets.only(left: 8),
        child: Text('Idade'),
      ),
      clearButtonMode: OverlayVisibilityMode.editing,
      focusNode: ageNode,
      onEditingComplete: _calcula,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.end,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8.0),
      ),
      placeholder: 'Idade',
      controller: ageCtrl,
    );
  }

  CupertinoTextField HeightTextField(BuildContext context) {
    return CupertinoTextField(
      prefix: const Padding(
        padding: EdgeInsets.only(left: 8),
        child: Text('Altura(cm)'),
      ),
      focusNode: heightNode,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(ageNode);
      },
      keyboardType: TextInputType.number,
      textAlign: TextAlign.end,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8.0),
      ),
      placeholder: 'Altura (cm)',
      controller: heightCtrl,
    );
  }

  CupertinoTextField WeightTextField(BuildContext context) {
    return CupertinoTextField(
      prefix: const Padding(
        padding: EdgeInsets.only(left: 8),
        child: Text('Peso(Kg)'),
      ),
      focusNode: weightNode,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(heightNode);
      },
      keyboardType: TextInputType.number,
      textAlign: TextAlign.end,
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8.0),
      ),
      placeholder: 'Peso (Kg)',
      controller: weightCtrl,
    );
  }

  Container CalculateButton() {
    return Container(
      width: double.infinity,
      child: CupertinoButton.filled(
        onPressed: _calcula,
        child: const Text(
          'Calcular',
          style: TextStyle(
            color: CupertinoColors.white,
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showExercisePicker(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            top: false,
            child: CupertinoPicker(
              magnification: 1.22,
              squeeze: 1.2,
              useMagnifier: true,
              scrollController: FixedExtentScrollController(
                initialItem: calculateIndex(),
              ),
              backgroundColor: CupertinoColors.systemGrey6,
              itemExtent: 32.0, // altura de cada item
              onSelectedItemChanged: (index) {
                setState(() {
                  userExercise = levels[index];
                });
                print(userExercise.text);
              },
              children: [
                for (var item in levels)
                  Center(
                      child: Text(
                    '${item.text} (${item.obs})',
                    style: const TextStyle(fontSize: 14),
                  )),
              ],
            ),
          ),
        );
      },
    );
  }

  int calculateIndex() {
    for (var i = 0; i < levels.length; i++) {
      if (userExercise.value == levels[i].value) {
        return i;
      }
    }
    return 0;
  }

  Future<dynamic> _showSexPicker(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SafeArea(
            top: false,
            child: CupertinoPicker(
              magnification: 1.22,
              squeeze: 1.2,
              useMagnifier: true,
              scrollController: FixedExtentScrollController(
                initialItem: userSex == SEX.male ? 0 : 1,
              ),
              backgroundColor: CupertinoColors.systemGrey6,
              itemExtent: 32.0, // altura de cada item
              onSelectedItemChanged: (index) {
                setState(() {
                  userSex = SEX.values[index];
                });
              },
              children: const [
                Center(child: Text('Masculino')),
                Center(child: Text('Feminino')),
              ],
            ),
          ),
        );
      },
    );
  }
}

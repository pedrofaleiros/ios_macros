// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';

class HBPage extends StatefulWidget {
  const HBPage({super.key});

  static const routeName = '/harris-benedict';

  @override
  State<HBPage> createState() => _HBPageState();
}

enum SEX { male, female }

class _HBPageState extends State<HBPage> {
  final TextEditingController weightCtrl = TextEditingController();
  final TextEditingController heightCtrl = TextEditingController();
  final TextEditingController ageCtrl = TextEditingController();
  SEX userSex = SEX.male;

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
              CupertinoTextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.end,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                placeholder: 'Peso (Kg)',
                controller: weightCtrl,
              ),
              SizedBox(height: 8),
              CupertinoTextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.end,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                placeholder: 'Altura (cm)',
                controller: heightCtrl,
              ),
              SizedBox(height: 8),
              CupertinoTextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.end,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                placeholder: 'Idade (Kg)',
                controller: ageCtrl,
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: CupertinoButton(
                  onPressed: () => _showPicker(context),
                  child: Text(userSex == SEX.male
                      ? 'Sexo: Masculino'
                      : 'Sexo: Feminino'),
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: CupertinoButton.filled(
                  onPressed: _calcula,
                  child: Text(
                    'Calcular',
                    style: TextStyle(
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              if (result != null) Text('Resultado: ${result}')
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showPicker(BuildContext context) {
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
              children: [
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

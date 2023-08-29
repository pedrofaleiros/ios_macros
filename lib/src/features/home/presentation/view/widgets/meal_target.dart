import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/auth/presentation/viewmodel/auth_viewmodel.dart';
import 'package:ios_macros/src/features/home/data/dto/item_dto.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/domain/model/meal_model.dart';
import 'package:ios_macros/src/features/home/presentation/viewmodel/meal_viewmodel.dart';
import 'package:provider/provider.dart';

class MealTarget extends StatefulWidget {
  const MealTarget({
    super.key,
    required this.meal,
    required this.left,
  });

  final MealModel meal;
  final double left;

  @override
  State<MealTarget> createState() => _MealTargetState();
}

class _MealTargetState extends State<MealTarget> {
  bool added = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<FoodModel>(
      onAccept: (data) async {
        await showPopup(context).then(
          (response) async {
            try {

              if(response == null) return;

              if (double.tryParse(response) != null) {
                final amount = double.parse(response);

                final token = context.read<AuthViewmodel>().sessionUser!.token;

                await context
                    .read<MealViewmodel>()
                    .createItem(
                      token,
                      ItemDTO(
                        mealId: widget.meal.id,
                        foodId: data.id,
                        amount: amount,
                      ),
                    )
                    .then(showAdded);
              }
            } catch (e) {
              print(e.toString());
            }
          },
        );
      },
      builder: (context, foods, list) {
        return Padding(
          // padding: foods.isNotEmpty
          //     ? const EdgeInsets.symmetric(horizontal: 4, vertical: 12)
          //     : EdgeInsets.only(
          //         left: widget.left, top: 16, right: 8, bottom: 16),
          padding:
              EdgeInsets.only(left: widget.left, top: 16, right: 8, bottom: 16),
          child: Container(
            decoration: BoxDecoration(
              color: foods.isNotEmpty
                  ? CupertinoTheme.brightnessOf(context) == Brightness.dark
                      ? Color(0xff2b2b2b)
                      : CupertinoColors.systemGrey5
                  : CupertinoTheme.brightnessOf(context) == Brightness.dark
                      ? CupertinoColors.systemFill
                      : CupertinoColors.systemGroupedBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            width: 100.0,
            child: _content,
          ),
        );
      },
    );
  }

  FutureOr<void> showAdded(_) async {
    if (mounted) {
      setState(() {
        added = true;
      });
    }

    if (mounted) {
      await Future.delayed(const Duration(seconds: 3));
    }

    if (mounted) {
      setState(() {
        added = false;
      });
    }
  }

  Future<dynamic> showPopup(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) {
        TextEditingController textController = TextEditingController();
        FocusNode focus = FocusNode();

        return AmountAlertDialog(focus: focus, textController: textController);
      },
    );
  }

  Widget get _content {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.meal.minutes > 9
                    ? '${widget.meal.hour}:${widget.meal.minutes}'
                    : '${widget.meal.hour}:0${widget.meal.minutes}',
                style: const TextStyle(
                  color: CupertinoColors.activeBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                CupertinoIcons.clock,
                size: 18,
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(
            widget.meal.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: CupertinoTheme.brightnessOf(context) == Brightness.dark
                  ? CupertinoColors.systemGrey2
                  : CupertinoColors.systemGrey,
            ),
          ),
        ),
        if (added) const AddedText(),
      ],
    );
  }
}

class AmountAlertDialog extends StatelessWidget {
  const AmountAlertDialog({
    super.key,
    required this.focus,
    required this.textController,
  });

  final FocusNode focus;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(focus);
    });

    return CupertinoAlertDialog(
      title: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Selecione a quantidade'),
      ),
      content: CupertinoTextField(
        focusNode: focus,
        controller: textController,
        keyboardType: TextInputType.number,
        onEditingComplete: () => Navigator.pop(context, textController.text),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context, ''),
          isDestructiveAction: true,
          child: const Text('Cancelar'),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context, textController.text),
          isDefaultAction: true,
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}

class AddedText extends StatelessWidget {
  const AddedText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Adicionado',
            style: TextStyle(
              fontSize: 14,
              color: CupertinoColors.systemCyan,
            ),
          ),
          Icon(
            CupertinoIcons.check_mark_circled_solid,
            size: 14,
            color: CupertinoColors.systemCyan,
          )
        ],
      ),
    );
  }
}

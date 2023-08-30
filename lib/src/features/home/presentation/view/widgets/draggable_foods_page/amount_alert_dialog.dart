import 'package:flutter/cupertino.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
          onPressed: () => Navigator.pop(context, null),
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

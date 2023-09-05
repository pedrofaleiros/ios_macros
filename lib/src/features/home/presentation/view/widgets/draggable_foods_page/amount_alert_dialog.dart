import 'package:flutter/cupertino.dart';

class AmountAlertDialog extends StatelessWidget {
  const AmountAlertDialog({
    super.key,
    required this.focus,
    required this.textController,
    required this.dfAmount,
    required this.name,
  });

  final FocusNode focus;
  final TextEditingController textController;
  final double dfAmount;
  final String name;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(focus);
    });

    return CupertinoAlertDialog(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Adicionar "$name"'),
      ),
      content: CupertinoTextField(
        placeholder: 'Quantidade: $dfAmount',
        clearButtonMode: OverlayVisibilityMode.editing,
        focusNode: focus,
        controller: textController,
        keyboardType: TextInputType.number,
        onEditingComplete: () => textController.text.isEmpty
            ? Navigator.pop(context, dfAmount.toString())
            : Navigator.pop(context, textController.text),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context, null),
          isDestructiveAction: true,
          child: const Text('Cancelar'),
        ),
        CupertinoDialogAction(
          onPressed: () => textController.text.isEmpty
              ? Navigator.pop(context, dfAmount.toString())
              : Navigator.pop(context, textController.text),
          isDefaultAction: true,
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}

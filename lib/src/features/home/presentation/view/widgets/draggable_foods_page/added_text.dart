import 'package:flutter/cupertino.dart';

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
import 'package:flutter/cupertino.dart';
import 'package:ios_macros/src/features/home/domain/model/food_model.dart';
import 'package:ios_macros/src/features/home/presentation/view/widgets/foods_list_tile.dart';

class FeedBack extends StatelessWidget {
  const FeedBack({
    super.key,
    required this.food,
  });

  final FoodModel food;

  final double height = 60;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
          offset: Offset(-height * 1.5, -height * 1.25),
          child: Container(
            decoration: BoxDecoration(
              color: CupertinoColors.systemGroupedBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              food.name,
              style: const TextStyle(color: CupertinoColors.black),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(-height / 2, -height / 2),
          child: Container(
            height: height,
            width: height,
            decoration: BoxDecoration(
              // color: CupertinoColors.activeBlue,
              borderRadius: BorderRadius.circular(height),
              border: Border.all(
                color: CupertinoColors.systemGrey3,
                width: 2,
              ),
            ),
            // child: const Icon(
            //   CupertinoIcons.drop_triangle,
            //   color: CupertinoColors.white,
            // ),
          ),
        ),
      ],
    );
    return Container(
      color: CupertinoTheme.brightnessOf(context) == Brightness.dark
          ? Color(0xff2b2b2b)
          : CupertinoColors.systemGrey5,
      width: MediaQuery.of(context).size.width * 1,
      // height: 100,
      child: FoodListTile(food: food),
    );
  }
}

    // return Container(
    //   color: CupertinoTheme.brightnessOf(context) == Brightness.dark
    //       ? Color(0xff2b2b2b)
    //       : CupertinoColors.systemGrey5,
    //   width: MediaQuery.of(context).size.width *0.8,
    //   // height: 100,
    //   child: FoodListTile(food: food),
    // );
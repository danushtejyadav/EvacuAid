import "package:evacuaid/src/constants/colors.dart";
import "package:flutter/material.dart";

class CategoryModel{
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });

  static List<CategoryModel> getCategories(){
    List<CategoryModel> categories = [];

    categories.add(
      CategoryModel(
          name: 'Water Bottle',
          iconPath: 'assets/images/store_images/water-bottle.png',
          boxColor: EvacPrimaryColor.withOpacity(0.11)
      )
    );

    categories.add(
        CategoryModel(
            name: 'First Aid',
            iconPath: 'assets/images/store_images/first-aid.png',
            boxColor: EvacAccentColor.withOpacity(0.11)
        )
    );

    categories.add(
        CategoryModel(
            name: 'Sleeping Bag',
            iconPath: 'assets/images/store_images/sleeping-bag.png',
            boxColor: EvacPrimaryColor.withOpacity(0.11)
        )
    );

    categories.add(
        CategoryModel(
            name: 'Torch',
            iconPath: 'assets/images/store_images/torch.png',
            boxColor: EvacAccentColor.withOpacity(0.11)
        )
    );

    categories.add(
        CategoryModel(
            name: 'Extinguisher',
            iconPath: 'assets/images/store_images/fire-extinguisher.png',
            boxColor: EvacPrimaryColor.withOpacity(0.11)
        )
    );

    return categories;
  }
}
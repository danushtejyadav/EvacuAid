import "package:evacuaid/src/constants/colors.dart";
import "package:flutter/material.dart";

class DietModel {
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  Color boxColor;
  bool ViewIsSelected;

  DietModel({
   required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.boxColor,
    required this.ViewIsSelected
});

  static List<DietModel> getDiets() {
    List<DietModel> diets = [];

    diets.add(
      DietModel(
          name: "Fire Extinguisher",
          iconPath: "assets/images/store_images/fire-extinguisher.png",
          level: "In Stock",
          duration: "₹3000",
          calorie: "Grade A",
          boxColor: EvacPrimaryColor.withOpacity(0.11),
          ViewIsSelected: true
      )
    );

    diets.add(
      DietModel(
          name: "Sleeping Bag",
          iconPath: "assets/images/store_images/sleeping-bag.png",
          level: "In Stock",
          duration: "₹4000",
          calorie: "Grade B",
          boxColor: EvacAccentColor.withOpacity(0.11),
          ViewIsSelected: false
      )
    );

    return diets;
  }
}
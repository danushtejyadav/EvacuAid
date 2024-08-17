class PopularDietsModel {
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  bool boxIsSelected;

  PopularDietsModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.boxIsSelected
});

  static List<PopularDietsModel> getPopularDiets() {
    List<PopularDietsModel> popularDiets = [];

    popularDiets.add(
      PopularDietsModel(
          name: "Torch",
          iconPath: "assets/images/store_images/torch.png",
          level: "2 in Stock",
          duration: "₹800",
          calorie: "Grade A",
          boxIsSelected: true,
      )
    );

    popularDiets.add(
      PopularDietsModel(
          name: "Water Bottle",
          iconPath: "assets/images/store_images/water-bottle.png",
          level: "5 in Stock",
          duration: "₹500",
          calorie: "Grade B",
          boxIsSelected: false
      )
    );

    return popularDiets;
  }
}
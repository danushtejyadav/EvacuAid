import "package:flutter/material.dart";

class MainFormHeaderWidget extends StatelessWidget {
  const MainFormHeaderWidget({super.key,
    this.imageColor,
    this.imageHeight = 0.2,
    required this.image,
    required this.title,
    required this.subTitle,
    this.heightBetween,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign,
  });

  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(image: AssetImage(image), color:imageColor, height: size.height * imageHeight,),
        SizedBox(height: heightBetween),
        Text(title, style: Theme.of(context).textTheme.headlineMedium!.merge(TextStyle(color: Colors.black)), textAlign: TextAlign.left,),
        Text(subTitle, style: Theme.of(context).textTheme.titleMedium!.merge(TextStyle(color: Colors.black, )), textAlign: textAlign,),
      ],
    );
  }
}

import "package:evacuaid/src/constants/sizes.dart";
import "package:evacuaid/src/features/authentication/models/model_on_boarding.dart";
import "package:flutter/material.dart";

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context){

    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(EvacDefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: AssetImage(model.image), height: size.height*0.5 ,),
          Column(
            children: [
              Text(model.title, style: Theme.of(context).textTheme.headlineMedium!.merge(
                TextStyle(color: Colors.black),
              ),),
              Text(model.subTitle, textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),
            ],
          ),
          Text(model.counterText, style: Theme.of(context).textTheme.titleMedium!.merge(
            TextStyle(color: Colors.black),
          ),
          ),
          SizedBox(height: 50.0,),
        ],
      ),
    );
  }
}

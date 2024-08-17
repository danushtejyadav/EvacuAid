import "package:flutter/material.dart";


class ForgotPassButtonWidget extends StatelessWidget {
  const ForgotPassButtonWidget({
    required this.btnIcon,
    required this.title,
    required this.subTitle,
    required this.onTap,
    super.key,
  });

  final IconData btnIcon;
  final String title, subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            Icon(btnIcon, size: 60.0, color: Colors.black,),
            SizedBox(width: 10.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.black),),
                Text(subTitle, style: TextStyle(color: Colors.black),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
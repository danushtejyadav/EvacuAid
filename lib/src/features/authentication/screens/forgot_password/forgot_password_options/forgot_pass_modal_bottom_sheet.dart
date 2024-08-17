import "package:evacuaid/src/constants/sizes.dart";
import "package:evacuaid/src/constants/text_strings.dart";
import "package:evacuaid/src/features/authentication/screens/forgot_password/forgot_password_mail/forgot_pass_mail.dart";
import "package:evacuaid/src/features/authentication/screens/forgot_password/forgot_password_options/forgot_pass_button_widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";


class ForgotPasswordScreen {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(context: context, builder: (context) => Container(
      padding: const EdgeInsets.all(EvacDefaultSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(EvacForgotPassTitle, style: Theme.of(context).textTheme.headlineMedium,),
          Text(EvacForgotEmailSubTitle, style: Theme.of(context).textTheme.bodyMedium,),
          const SizedBox(height: 30.0,),
          ForgotPassButtonWidget(
            btnIcon: Icons.email_outlined,
            title: EvacForgotPassEmail,
            subTitle: EvacForgotEmailSubTitle,
            onTap: () {
              Navigator.pop(context);
              Get.to(() => ForgotPasswordMailScreen());
            },
          ),
          const SizedBox(height: 20.0,),
          ForgotPassButtonWidget(
            btnIcon: Icons.phone_android_outlined,
            title: EvacForgotPassPhone,
            subTitle: EvacForgotPhoneSubTitle,
            onTap: (){},
          ),
        ],
      ),
    ));
  }
}

import "package:evacuaid/src/common_widgets/form/form_header_widget.dart";
import "package:evacuaid/src/constants/image_strings.dart";
import "package:evacuaid/src/constants/sizes.dart";
import "package:evacuaid/src/constants/text_strings.dart";
import "package:evacuaid/src/features/authentication/screens/forgot_password/forgot_password_otp/otp_screen.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class ForgotPasswordMailScreen extends StatelessWidget {
  const ForgotPasswordMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: EvacDefaultSize * 4,
                  ),
                  MainFormHeaderWidget(
                    image: EvacForgotPassImage,
                    title: EvacForgotPassword,
                    subTitle: EvacForgotEmailSubTitle,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    heightBetween: 30.0,
                    imageHeight: 0.4,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: EvacFormHeight,
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: EvacEmail,
                            labelText: EvacEmail,
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Get.to(() => OtpScreen());
                                }, child: Text(EvacNext)))
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

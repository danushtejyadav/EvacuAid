import "package:evacuaid/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart";
import "package:flutter/material.dart";

class SignupEmailPasswordFailure{
  final String message;

  SignupEmailPasswordFailure([this.message = "An Unknown error occurred."]);

  factory SignupEmailPasswordFailure.code(String code){
    switch(code){
      case 'weak-password' : return SignupEmailPasswordFailure("Please enter a stronger password.");
      case 'invalid-email' : return SignupEmailPasswordFailure("Email is not valid or badly formatted.");
      case 'email-already-in-use' : return SignupEmailPasswordFailure("An account already exists with this email.");
      case 'operation-not-allowed' : return SignupEmailPasswordFailure("Operation is not allowed. Please contact support.");
      case 'user-disabled' : return SignupEmailPasswordFailure("This user has been disabled. Please contact support for help.");
      default : return SignupEmailPasswordFailure();
    }
  }
}
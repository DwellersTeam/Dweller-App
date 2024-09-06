import 'dart:convert';
import 'dart:developer';
import 'package:dweller/services/repository/data_service/base_service/base_service.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;






class StripeCheckoutClass {
  
  
  final baseService = getx.Get.put(BaseService());
  final isLoading = false.obs; 


  //ALL YOU NEED TO PULL UP STRIPE CHECK OUT IN YOUR APP

  //create the payment intent variable (nullable)
  //Map<String, dynamic>? paymentIntent;


  
  //function to calculate the amount to be sent to stripe
  String calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }


  //this should be created first before anything else (create payment intent to generate "client_secret")
  Future<Map<String, dynamic>> createPaymentIntent({required String amount, required String currency}) async {
    isLoading.value = true;
    try {

      //payload
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51PklDDP0RYiilDZ68faMeQmqx1yrBJ493B9KXDSMAeIi0BH1qwPIAa1VbpB9yQBvw0emNRNoB7MENkkMgRlMZidX00LVTmKeQZ',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );

      if(response.statusCode == 200 || response.statusCode == 201){
        isLoading.value = false;
        log("Payment intent Response: ${response.body}");
        final jsonResponse = json.decode(response.body);
        //you can create payment intent on the get go and store the info to db so the user would not 
        //have to be calling this api everytime they want to make payment for a purchase on your platform/app.
        return jsonResponse;
      }
      else{
        isLoading.value = false;
        log("${response.statusCode} || ${response.body}");
        throw Exception("failed to fetch user payment intent details");
      }
    } 
    catch (err) {
      isLoading.value = false;
      throw Exception(err.toString());
    }
  }



  //this comes last in the makePayment Function
  Future displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on Exception catch (e) {
      if (e is StripeException) {
        log('Error from Stripe: ${e.error.localizedMessage}');
        log('Error Code from Stripe: ${e.error.code}');
        if(e.error.code == FailureCode.Failed) {
          showMessagePopup(
            title: "Uh oh!", 
            message: e.error.message!, //"you are already subscribed to Dweller PRO", 
            buttonText: "Okay", 
          );
        }
        else if(e.error.code == FailureCode.Canceled) {
          showMessagePopup(
            title: "Uh oh!", 
            message: "payment intent was cancelled", 
            buttonText: "Okay", 
          );
        }
        else if(e.error.code == FailureCode.Timeout) {
          showMessagePopup(
            title: "Uh oh!", 
            message: "payment intent timed out", 
            buttonText: "Okay", 
          );
        }
        else{
          showMessagePopup(
            title: "Uh oh!", 
            message: "something went wrong", 
            buttonText: "Okay", 
          );

        }
      } else {
        log('Unforeseen error: $e');
      }
    }
  } 

  //call this in your UI
  Future<void> makePayment() async {
    try {

      //we first create the payment intent
      final paymentIntent = await createPaymentIntent(amount: '10', currency: "EUR");

      //initializes the payment sheet to collect card info
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(

          //Theme style
          style: ThemeMode.light,

          //Set to true for custom flow
          customFlow: false,

          //Main params
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Dweller',
          
          //Customer Keys
          /*customerId: paymentIntent["customer"],
          customerEphemeralKeySecret: paymentIntent["ephemeralKey"],*/

          //Extra Options (you have to config with apple to make Apple Pay work)
          /*applePay: PaymentSheetApplePay(
            merchantCountryCode: "EUR",
          ),*/
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode: "EUR"
          ),

          preferredNetworks: [
            CardBrand.Mastercard,
            CardBrand.Visa,
            CardBrand.Amex,
            CardBrand.UnionPay,
            CardBrand.CartesBancaires,
            CardBrand.JCB,
            CardBrand.Unknown,
            CardBrand.DinersClub,
            CardBrand.Discover
          ]
        )
      );

      //display payment sheet to collect card info, processes the one-time payment and then disposes the payment sheet
      await displayPaymentSheet();

    } catch (e) {
      log('Error: $e');
    }
  }


}
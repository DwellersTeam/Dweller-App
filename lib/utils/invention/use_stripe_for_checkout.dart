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
  //ALL YOU NEED TO PULL UP STRIPE CHECK OUT IN YOUR APP

  //create the payment intent variable (nullable)
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment() async {
    try {
      //we first create the payment intent
      final paymentIntent = await createPaymentIntent('10', 'EUR');

      //initializes the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(

          // Theme style
          style: ThemeMode.light,

          // Set to true for custom flow
          customFlow: false,

          // Main params
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: 'Dweller',
          
          // Customer Keys
          /*customerId: paymentIntent["customer"],
          customerEphemeralKeySecret: paymentIntent["ephemeralKey"],*/

          //Extra Options
          /*applePay: PaymentSheetApplePay(
            merchantCountryCode: "EUR",
          ),*/
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode: "EUR"
          ),

          //for the merchant
          /*billingDetails: const BillingDetails(
            name: 'YOUR NAME',
            email: 'YOUREMAIL@gmail.com',
            phone: 'YOUR NUMBER',
            address: Address(
              city: 'YOUR CITY',
              country: 'YOUR COUNTRY',
              line1: 'YOUR ADDRESS 1',
              line2: 'YOUR ADDRESS 2',
              postalCode: 'YOUR PINCODE',
              state: 'YOUR STATE',
            )
          ),*/
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
      ).then((value) async{
        log("$value");
        //display payment sheet
        await displayPaymentSheet();
      })
      .onError((error, stackTrace) {
        throw Exception("failded to init payment sheet: $error");
      });

    } catch (e) {
      log('Error: $e');
    }
  }


  Future displayPaymentSheet() async {
    try {

      await Stripe.instance.presentPaymentSheet()
      .then((value) {
        //Clear paymentIntent variable after successful payment
        paymentIntent = null;
        //save what ever you want to save in your database to mark successful payment
      })
      .onError((error, stackTrace) {
        throw Exception("failded to display payment sheet: $error");
      });
 
    } 
    on StripeException catch (e) {
      print('Error is from stripe:---> $e'); 
    } 
    catch (e) {
      print('$e');
    }
  } 



  //this should be created first before anything else
  Future createPaymentIntent(String amount, String currency) async {
    try {
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
        log("Payment intent Response: ${response.body}");
        final jsonResponse = json.decode(response.body);
        return jsonResponse;
      }
      else{
        log("${response.statusCode} || ${response.body}");
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }
  
  //function to calculate the amount to be sent to stripe
  String calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }


}
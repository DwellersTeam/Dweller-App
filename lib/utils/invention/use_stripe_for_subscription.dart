import 'dart:convert';
import 'dart:developer';
import 'package:dweller/services/repository/data_service/base_service/base_service.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;






class StripeSubscriptionClass {
  
  
  final baseService = getx.Get.put(BaseService());



  //function to calculate the amount to be sent to stripe
  String calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  //this should be created first before anything else
  Future<Map<String, dynamic>> createCustomer({required String name,required String email}) async {
    try {
      Map<String, dynamic> body = {
        'name': name,
        'email': email
      };

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/customers'),
        headers: {
          'Authorization': 'Bearer sk_test_51PklDDP0RYiilDZ68faMeQmqx1yrBJ493B9KXDSMAeIi0BH1qwPIAa1VbpB9yQBvw0emNRNoB7MENkkMgRlMZidX00LVTmKeQZ',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        log("Customer Response: ${response.body}");
        return jsonResponse;
        //store the customer id i.e "id" and any other thing that you want to store in the users database
        //call the create subscription endpoint to create a subscription for your customer
        /*await createSubscription(
          customerId: jsonResponse["id"], 
          //default_payment_method: jsonResponse["invoice_settings"]["default_payment_method"] ?? "null"
        );*/
        //return {"yayy": "customer and subscription targeted at customer created"};
      } else {
        log("${response.statusCode} || ${response.body}");
        throw Exception("failed to create subscription");
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }


  //this should be created second after creating customers
  Future<Map<String, dynamic>> createSubscription({
    required String customerId, 
    // String default_payment_method
    }) async {
    try {
      Map<String, dynamic> body = {
        'customer': customerId,
        'items[0][price]': "price_1PmiEtP0RYiilDZ6mJZJ1mLl", // Replace with your Price ID from Stripe
        'payment_behavior': 'default_incomplete',
        "expand[]": 'latest_invoice.payment_intent'
        //"default_payment_method": default_payment_method,
        //'expand[]': 'latest_invoice.payment_intent',
      };

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/subscriptions'),
        headers: {
          'Authorization': 'Bearer sk_test_51PklDDP0RYiilDZ68faMeQmqx1yrBJ493B9KXDSMAeIi0BH1qwPIAa1VbpB9yQBvw0emNRNoB7MENkkMgRlMZidX00LVTmKeQZ',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        log("Subscription Response: ${response.body}");
        return jsonResponse;
      } else {
        log("${response.statusCode}");
        log("${response.body}");
        throw Exception("failed to create subscription");
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  //this comes last in the makePayment Function
  displayPaymentSheet(//{required String paymentIntentClientSecret}
  ) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      /*await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: paymentIntentClientSecret,
        data: const PaymentMethodParams.card(paymentMethodData: PaymentMethodData())
      );*/
      log('Payment successful');
      //save what ever you want to save in your database to mark successful payment
    
    } on Exception catch (e) {
      if (e is StripeException) {
        log('Error from Stripe: ${e.error.localizedMessage}');
      } else {
        log('Unforeseen error: $e');
      }
    }
  } 

  //ALL YOU NEED TO PULL UP STRIPE SUBSCRIPTION IN YOUR APP
  Future<void> makePayment({required String customerName, required String customerEmail}) async {

    try {

      //we create customer first, then upon 200 OK, we go ahead to create subscription
      //final subscription = await createCustomer(name: customerName, email: customerEmail);
      final customer = await createCustomer(name: customerName, email: customerEmail);
      print("ssssss");
      //initializes the payment sheet and set up payment params
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          //paymentIntentClientSecret: subscription['latest_invoice']['payment_intent']['client_secret'],
          style: ThemeMode.light,
          merchantDisplayName: 'Dweller',
          customerId: customer["id"],
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
        ),
      );
      print("next");
      //display payment sheet
      displayPaymentSheet(
        //paymentIntentClientSecret: subscription['latest_invoice']['payment_intent']['client_secret']
      );
      print("done");
    } catch (e) {
      log('Error: $e');
    }
  }




}
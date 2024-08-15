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
  
  final isLoading = false.obs; 
  final baseService = getx.Get.put(BaseService());


  //FETCH CURRENT USER SUBSCRIPTION DATA FROM BACKEND
  /*The steps included to get subscription are:
    1. use stripe customer REST API to create a customer and store the customer id in your db
    2. use stripe subscription REST API to create a subscription for that customer using the id stored to database and
      store the whole stripe subscription object to database.(you can decide to store only the key thing which is the "latest_invoice" object)
    3. if you are using firebase, find a way to create a stripe web-hook or cloud function with firebase to keep charging the user monthly or yearly with reference to his/her sub details.
       if you are using raw backend, create a stripe web-hook that will keep charging the user with reference to his/her sub details in database.
    4. fetch the user/customer subscription details from your database and use them below.
  */

  Future<Map<String,dynamic>> getUserSub(BuildContext context) async {
    isLoading.value = true;
    try {

      http.Response res = await baseService.httpGet(endPoint: "subscription/subscribe",);

      if (res.statusCode == 200 || res.statusCode == 201) {

        isLoading.value = false;
        debugPrint('this is response status ==> ${res.statusCode}');
        debugPrint('this is response body ==> ${res.body}');
        //decode response from the server
        final Map<String,dynamic> result = json.decode(res.body);
        
        //SubscriptionResponse jsonResponse = SubscriptionResponse.fromJson(result);

        return result;

      }
      else{
        isLoading.value = false;
        debugPrint('this is response body ==>${res.body}');
        debugPrint('this is response status ==>${res.statusCode}');
        debugPrint('this is response reason ==> ${res.reasonPhrase}');
        baseService.showErrorMessage(httpStatusCode: res.statusCode, context: context);
        throw Exception("failed to fetch user subscription details");
      }

    }

    catch(e, stackTrace) {
      isLoading.value = false;
      debugPrint("$e");
      debugPrint("trace: $stackTrace");
      throw Exception("$e");
    }
  } 
        

  //this comes last in the makePayment Function
  Future displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on Exception catch (e) {
      if (e is StripeException) {
        log('Error from Stripe: ${e.error.localizedMessage}');
      } else {
        log('Unforeseen error: $e');
      }
    }
  } 


  //ALL YOU NEED TO PULL UP STRIPE SUBSCRIPTION IN YOUR FLUTTER APP
  Future<void> makePayment({required BuildContext context}) async {

    try {

      //get the latest_invoice ->> payment_intent ->> client_secret
      final subData =  await getUserSub(context);
  
      //initializes the payment sheet and set up payment params
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: subData["client_secret"],
          style: ThemeMode.light,
          merchantDisplayName: 'Dweller',
          customerId: subData["customer_id"],
          //Customer Keys
          /*customerId: paymentIntent["customer"],
          customerEphemeralKeySecret: subData["ephemeralKey"],*/

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
        ),
      );
  
      //display payment sheet to collect card info, processes the subscription payment and then disposes the payment sheet
      await displayPaymentSheet();


    } catch (e) {
      log('Error: $e');
    }
  }




}
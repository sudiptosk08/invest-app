import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invest_app/constant/base_state.dart';
import 'package:invest_app/constant/navigation_service.dart';
import 'package:invest_app/constant/shared_preference_constant.dart';
import 'package:invest_app/navigation_bar_screen.dart';
import 'package:invest_app/network_utils/api.dart';
import 'package:invest_app/view/utils/styles/k_colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

/// Providers
final confirmPaymentProvider =
    StateNotifierProvider<ConfirmPaymentController, BaseState>(
  (ref) => ConfirmPaymentController(ref: ref),
);

/// Controllers
class ConfirmPaymentController extends StateNotifier<BaseState> {
  final Ref? ref;

  ConfirmPaymentController({this.ref}) : super(const InitialState());
  File? imgFile;

  Future confirmPayment({
    amount,
    paymentMethodId,
    transactionId,
    image,
  }) async {
    state = const LoadingState();
    var accesstoken = getStringAsync(token);

    Map<String, String> requestBody = {
      'amount': amount,
      'payment_method_id': paymentMethodId,
      'trx_id': transactionId,
    };
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${API.base}' '${API.confirmPayment}'),
      )
        ..fields.addAll(requestBody)
        ..headers.addAll({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken'
        })
        ..files.add(await http.MultipartFile.fromPath("image", image));
      var response = await request.send();
      var jsonData = await http.Response.fromStream(response);
      log(jsonData.statusCode.toString());
      log(jsonData.body);
      log("Status Code");
      log(response.statusCode.toString());
      log(jsonData.body.toString());
      if (response.statusCode >= 200 && response.statusCode <= 290) {
        final responseBody = jsonDecode(jsonData.body);
        
        toast(responseBody['message'], bgColor: KColor.green);
        state = const SuccessState();
        NavigationService.navigateToReplacement(
            CupertinoPageRoute(builder: (context)=> const NavigationBarScreen()));
        return responseBody;
      } else if (response.statusCode >= 400 && response.statusCode <= 490) {
        var msg = jsonDecode(jsonData.body);
        toast(msg['message'].toString(),bgColor: KColor.red);
        return null;
      } else {
        return null;
      }
    } on http.ClientException catch (err, stackrace) {
      log(stackrace.toString());
      return null;
    } catch (e) {
      return null;
    }
  }
}

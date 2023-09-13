import 'package:invest_app/constant/app_mode.dart';

class API {
  static const live = 'http://pbridge.co.in/api/v1'; // Live Production API URL
  static const test = 'http://pbridge.co.in/api/v1'; // Live Staging API URL
  static const base = AppMode.PRODUCTION_MODE ? live : test;

  // //
  static const updateUser = '/user/update';
  static const user = '/user';
  static const userBalance = '/user/balance';

  // //
  static const signup = '/register';
  static const login = '/login';
  static const logout = '/logout';
  static const updatepassword = '/password/update';

  static const products = '/products';
  static productRent({id = ""}) => '/products/$id/rent';

  static const investRecord = '/rentals';

  static const paymentMethod = '/payment-methods';
  static const confirmPayment = '/recharges/store';

  // //

  static const mybankAccount = '/bank-accounts';
  static const mymobileBankingAccount = '/mobile-bank-accounts';
  static const addbankAccount = '/bank-accounts/store';
  static const addMobileBank = '/mobile-bank-accounts/store';
  //  //
  static const mobileBankingList = '/mobile-banks';
  static const bankList = '/banks';

  // //

  static const withDraw = '/withdraw/store';
  static const faqs = '/faqs';
  static const spinSetting = '/dailySpin/settings';
  static const dailySpinCheck = '/dailySpin/check';
  static const dailySpinUpdate = '/dailySpin';

  static rechargeHistory({
    page = "",
  }) =>
      '/recharges?page=$page';

  static withdrawHistory({
    page = "",
  }) =>
      '/withdraw?page=$page';

  static earningHistory({
    type = "",
    page = "",
  }) =>
      '/earnings?type=$type&page=$page';

  static const addReview = '/reviews/store';
  static const getReview = '/reviews';

  static const setting = '/settings';
  static const banner = '/banerImages';
  static const myteam = '/team';
  static myteamSearch({
    dateFrom = "",
    dateTo = "",
  }) =>
      '/team?dateFrom=$dateFrom&dateTo=$dateTo';
}

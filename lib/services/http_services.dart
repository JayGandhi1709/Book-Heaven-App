import 'dart:convert';
import 'dart:developer';
import 'package:get/get_connect.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/constants.dart';

class HttpService {
  final String baseUrl = MAIN_URL;

  Future<Response> get({required String endpointUrl}) async {
    try {
      log("$baseUrl/$endpointUrl");
      final prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString(USER_TOKEN) ?? '';
      return await GetConnect().get('$baseUrl/$endpointUrl',
          headers: {'Authorization': 'Bearer $token'});
    } catch (e) {
      log('Error: $e');
      return Response(
          body: json.encode({'error': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> getById(
      {required String endpointUrl, required dynamic itemData}) async {
    try {
      log("$baseUrl/$endpointUrl");
      final prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString(USER_TOKEN) ?? '';
      return await GetConnect().get('$baseUrl/$endpointUrl/$itemData',
          headers: {'Authorization': 'Bearer $token'});
    } catch (e) {
      log('Error: $e');
      return Response(
          body: json.encode({'error': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> post(
      {required String endpointUrl, required dynamic itemData}) async {
    try {
      // showSnackBar("$baseUrl/$endpointUrl", MsgType.warning);
      // showSnackBar("$itemData", MsgType.warning);
      log("$baseUrl/$endpointUrl");
      final prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString(USER_TOKEN) ?? '';
      final response = await GetConnect().post(
          '$baseUrl/$endpointUrl', itemData,
          headers: {'Authorization': 'Bearer $token'});
      // print(response.body['message']);
      return response;
    } catch (e) {
      // print('Error: $e');
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> putById(
      {required String endpointUrl,
      required String itemId,
      required dynamic itemData}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString(USER_TOKEN) ?? '';
      return await GetConnect().put('$baseUrl/$endpointUrl/$itemId', itemData,
          headers: {'Authorization': 'Bearer $token'});
    } catch (e) {
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> put(
      {required String endpointUrl, required dynamic itemData}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString(USER_TOKEN) ?? '';
      return await GetConnect().put('$baseUrl/$endpointUrl', itemData,
          headers: {'Authorization': 'Bearer $token'});
    } catch (e) {
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> delete(
      {required String endpointUrl, required String itemId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString(USER_TOKEN) ?? '';
      log('Delete : $baseUrl/$endpointUrl/$itemId');
      return await GetConnect().delete(
        '$baseUrl/$endpointUrl/$itemId',
        headers: {'Authorization': 'Bearer $token'},
      );
    } catch (e) {
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }
}

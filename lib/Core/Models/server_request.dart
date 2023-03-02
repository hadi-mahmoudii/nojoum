import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:either_dart/either.dart';
import 'package:get/get.dart';

import '../Config/app_session.dart';
import '../Config/urls.dart';
import '../Widgets/error_result.dart';
import 'package:dio/dio.dart' as http;

class ServerRequest extends GetConnect {
  // Get request
  Future<Either<ErrorResult, dynamic>> fetchData(url,
      {Map<String, String>? header}) async {
    var appProvider = Get.find<AppSession>();
    Map<String, String>? requestHeader = {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': appProvider.token,
      'accept-language': 'en',
    };
    if (header != null) requestHeader = header;
    try {
      httpClient.timeout = const Duration(seconds: 30);
      var response = await get(url, headers: requestHeader);
      var results = json.decode(response.bodyString!);
      return Right(results);
    } catch (e) {
      return Left(ErrorResult.fromException(e));
    }
  }

  // Post request
  Future<Either<ErrorResult, dynamic>> sendData(String url,
      {Map? datas, Map<String, String>? headers}) async {
    var appProvider = Get.find<AppSession>();
    Map<String, String>? requestHeader = {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': appProvider.token,
      "Content-Type": "application/json",
      "Accept": "application/json",
      'accept-language': 'en',
    };
    if (headers != null) requestHeader = headers;
    httpClient.timeout = const Duration(seconds: 120);
    // try {
    var response = await post(url, datas, headers: requestHeader);
    var results = json.decode(response.bodyString!);
    return Right(results);
    // } catch (e) {
    //   return Left(ErrorResult.fromException(e));
    // }
  }

  // Post request with File
  Future<Either<ErrorResult, dynamic>> sendFile(
      String url, Map<String, dynamic>? datas,
      {Map<String, String>? headers}) async {
    var appProvider = Get.find<AppSession>();
    Map<String, String>? requestHeader = {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': appProvider.token,
      // "Content-Type": "application/json",
      // "Accept": "application/json",
      'accept-language': 'en',
    };
    try {
      if (headers != null) requestHeader = headers;
      httpClient.timeout = const Duration(seconds: 600);
      final form = FormData(datas!);
      var response = await post(url, form, headers: requestHeader);
      var results = json.decode(response.bodyString!);
      return Right(results);
    } catch (e) {
      return Left(ErrorResult.fromException(e));
    }
  }

  Future<Either<ErrorResult, dynamic>> sendPost(
      Uint8List? fileBytes, String? fileName, String text,
      {Function? progressFunction}) async {
    var appProvider = Get.find<AppSession>();
    Map<String, dynamic> datas;
    if (fileBytes == null) {
      datas = {
        'text': text,
        'title': 'title',
      };
    } else {
      {
        // final file = XFile(filePath);
        // final fileBytes = await file.readAsBytes();
        datas = {
          'file': http.MultipartFile.fromBytes(fileBytes, filename: fileName),
          'text': text,
          'title': 'title',
        };
      }
    }
    try {
      var formData = http.FormData.fromMap(datas);
      var dio = http.Dio(http.BaseOptions(headers: {
        'Authorization': appProvider.token,
      }));
      var res = await dio.post(
        Urls.posts,
        data: formData,
        onSendProgress: (sent, total) {
          // print(sent);
          if (progressFunction != null) {
            progressFunction((sent / total).toDouble());
          }
        },
      );
      var results = res.data;
      return Right(results);
    } catch (e) {
      return Left(ErrorResult.fromException(e));
    }
  }

  Future<Either<ErrorResult, dynamic>> sendVideo(
    XFile file,
    Function progressFunction, {
    http.CancelToken? cancelToken,
  }) async {
    var appProvider = Get.find<AppSession>();
    final fileBytes = await file.readAsBytes();
    try {
      var formData = http.FormData.fromMap({
        'file': http.MultipartFile.fromBytes(fileBytes, filename: file.name),
      });
      var dio = http.Dio(http.BaseOptions(headers: {
        'Authorization': appProvider.token,
      }));
      var res = await dio.post(
        Urls.sendStory,
        data: formData,
        cancelToken: cancelToken,
        onSendProgress: (sent, total) {
          // print(sent);
          progressFunction((sent / total).toDouble());
        },
      );
      var results = res.data;
      return Right(results);
    } catch (e) {
      return Left(ErrorResult.fromException(e));
    }
  }

// Get request
  Future<Either<ErrorResult, dynamic>> deleteData(url,
      {Map<String, String>? header}) async {
    var appProvider = Get.find<AppSession>();
    Map<String, String>? requestHeader = {
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': appProvider.token,
      'accept-language': 'en',
    };
    if (header != null) requestHeader = header;
    try {
      var response = await delete(url, headers: requestHeader);
      var results = json.decode(response.bodyString!);
      return Right(results);
    } catch (e) {
      return Left(ErrorResult.fromException(e));
    }
  }

  GetSocket userMessages() {
    return socket('https://yourapi/users/socket');
  }
}

// class ServerRequest {
//   // Future<Either<ErrorResult, List>> fetchDatas(String url,
//   //     {List<dynamic>? datas}) async {
//   //   try {
//   //     final response = await http.get(
//   //       Uri.parse(url),
//   //       headers: {
//   //         'X-Requested-With': 'XMLHttpRequest',
//   //         'Authorization': AppSession.token,
//   //       },
//   //     );
//   //     // // print(response.statusCode);
//   //     // print(response.body);
//   //     var values = json.decode(response.body);
//   //     return Right(values);
//   //   } catch (e) {
//   //     return Left(ErrorResult.fromException(e));
//   //   }
//   // }
//   final appProvider = Get.find<AppSession>();

//   Future<Either<ErrorResult, dynamic>> fetchData(String url) async {
//     try {
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'X-Requested-With': 'XMLHttpRequest',
//           'Authorization': appProvider.token,
//           'accept-language': 'en',
//         },
//       );
//       var values = json.decode(response.body);
//       return Right(values);
//     } catch (e) {
//       return Left(ErrorResult.fromException(e));
//     }
//   }

//   Future<Either<ErrorResult, dynamic>> sendData(String url,
//       {Map? datas, Map<String, String>? headers}) async {
//     try {
//       // print(AppSession.token);
//       Map<String, String> requestHeaders = {
//         'X-Requested-With': 'XMLHttpRequest',
//         'Authorization': appProvider.token,
//         "Content-Type": "application/json",
//         "Accept": "application/json",
//         'accept-language': 'en',
//       };
//       if (headers != null) {
//         requestHeaders = headers;
//       }
//       final response = await http.post(
//         Uri.parse(url),
//         headers: requestHeaders,
//         body: json.encode(datas),
//       );
//       // print(json.encode(datas)  );
//       // print(response.body);
//       var values = json.decode(response.body);
//       return Right(values);
//     } catch (e) {
//       return Left(ErrorResult.fromException(e));
//     }
//   }

//   Future<Either<ErrorResult, dynamic>> updateData(String url,
//       {Map? datas}) async {
//     try {
//       final response = await http.put(
//         Uri.parse(url),
//         headers: {
//           'X-Requested-With': 'XMLHttpRequest',
//           'Authorization': appProvider.token,
//           'accept-language': 'en',
//         },
//         body: datas,
//       );
//       var values = json.decode(response.body);
//       return Right(values);
//     } catch (e) {
//       return Left(ErrorResult.fromException(e));
//     }
//   }

//   Future<Either<ErrorResult, dynamic>> deleteData(String url,
//       {List<dynamic>? datas}) async {
//     try {
//       final response = await http.delete(
//         Uri.parse(url),
//         headers: {
//           'X-Requested-With': 'XMLHttpRequest',
//           'Authorization': appProvider.token,
//         },
//       );
//       var values = json.decode(response.body);
//       return Right(values);
//     } catch (e) {
//       return Left(ErrorResult.fromException(e));
//     }
//   }
// }

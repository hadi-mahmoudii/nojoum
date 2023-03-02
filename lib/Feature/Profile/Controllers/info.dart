import 'package:either_dart/either.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../Core/Config/urls.dart';
import '../../../Core/Models/global.dart';
import '../../../Core/Models/option_model.dart';
import '../../../Core/Models/random_string.dart';
import '../../../Core/Models/server_request.dart';
import '../../../Core/Widgets/error_result.dart';

class InfoController extends GetxController {
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController fNameCtrl = TextEditingController();
  TextEditingController lNameCtrl = TextEditingController();
  TextEditingController cellCtrl = TextEditingController();
  TextEditingController countryCtrl = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();

  List<OptionModel> countries = [];
  List<OptionModel> cities = [];

  late String userId;
  var hasImage = false.obs;
  late String imageUrl;
  late PlatformFile? file;

  selectImage() async {
    // final appSession = Get.find<AppSession>();

    try {
      await FilePicker.platform
          .pickFiles(
        withData: true,
        allowMultiple: false,
        type: FileType.image,
        // allowedExtensions: ['jpg', 'png', 'bmp', 'jpeg'],
      )
          .then((files) async {
        if (files!.files.isNotEmpty) {
          try {
            isLoading.value = true;
            var tempDir = await getTemporaryDirectory();
            var fil = await FlutterImageCompress.compressAndGetFile(
              files.files[0].path!,
              tempDir.path + '/profile.jpg',
              minHeight: 480,
              minWidth: 480,
              quality: 75, format: CompressFormat.jpeg,
              // rotate: 180,
            );
            final Either<ErrorResult, dynamic> result =
                await ServerRequest().sendFile(Urls.uploadFile, {
              'file': MultipartFile(fil!.readAsBytesSync(),
                  filename: 'profile.jpg'),
              'model_name': 'user',
              'collection_name': 'profile',
              'model_id': userId,
              'batch_id': generateRandomString(50),
            });
            result.fold(
              (error) async {
                // await ErrorResult.showDlg(error.type, context);
                isLoading.value = false;
              },
              (result) {
                Fluttertoast.showToast(msg: 'Profile image changed');
                imageUrl = result['data']['url'];
                file = files.files[0];
                hasImage.value = true;
                isLoading.value = false;
                // singer = SingerModel.fromJson(result['data']);
                // for (var item in result['data'].keys) {
                //   print(item);
                //   print(result['data'][item]);
                // }
                // program = OurProgramModel.fromJson(result['data']);
                // result['data'].forEach((element) {
                //   // print(element);
                //   programs.add(ProgramOverviewModel.fromJson(element));
                //   // print(result['children']);
                // });
                isLoading.value = false;
              },
            );

            // var request =
            //     http.MultipartRequest("POST", Uri.parse(Urls.uploadFile));
            // var pic = await http.MultipartFile.fromPath(
            //   'file',
            //   tempDir.path + '/profile.jpg',
            //   filename: 'profile.jpg',
            // );
            // request.files.add(pic);
            // request.fields['model_name'] = 'user';
            // request.fields['collection_name'] = 'profile';
            // request.fields['model_id'] = userId;
            // request.fields['batch_id'] = generateRandomString(50);
            // request.headers['X-Requested-With'] = 'XMLHttpRequest';
            // request.headers['authorization'] = appSession.token;
            // var response = await request.send();
            // var responseData = await response.stream.toBytes();
            // var responseString = String.fromCharCodes(responseData);
            // var values = json.decode(responseString);
            // // print(values);
            // imageUrl = values['data']['url'];
            // file = files.files[0];
            // hasImage = true;
            // isLoading = false;
            // notifyListeners();
          } catch (_) {
            Fluttertoast.showToast(msg: 'Error upload image!');
          }
        }
      });
    } catch (_) {}
  }

  @override
  void onInit() async {
    await getDatas();
    super.onInit();
  }

  getDatas() async {
    isLoading.value = true;
    // scrollController.jumpTo(0);

    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getCountries,
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading.value = false;
      },
      (result) {
        // log(result.toString());
        result['data'].forEach((element) {
          countries.add(OptionModel(
              id: element['id'].toString(), title: element['name_en']));
        });
      },
    );
    final Either<ErrorResult, dynamic> result2 =
        await ServerRequest().fetchData(
      Urls.myInfo,
    );
    result2.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading.value = false;
      },
      (result) async {
        // log(result.toString());
        userId = GlobalEntity.dataFilter(result['data']['id'].toString());
        imageUrl = GlobalEntity.dataFilter(result['data']['image']);
        if (imageUrl.isNotEmpty) {
          hasImage.value = true;
        }
        emailCtrl.text = GlobalEntity.dataFilter(result['data']['email']);
        fNameCtrl.text = GlobalEntity.dataFilter(result['data']['first_name']);
        lNameCtrl.text = GlobalEntity.dataFilter(result['data']['last_name']);
        cellCtrl.text =
            GlobalEntity.dataFilter(result['data']['cell_number'].toString());
        final String countryId =
            GlobalEntity.dataFilter(result['data']['country_id']);
        try {
          if (countryId.isNotEmpty) {
            countryCtrl.text = countries
                .firstWhere((element) => element.id == countryId)
                .title!;
          }
        } catch (_) {}
        final String cityId =
            GlobalEntity.dataFilter(result['data']['city_id']);
        try {
          if (countryId.isNotEmpty) {
            await getCities();
            cityCtrl.text =
                cities.firstWhere((element) => element.id == cityId).title!;
          }
        } catch (_) {}
        isLoading.value = false;
      },
    );
  }

  updateDatas(BuildContext context) async {
    String countryId = '';
    try {
      countryId = countries
          .firstWhere((element) => element.title == countryCtrl.text)
          .id!;
    } catch (_) {}
    String cityId = '';
    try {
      cityId =
          cities.firstWhere((element) => element.title == cityCtrl.text).id!;
    } catch (_) {}
    isLoading.value = true;

    final Either<ErrorResult, dynamic> result = await ServerRequest().sendData(
      Urls.updateProfile,
      datas: {
        'first_name': fNameCtrl.text,
        'last_name': lNameCtrl.text,
        'cell_number': cellCtrl.text,
        'country_id': countryId,
        'city_id': cityId,
        // 'country': countryCtrl.text,
        '_method': 'put',
      },
    );
    result.fold(
      (error) async {
        await ErrorResult.showDlg(error.type!, context);
      },
      (result) async {
        // print(result);
        try {
          if (result['data']['id'] != '') {
            Fluttertoast.showToast(msg: 'Your profile updated');
            Get.back();
            return;
          }
        } catch (_) {}
        isLoading.value = false;
        Fluttertoast.showToast(msg: 'Error!');
      },
    );
  }

  getCities() async {
    // isLoading = true;
    // notifyListeners();
    cities.clear();
    final String countryId = countries
        .firstWhere((element) => element.title == countryCtrl.text)
        .id!;
    final Either<ErrorResult, dynamic> result = await ServerRequest().fetchData(
      Urls.getCities(countryId),
    );
    result.fold(
      (error) async {
        // await ErrorResult.showDlg(error.type, context);
        isLoading.value = false;
      },
      (result) {
        // log(result.toString());
        result['data'].forEach((element) {
          cities.add(OptionModel(
              id: element['id'].toString(), title: element['name_en']));
        });
        // isLoading = false;
      },
    );
  }
}

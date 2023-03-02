class GlobalEntity {
  static String dataFilter(var data, {String replacement = ''}) {
    if (data.toString() == 'null' ||
        data.toString() == 'NULL' ||
        data.toString() == '[]' ||
        data.toString() == '{}') {
      return replacement;
    } else {
      return data.toString();
    }
  }

  static String formatedTime(String secTime) {
    int value = 0;
    try {
      value = int.parse(secTime);
    } catch (_) {}
    String getParsedTime(String time) {
      if (time.length <= 1) return "0$time";
      return time;
    }

    int min = value ~/ 60;
    int sec = value % 60;

    String parsedTime =
        getParsedTime(min.toString()) + " : " + getParsedTime(sec.toString());

    return parsedTime;
  }
  // static setUserData(Map datas) async {
  //   final id = GlobalEntity.dataFilter(datas['id'].toString());
  //   final firstN = GlobalEntity.dataFilter(datas['first_name'].toString());
  //   final lastN = GlobalEntity.dataFilter(datas['last_name'].toString());
  //   final phone = GlobalEntity.dataFilter(datas['phone'].toString());
  //   final nCode = GlobalEntity.dataFilter(datas['national_code'].toString());
  //   final fatherN = GlobalEntity.dataFilter(datas['father_name'].toString());
  //   final homePhone = GlobalEntity.dataFilter(datas['home_phone'].toString());
  //   final bornCity = GlobalEntity.dataFilter(datas['born_city'].toString());
  //   final job = GlobalEntity.dataFilter(datas['job'].toString());
  //   final bornYear = GlobalEntity.dataFilter(datas['born_year'].toString());
  //   final workPlace = GlobalEntity.dataFilter(datas['workplace'].toString());
  //   List<MediaModel> certImages = [];

  //   // print(datas['certificates']);
  //   try {
  //     datas['certificates'].forEach((element) {
  //       certImages.add(MediaModel(
  //         url: element['app_thumbnail'],
  //         id: element['id'].toString(),
  //       ));
  //     });
  //   } catch (e) {}
  //   final certificateLength = certImages.length;
  //   bool done; //
  //   if (id.isNotEmpty &&
  //       firstN.isNotEmpty &&
  //       lastN.isNotEmpty &&
  //       phone.isNotEmpty &&
  //       nCode.isNotEmpty &&
  //       fatherN.isNotEmpty &&
  //       homePhone.isNotEmpty &&
  //       bornCity.isNotEmpty &&
  //       job.isNotEmpty &&
  //       bornYear.isNotEmpty &&
  //       workPlace.isNotEmpty)
  //     done = true;
  //   else
  //     done = false;
  //   // AppSession.token = datas['token'];
  //   AppSession.userId = datas['id'].toString();
  //   final prefs = await SharedPreferences.getInstance();
  //   final userData = json.encode({
  //     'token': AppSession.token,
  //     'userId': id.toString(),
  //     'firstN': firstN,
  //     'lastN': lastN,
  //     'phone': phone,
  //     'nCode': nCode,
  //     'fatherN': fatherN,
  //     'homePhone': homePhone,
  //     'bornCity': bornCity,
  //     'job': job,
  //     'bornYear': bornYear,
  //     'workPlace': workPlace,
  //     'verified': GlobalEntity.dataFilter(datas['verified'].toString()) == ''
  //         ? false
  //         : true,
  //     'isAdmin': GlobalEntity.dataFilter(datas['is_admin'].toString()) == ''
  //         ? false
  //         : true,
  //     'certificateLength': certificateLength,
  //     'done': done,
  //   });
  //   prefs.setString('userData', userData);

  //   //this lines most be more clear!!
  //   final userDatas =
  //       json.decode(prefs.getString('userData')) as Map<String, dynamic>;
  //   AppSession.userData = UserModel(
  //     id: userDatas['userId'],
  //     firstN: userDatas['firstN'],
  //     lastN: userDatas['lastN'],
  //     phone: userDatas['phone'],
  //     nCode: userDatas['nCode'],
  //     fatherN: userDatas['fatherN'],
  //     verified: userDatas['verified'],
  //     isAdmin: userDatas['isAdmin'],
  //     homePhone: userDatas['homePhone'],
  //     bornCity: userDatas['bornCity'],
  //     job: userDatas['job'],
  //     workPlace: userDatas['workPlace'],
  //     bornYear: userDatas['bornYear'],
  //     done: userDatas['done'],
  //     certificates: [],
  //     certificatesLength: userDatas['certificateLength'],
  //   );
  // }
}

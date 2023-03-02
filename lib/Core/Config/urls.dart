class Urls {
  static const baseUrl = 'https://nojoum.app/api';
  // static const homeLive =
  //     'http://s1.cdn1.iranseda.ir:1935/liveedge/radio-nama-javan/chunklist_w1850485122.m3u8';

  static const homeLive = 'https://nojoumhls.wns.live/hls/stream.m3u8';

  static const login = '$baseUrl/login';
  static const forgetPass = '$baseUrl/forgot-password';
  static const forgetPassVerify = '$baseUrl/forgot-password-verify';
  static const forgetChangePass = '$baseUrl/reset-password';
  static const resendCode = '$baseUrl/auth/resend-email-verification-code';

  static const register = '$baseUrl/register';
  static const submitCode = '$baseUrl/verify-code';

  static const changePass = '$baseUrl/change-password';
  static const getHeaderImage = '$baseUrl/static_images/header';
  static logout(String phone) => '$baseUrl/auth/logout';

  static getSinger(String id) => '$baseUrl/artists/$id';
  static const myInfo = '$baseUrl/my-info';
  static const updateProfile = '$baseUrl/profile';
  // static const getSections = '$baseUrl/app-sections/home/get-by-page';
  static const getSections = '$baseUrl/app-sections-client/home/get-by-page';

  static String getMusics(String page, {String filter = ''}) {
    String url = '$baseUrl/music?page=$page';
    if (filter.isNotEmpty) url += '&filters[name]=%$filter%';
    return url;
  }

  static getMusic(String id) => '$baseUrl/music/$id';
  static nextMusics(String id) => '$baseUrl/music/$id/next';
  static previousMusics(String id) => '$baseUrl/music/$id/previous';

  static String getVideoes(String page, {String filter = ''}) {
    String url = '$baseUrl/videos?page=$page';
    if (filter.isNotEmpty) url += '&filters[name]=%$filter%';
    return url;
  }

  static getVideo(String id) => '$baseUrl/videos/$id';

  static nextVodeoes(String id) => '$baseUrl/videos/$id/next';

  static const getRadios = '$baseUrl/radio-stations';
  static getFeatures(String slug) =>
      '$baseUrl/features/$slug/get-by-placeholder';
  static const getBanners = '$baseUrl/placeholders';
  static const getCountries = '$baseUrl/countries';
  static getCities(String countryId) => '$baseUrl/cities/$countryId';
  static const uploadFile = '$baseUrl/files';
  static const favorite = '$baseUrl/favorites';
  static const myMusicFavorites = '$baseUrl/my-favorites/music';
  static const myVideoFavorites = '$baseUrl/my-favorites/video';

  static const myPlaylists = '$baseUrl/my-playlists';
  static const addUserPlaylist = '$baseUrl/playlists';
  static getPlaylist(String id) => '$baseUrl/playlists/$id';

  static deletePlaylist(String id) => '$baseUrl/playlists/$id';
  static globalPlaylists(String filter, {String page = '1'}) {
    String url = '$baseUrl/playlists?page=$page';
    if (filter.isNotEmpty) {
      url += '&filters[name]=%$filter%';
    }

    return url;
  }

  static getNews(String filter, String page) {
    String url = '$baseUrl/get-news?';
    if (filter.isNotEmpty) url += 'filters[title]=%$filter%';
    if (page.isNotEmpty) url += '&page=$page';
    return url;
  }

  static getSingleNews(String id) => '$baseUrl/get-news/$id';
  static getSimilarNews(String id) => '$baseUrl/get-news/$id/similar';

  static attachToPlaylist(String id) => '$baseUrl/playlists/$id/attach';
  static deattachFromPlaylist(String id) => '$baseUrl/playlists/$id/detach';
  static const categories = '$baseUrl/genres';

  // static const getCategories = '$baseUrl/sport-categories';
  static getComments(String id, String type) =>
      '$baseUrl/get-comments?rel_id=$id&rel_type=$type';
  static sendComment(String id, String type) =>
      '$baseUrl/comments?rel_id=$id&rel_type=$type';
  static const posts = '$baseUrl/posts';
  static getPosts(String page) => '$baseUrl/get-posts?page=$page';
  static showPost(String id) => '$baseUrl/posts/$id';
  static const sendStory = '$baseUrl/stories';
  static stories(String page) => '$baseUrl/get-stories?page=$page';
  static getStory(String id) => '$baseUrl/stories/$id';
  static showStory(String id) => '$baseUrl/stories/$id';
  static const report = '$baseUrl/reports';
  static const like = '$baseUrl/likes';
}

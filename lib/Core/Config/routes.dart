import 'package:get/get.dart';
import 'package:nojoum/Feature/General/Screen/search.dart';
import 'package:nojoum/Feature/News/Screens/news_details.dart';
import 'package:nojoum/Feature/News/Screens/news_list.dart';
import 'package:nojoum/Feature/Post/Controllers/show_story.dart';
import 'package:nojoum/Feature/Post/Screens/add.dart';
import 'package:nojoum/Feature/Post/Screens/details.dart';
import 'package:nojoum/Feature/Post/Screens/show_story.dart';
import 'package:nojoum/Feature/Post/bindings.dart';
import 'package:nojoum/Feature/Video/Screens/live.dart';
import 'package:nojoum/Feature/Post/Screens/capture_video.dart';

import '../../Feature/Auth/Screens/forget.dart';
import '../../Feature/Auth/Screens/login.dart';
import '../../Feature/Auth/Screens/register.dart';
import '../../Feature/Auth/Screens/submit_code.dart';
import '../../Feature/Music/Screen/details.dart';
import '../../Feature/Music/Screen/list.dart';
import '../../Feature/Music/Screen/playlist_details.dart';
import '../../Feature/Music/Screen/playlist_list.dart';
import '../../Feature/Music/Screen/radio.dart';
import '../../Feature/Post/Controllers/add.dart';
import '../../Feature/Profile/Screens/change_pass.dart';
import '../../Feature/Profile/Screens/dashboard.dart';
import '../../Feature/Profile/Screens/info.dart';
import '../../Feature/Profile/Screens/my_favorites.dart';
import '../../Feature/Profile/Screens/my_playlists.dart';
import '../../Feature/Profile/Screens/singer_info.dart';
import '../../Feature/Video/Screens/details.dart';
import '../../Feature/Video/Screens/list.dart';
import '../main_screen.dart';

class Routes {
  static const login = '/login';
  static const live = '/live';
  static const register = '/register';
  static const forgetPass = '/forgetPass';
  static const submitCode = '/submitCode';
  static const mainScreen = '/MainScreen';

  static const radioDetails = '/radioDetails';
  static const musicDetails = '/musicDetails';
  static const musicList = '/musicList';
  static const videoDetails = '/videoDetails';
  static const videoList = '/videoList';
  static const changePass = '/changePass';
  static const dashboard = '/dashboard';
  static const favorites = '/favorites';
  static const info = '/info';
  static const singerInfo = '/singerInfo';
  static const myFavorites = '/myFavorites';
  static const myPlaylists = '/myPlaylists';
  static const playlists = '/playlists';
  static const playlistDetails = '/playlistDetails';
  static const newsList = '/newsList';
  static const newsDetails = '/newsDetails';
  static const captureVideo = '/captureVideo';
  static const postDetails = '/postDetails';
  static const addPost = '/addPost';
  static const searchMedia = '/searchMedia';
  static const showStory = '/showStory';

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.live,
      page: () => const LiveScreen(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: Routes.forgetPass,
      page: () => const ForgetPassScreen(),
    ),
    GetPage(
      name: Routes.submitCode,
      page: () => const SubmitCodeScreen(),
    ),
    GetPage(
      name: Routes.mainScreen,
      page: () => const MainScreen(),
    ),
    GetPage(
      name: Routes.musicDetails,
      page: () => const MusicDetailsScreen(),
    ),
    GetPage(
      name: Routes.radioDetails,
      page: () => const RadioDetailScreen(),
    ),
    GetPage(
      name: Routes.musicList,
      page: () => const MusicListScreen(),
    ),
    GetPage(
      name: Routes.videoList,
      page: () => const VideoListScreen(),
    ),
    GetPage(
      name: Routes.videoDetails,
      page: () => const VideoDetailsScreen(),
    ),
    GetPage(
      name: Routes.changePass,
      page: () => const ChangePassScreen(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardScreen(),
    ),
    GetPage(
      name: Routes.info,
      page: () => const InfoScreen(),
    ),
    GetPage(
      name: Routes.singerInfo,
      page: () => const SingerInfoScreen(),
    ),
    GetPage(
      name: Routes.myFavorites,
      page: () => const MyFavoritesScreen(),
    ),
    GetPage(
      name: Routes.myPlaylists,
      page: () => const MyPlayListsScreen(),
    ),
    GetPage(
      name: Routes.playlists,
      page: () => const PlaylistListScreen(),
    ),
    GetPage(
      name: Routes.playlistDetails,
      page: () => const PlaylistDetailsScreen(),
    ),
    GetPage(
      name: Routes.newsList,
      page: () => const NewsListScreen(),
    ),
    GetPage(
      name: Routes.newsDetails,
      page: () => const NewsDetailsScreen(),
    ),
    GetPage(
      name: Routes.captureVideo,
      page: () => const CaptureVideoScreen(),
    ),
    GetPage(
      name: Routes.postDetails,
      page: () => const PostDetailsScreen(),
      binding: PostBindings(),
    ),
    GetPage(
      name: Routes.addPost,
      page: () => const AddPostScreen(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<AddPostController>(
            () => AddPostController(),
            fenix: true,
          );
        },
      ),
    ),
    GetPage(
      name: Routes.searchMedia,
      page: () => const SearchMediaScreen(),
    ),
    GetPage(
      name: Routes.showStory,
      page: () => const ShowStoryScreen(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<ShowStoryController>(
            () => ShowStoryController(),
            fenix: true,
          );
        },
      ),
    ),
  ];
  // final Map<String, Widget Function(BuildContext)> appRoutes = {
  //   Routes.login: (ctx) => const LoginScreen(),
  //   Routes.live: (ctx) => const LiveScreen(),
  //   Routes.register: (ctx) => const RegisterScreen(),
  //   Routes.forgetPass: (ctx) => const ForgetPassScreen(),
  //   Routes.submitCode: (ctx) => const SubmitCodeScreen(),
  //   Routes.mainScreen: (ctx) => const MainScreen(),
  //   Routes.musicDetails: (ctx) => const MusicDetailsScreen(),
  //   Routes.radioDetails: (ctx) => const RadioDetailScreen(),
  //   Routes.musicList: (ctx) => const MusicListScreen(),
  //   Routes.videoDetails: (ctx) => const VideoDetailsScreen(),
  //   Routes.videoList: (ctx) => const VideoListScreen(),
  //   Routes.changePass: (ctx) => const ChangePassScreen(),
  //   Routes.dashboard: (ctx) => const DashboardScreen(),
  //   // Routes.favorites: (ctx) => const FavoritesScreen(),
  //   Routes.info: (ctx) => const InfoScreen(),
  //   Routes.singerInfo: (ctx) => const SingerInfoScreen(),
  //   Routes.myFavorites: (ctx) => const MyFavoritesScreen(),
  //   Routes.myPlaylists: (ctx) => const MyPlayListsScreen(),
  //   Routes.playlists: (ctx) => const PlaylistListScreen(),
  //   Routes.playlistDetails: (ctx) => const PlaylistDetailsScreen(),
  //   Routes.newsList: (ctx) => const NewsListScreen(),
  //   Routes.newsDetails: (ctx) => const NewsDetailsScreen(),
  //   Routes.captureVideo: (ctx) => const captureVideoScreen(),
  //   Routes.postDetails: (ctx) => const PostDetailsScreen(),
  // };
}

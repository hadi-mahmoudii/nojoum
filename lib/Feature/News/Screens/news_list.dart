import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Core/Widgets/empty2.dart';
import '../../../Core/Widgets/filter.dart';
import '../../../Core/Widgets/flutter_icons.dart';
import '../../../Core/Widgets/global_appbar.dart';
import '../../../Core/Widgets/input_box.dart';
import '../../../Core/Widgets/loading.dart';
import '../../../Core/Widgets/mini_music_player.dart';
import '../Controllers/news_list.dart';
import '../Widgets/news_box.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  void dispose() {
    Get.delete<NewsListController>();
    super.dispose();
  }

  final NewsListController provider = Get.put(NewsListController());
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context).textTheme;
    return Obx(
      () => Scaffold(
        bottomNavigationBar: const MiniMusicPlayerBox(),
        appBar: GlobalAppbar(
          subtitle: 'catch up.',
          title: 'News',
          textTheme: themeData,
        ).build(context),
        body: FilterWidget(
          child: provider.isLoading.value
              ? const Center(child: LoadingWidget())
              : RefreshIndicator(
                  onRefresh: () async => provider.getNews(resetPage: true),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: ListView(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: InputBox(
                                  label: 'What do you looking for?',
                                  controller: provider.searchCtrl,
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  provider.getNews(
                                      resetPage: true, fromSearch: true);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    FlutterIcons.search_1,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          !provider.isLoadingMore.value
                              ? provider.newsList.isNotEmpty
                                  ? GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 130 / 100,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 15,
                                      ),
                                      itemBuilder: (ctx, ind) =>
                                          NewsNavigatorBox(
                                        themeData: themeData,
                                        news: provider.newsList[ind],
                                        letRestartLive: false,
                                      ),
                                      itemCount: provider.newsList.length,
                                    )
                                  : const EmptyBox2(icon: FlutterIcons.rss)
                              : const LoadingWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

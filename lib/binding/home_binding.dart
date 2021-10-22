import 'package:ekuabo/controller/add_banner_controller.dart';
import 'package:ekuabo/controller/add_marketplace_controller.dart';
import 'package:ekuabo/controller/blog_controller.dart';
import 'package:ekuabo/controller/blog_detail_controller.dart';
import 'package:ekuabo/controller/chat_conversation_controller.dart';
import 'package:ekuabo/controller/edit_profile_controller.dart';
import 'package:ekuabo/controller/group_invitation_controller.dart';
import 'package:ekuabo/controller/group_join_request_controller.dart';
import 'package:ekuabo/controller/group_new_feed_controller.dart';
import 'package:ekuabo/controller/home_controller.dart';
import 'package:ekuabo/controller/home_view_controller.dart';
import 'package:ekuabo/controller/market_place_controller.dart';
import 'package:ekuabo/controller/more_controller.dart';
import 'package:ekuabo/controller/my_banner_ad_controller.dart';
import 'package:ekuabo/controller/my_group_controller.dart';
import 'package:ekuabo/controller/new_feed_controller.dart';
import 'package:ekuabo/controller/news_feeds_view_all_controller.dart';
import 'package:ekuabo/controller/payment_webview_controller.dart';
import 'package:ekuabo/controller/post_blog_controller.dart';
import 'package:ekuabo/controller/post_new_group_controller.dart';
import 'package:ekuabo/controller/private_msg_controller.dart';
import 'package:ekuabo/controller/setting_controller.dart';
import 'package:ekuabo/controller/transaction_history_controller.dart';
import 'package:ekuabo/network/repository/banner_repository.dart';
import 'package:ekuabo/network/repository/blog_repository.dart';
import 'package:ekuabo/network/repository/edit_profile_repository.dart';
import 'package:ekuabo/network/repository/group_post_new_feed_repository.dart';
import 'package:ekuabo/network/repository/home_view_repository.dart';
import 'package:ekuabo/network/repository/market_place_repository.dart';
import 'package:ekuabo/network/repository/more_repository.dart';
import 'package:ekuabo/network/repository/my_group_repository.dart';
import 'package:ekuabo/network/repository/new_feed_repository.dart';
import 'package:ekuabo/network/repository/private_msg_repository.dart';
import 'package:ekuabo/network/repository/setting_repository.dart';
import 'package:ekuabo/network/repository/transaction_history_repository.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());

    /// home view
    Get.put(HomeViewRepository());
    Get.put(HomeViewController());
    Get.put(NewsFeedsViewAllController());

    /// blog
    Get.put(BlogRepository());
    Get.put(BlogController());
    Get.put(PostBlogController());
    Get.put(BlogDetailController());

    /// New Feed
    Get.put(NewFeedRepository());
    Get.put(NewFeedController());

    /// My Groups
    ///
    Get.put(MyGroupRepository());
    Get.put(GroupNewFeedRepository());
    Get.put(MyGroupController());
    Get.put(PostNewGroupController());
    Get.put(GroupInvitationController());
    Get.put(GroupJoinRequestController());
    Get.put(GroupNewFeedController());

    /// Setting
    Get.put(SettingRepository());
    Get.put(SettingController());

    /// MarketPlace
    Get.put(MarketPlaceRepository());
    Get.put(MarketPlaceController());
    Get.put(AddMarketPlaceController());

    /// Banner Ad
    Get.put(BannerRepository());
    Get.put(MyPostedBannerAdController());
    Get.put(AddBannerController());

    /// Transaction History
    Get.put(TransactionHistoryRepository());
    Get.put(TransactionHistoryController());

    /// Chat
    Get.put(PrivateMsgRepository());
    Get.put(PrivateMessageBoardController());
    Get.put(ChatConversationController());

    /// more view
    Get.put(MoreRepository());
    Get.put(MoreController());

    /// edit profile
    Get.put(EditProfileRepository());
    Get.put(EditProfileController());
  }
}

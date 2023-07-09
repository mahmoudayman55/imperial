class AppConstants {

  ///api and routes
  static const notificationServerKey= "key=AAAAd8Gjbfc:APA91bHfGSHWrtxzTKxqZmA_tqjWUxAr8n694_DE3SQPNQ2IE4IGEhxq8OiTFrEOR2AUzpHUKqQ1YSGG_eMjTigaXHQfqLWqsbhWrxSfIdb3z2mvLW162DkQl0TQJqVzl7SoZd1ECbe4";
  //static const baseUrl= "http://d1a4-197-43-173-75.ngrok-free.app";

static const baseUrl= "http://45.90.109.63:8800";
//static const baseUrl= "http://65db-197-43-148-59.ngrok-free.app";
//static const baseUrl= "https://maximus.serveo.net/";
  static const initialRoute= "$baseUrl/initial";
  static const onBoardsRoute= "$baseUrl/onboarding";
  static const servicesRoute= "$baseUrl/service";
  static const servicesCategoriesRoute= "$servicesRoute/category";
  static const servicesRateRoute= "$servicesRoute/rate";
  static const regionsRoute= "$baseUrl/regions";
  static const communitiesRoute= "$baseUrl/community";
  static const forgotPasswordRoute= "$userRoute/forgot";
  static const changePasswordRoute= "$forgotPasswordRoute/update";
  static const changeCurrentPasswordRoute= "$userRoute/password/update";
  static const eventsRoute= "$baseUrl/events";
  static const eventsTicketRequestRoute= "$eventsRoute/ticket";
  static const userTicketRequestRoute= "$userRoute/ticket";
  static const eventsCommunityAdmins= "$communitiesRoute/admin";
  static const communityEventsRoute= "$eventsRoute/community";
  static const communityJoinRequestsRoute= "$communitiesRoute/join/c";
  static const userJoinRequestsRoute= "$communitiesRoute/join/u";
  static const citiesRoute= "$initialRoute/city";
  static const askToJoinRoute= "$communitiesRoute/join";

  static const addRoleRoute= "$baseUrl/role";
  static const joinRequestStatusRoute= "$communitiesRoute/join";
  static const groupAgesRoute= "$initialRoute/group";
  static const speakingLanguageRoute= "$initialRoute/language";
  static const searchRoute= "$baseUrl/search";
  static const versionRoute= "$baseUrl/app";
  static const otherRegionRoute= "$regionsRoute/other";
  static const userRoute= "$baseUrl/user";
  static const userRegisterRoute= "$userRoute/register";
  static const userLoginRoute= "$userRoute/login";
  static const userUpdateTokenRoute= "$userRoute/update";
 static const regService= "$baseUrl/register_request";
 static const regCommunity= "$baseUrl/community";





 /// keys
  static const regionsKey= "regions";
  static const otherRegionKey= "region";
  static const regionNameKey= "name";
  static const userTokenExpKey= "exp";
  static const userKey= "user";
  static const speakingLanguageNameKey= "name";
  static const onBoardingKey= "onboarding";
  static const onBoardingTitleKey= "title";
  static const onBoardingContentKey= "content";
  static const appAboutKey= "about";
  static const appContactKey= "contact";
  static const groupAgesKey= "group_age";
  static const speakingLanguagesKey= "speakingLanguages";
  static const citiesKey= "cities";
  static const communitiesKey= "communities";
  static const eventsKey= "events";
  static const idKey= "id";

//hive boxes
  static const userTokenBoxName = "userTokenBox";
  static const userTokenBoxKey = "userToken";




  static const userNameKey = "name";
  static const emailKey = "email";
  static const passwordKey = "password";
  static const userRegionIdKey = "region_id";
  static const zipKey = "zip";
  static const phoneKey = "phone";
  static const groupAgeIdKey = "group_age_id";
  static const cityIdKey = "city_id";
  static const speakingLanguageIdKey = "speaking_language_id";
  static const userPicUrlKey = "pic_url";
  static const userCoverPicUrlKey = "cover_pic_url";

  /// error keys
  static const errorTypeKey = "type";
  static const errorMessageKey = "msg";
  static const errorFixItKey = "fixIt";
  static const errorStatusCodeKey = "status";
  static const errorKey = "err";

//app routes
  static const String accountTypePage = "/accountType";
  static const String communityRegisterPage = "/community_register";
  static const String serviceRegisterPage = "/service_register";
  static const String homePage = "/home";
  static const String userRegister1Page = "/user_register1";
  static const String userRegister2Page = "/user_register2";
  static const String loginPage = "/login";
  static const String forgotPasswordPage = "/forgot_password";
  static const String serviceProfilePage = "/serviceProfile";
  static const String communityProfilePage = "/Community_profile";
  static const String eventProfilePage = "/event_profile";
  static const String userProfilePage = "/user_profile";
  static const String userTicketsPage = "/user_tickets";
  static const String communityEventsPage = "/community_events";
  static const String eventTicketsPage = "/event_tickets";
  static const String personProfilePage = "/person";
  static const String updateCommunityProfilePage = "/update_community_profile";
  static const String communityJoinRequestsPage = "/community_join_requests";
  static const String newEventPage = "/new_event";
  static const String userJoinRequestPage = "/user_join_requests";
  static const String newTicketPage = "/new_ticket";

  static const String communityIdKey = "id";
  static const String communityNameKey = "name";
  static const String communityWebsiteUrlKey = "website_url";
  static const String communityAboutKey = "about";
  static const String communityRegionIdKey = "region_id";
  static const String communityMembersNumberKey = "members_number";
  static const String communityEventsNumberKey = "events_number";
  static const String communityAddressKey = "address";
  static const String communityCoverUrlKey = "cover_url";
  static const String communityCreatedAtKey = "created_at";
  static const String communityUpdatedAtKey = "updated_at";
  static const String communityRoolsKey = "rools";
  static const String communityEventsKey = "events";

  static const String roolIdKey = "id";
  static const String roolNameKey = "name";
  static const String roolDescriptionKey = "description";

  static const String eventIdKey = "id";
  static const String eventNameKey = "name";
  static const String eventStartDateKey = "start_date";
  static const String eventEndDateKey = "end_date";
  static const String eventDescriptionKey = "description";
  static const String eventLocationKey = "location";
  static const String eventCoversKey = "event_covers";
}
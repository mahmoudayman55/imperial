import 'package:imperial/community_module/data/model/bank_account_model.dart';
import 'package:imperial/community_module/domain/entity/role.dart';
import '../../../auth_module/domain/entities/user_entity.dart';
import 'event.dart';
class Community {
  int id;
  String name;
  String websiteUrl;
  String about;
  int regionId;
  int membersNumber;
  int eventsNumber;
  String address;
  String coverUrl;
  List<Event> events;
  List<User> members;
  List<User> admins;
  BankAccount? bankAccount;

  Community({
    required this.id,
    required this.name,
    required this.websiteUrl,
    required this.about,
    required this.regionId,
    required this.membersNumber,
    required this.eventsNumber,
    required this.address,
    required this.coverUrl,
    required this.events,
    required this.members,
    required this.admins,
    required this.bankAccount
  });}
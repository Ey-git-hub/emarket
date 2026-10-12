import 'package:emarket/features/auth/domain/app_user.dart';

abstract class UserRepository {
  Stream<AppUser?> watchUser(String uid);
}
import '../../models/auth_repository.dart';

abstract class AuthRepository{
    Future<AuthModel> login(String email, String password);
}
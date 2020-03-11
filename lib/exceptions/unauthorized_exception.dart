import 'package:yathaarth/exceptions/app_exception.dart';

class UnauthorizedException extends AppException {
  UnauthorizedException([message]) : super(message, "Unauthorised: ");
}
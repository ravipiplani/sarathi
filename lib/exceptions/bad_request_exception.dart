import 'package:yathaarth/exceptions/app_exception.dart';

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}
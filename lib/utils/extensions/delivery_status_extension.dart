import '../../enums/delivery_status.dart';

extension StatusX on DeliveryStatus {
  String get valueAsString => toString().split('.').last;

  // Or as a function
  String asString() => toString().split('.').last;
}

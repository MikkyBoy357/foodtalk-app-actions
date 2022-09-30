// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryStatusAdapter extends TypeAdapter<DeliveryStatus> {
  @override
  final int typeId = 1;

  @override
  DeliveryStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DeliveryStatus.delivered;
      case 1:
        return DeliveryStatus.pending;
      case 2:
        return DeliveryStatus.lost;
      default:
        return DeliveryStatus.delivered;
    }
  }

  @override
  void write(BinaryWriter writer, DeliveryStatus obj) {
    switch (obj) {
      case DeliveryStatus.delivered:
        writer.writeByte(0);
        break;
      case DeliveryStatus.pending:
        writer.writeByte(1);
        break;
      case DeliveryStatus.lost:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

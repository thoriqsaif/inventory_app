// import 'package:hive/hive.dart';

// part of 'data_inventory.dart';



// class DataInventoryAdapter extends TypeAdapter<DataInventory> {
//   @override
//   final int typeId = 1;

//   @override
//   Future<dynamic> read(BinaryReader reader) async {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return DataInventory(
//       id: fields[0]?? 0,
//       name: fields[1]?? '',
//       quantity: fields[2]?? 0,
//       price: fields[3]?? 0,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, DataInventory obj) {
//     writer
//       ..writeByte(4)
//       ..writeByte(0)
//       ..write(obj.id)
//       ..writeByte(1)
//       ..write(obj.name)
//       ..writeByte(2)
//       ..write(obj.quantity)
//       ..writeByte(3)
//       ..write(obj.price);
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is DataInventoryAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
//   }





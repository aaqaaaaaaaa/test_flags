// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountriesModelAdapter extends TypeAdapter<CountriesModel> {
  @override
  final int typeId = 1;

  @override
  CountriesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountriesModel(
      official: fields[4] as String?,
      common: fields[0] as String?,
      capital: (fields[1] as List?)?.cast<dynamic>(),
      region: fields[2] as String?,
      subregion: fields[3] as String?,
      latlng: (fields[5] as List?)?.cast<dynamic>(),
      flag: fields[6] as String?,
      population: fields[7] as int?,
      timezones: (fields[8] as List?)?.cast<dynamic>(),
      continents: (fields[9] as List?)?.cast<dynamic>(),
      flagsPng: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CountriesModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.common)
      ..writeByte(1)
      ..write(obj.capital)
      ..writeByte(2)
      ..write(obj.region)
      ..writeByte(3)
      ..write(obj.subregion)
      ..writeByte(4)
      ..write(obj.official)
      ..writeByte(5)
      ..write(obj.latlng)
      ..writeByte(6)
      ..write(obj.flag)
      ..writeByte(7)
      ..write(obj.population)
      ..writeByte(8)
      ..write(obj.timezones)
      ..writeByte(9)
      ..write(obj.continents)
      ..writeByte(10)
      ..write(obj.flagsPng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountriesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

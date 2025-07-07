import 'dart:convert';

class ScanModel {
    int id;
    String type;
    String value;

    ScanModel({
        required this.id,
        required this.type,
        required this.value,
    }){
      if(type.contains('http')){
        type = 'http';
      }else{
        type = 'geo';
      };
    }

    factory ScanModel.fromJson(String str) => ScanModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "value": value,
    };
}






import 'package:json_annotation/json_annotation.dart';
part'AddNewReport.g.dart';
@JsonSerializable()
class AddNewReport{
   String? report;
   String? reason;
   String? image;


   AddNewReport({
     this.report,
     this.reason,
     this.image,
});

   factory AddNewReport .fromJson(Map<String, dynamic> json) => AddNewReport(
     report: json["report"],
     reason: json["reason"],
     image: json["image"],

   );

   Map<String, dynamic> toJson() => {
     "report": report,
     "reason": reason,
     "image": image,

   };
}
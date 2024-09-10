import 'package:instagram_app/app/enums/status.dart';

class ObjectResponse {
     Status status;
     String? message;
     dynamic data;

     ObjectResponse({
       required this.status,
       this.message,
       this.data
  });


}
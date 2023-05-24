class Failure {
  String message;
  int statusCode;

  Failure({
    required this.message,
    required this.statusCode,
  });

  factory Failure.fromJson(Map<String, dynamic> json) => Failure(
        message: json["message"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
      };
}

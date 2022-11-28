// ignore_for_file: unnecessary_null_in_if_null_operators, prefer_null_aware_operators

class Chat {
  Chat({
    this.countuser,
  });

  final List<Countuser>? countuser;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        countuser: json["countuser"] == null
            ? null
            : List<Countuser>.from(
                json["countuser"].map((x) => Countuser.fromJson(x))),
      );
}

class Countuser {
  Countuser({
    this.unread,
    this.total,
    this.contact,
    this.firstName,
    this.lastName,
    this.image,
    this.date,
    this.id,
    this.room,
  });

  final int? unread;
  final int? total;
  final String? contact;
  final String? firstName;
  final String? lastName;
  final String? image;
  final DateTime? date;
  final int? id;
  final String? room;

  factory Countuser.fromJson(Map<String, dynamic> json) => Countuser(
        unread: json["unread"] ?? null,
        total: json["total"] ?? null,
        contact: json["contact"] ?? null,
        firstName: json["firstName"] ?? null,
        lastName: json["lastName"] ?? null,
        image: json["image"] ?? null,
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        id: json["id"] ?? null,
        room: json["room"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "unread": unread ?? null,
        "total": total ?? null,
        "contact": contact ?? null,
        "firstName": firstName ?? null,
        "lastName": lastName ?? null,
        "image": image ?? null,
        "date": date == null ? null : date?.toIso8601String(),
        "id": id ?? null,
        "room": room ?? null,
      };
}

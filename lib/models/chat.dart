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

class UserDetails {
  String? success;
  Data? data;
  String? error;

  UserDetails({this.success, this.data, this.error});

  UserDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    return data;
  }
}

class Data {
  int? id;
  Company? company;
  String? image;
  String? firstName;
  String? lastName;
  String? userType;
  String? contactPhone;
  String? formatcontactPhone;
  String? email;
  String? password;
  String? language;
  String? timeZone;
  String? communication;
  bool? emailUl;
  bool? smsUl;
  bool? phoneUl;
  String? address1;
  String? address2;
  String? zipcode;
  String? city;
  String? state;
  String? county;
  String? country;
  String? response;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  bool? isVerified;
  String? lastLogin;
  String? lastTimeLogout;
  String? uuid;
  String? deviceTokenweb;
  String? deviceToken;

  Data(
      {this.id,
      this.company,
      this.image,
      this.firstName,
      this.lastName,
      this.userType,
      this.contactPhone,
      this.formatcontactPhone,
      this.email,
      this.password,
      this.language,
      this.timeZone,
      this.communication,
      this.emailUl,
      this.smsUl,
      this.phoneUl,
      this.address1,
      this.address2,
      this.zipcode,
      this.city,
      this.state,
      this.county,
      this.country,
      this.response,
      this.createdAt,
      this.updatedAt,
      this.isActive,
      this.isVerified,
      this.lastLogin,
      this.lastTimeLogout,
      this.uuid,
      this.deviceTokenweb,
      this.deviceToken});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    image = json['image'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userType = json['userType'];
    contactPhone = json['contactPhone'];
    formatcontactPhone = json['formatcontactPhone'];
    email = json['email'];
    password = json['password'];
    language = json['language'];
    timeZone = json['timeZone'];
    communication = json['communication'];
    emailUl = json['emailUl'];
    smsUl = json['smsUl'];
    phoneUl = json['phoneUl'];
    address1 = json['address1'];
    address2 = json['address2'];
    zipcode = json['zipcode'];
    city = json['city'];
    state = json['state'];
    county = json['county'];
    country = json['country'];
    response = json['response'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    lastLogin = json['last_login'];
    lastTimeLogout = json['last_time_logout'];
    uuid = json['uuid'];
    deviceTokenweb = json['deviceTokenweb'];
    deviceToken = json['deviceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['image'] = image;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['userType'] = userType;
    data['contactPhone'] = contactPhone;
    data['formatcontactPhone'] = formatcontactPhone;
    data['email'] = email;
    data['password'] = password;
    data['language'] = language;
    data['timeZone'] = timeZone;
    data['communication'] = communication;
    data['emailUl'] = emailUl;
    data['smsUl'] = smsUl;
    data['phoneUl'] = phoneUl;
    data['address1'] = address1;
    data['address2'] = address2;
    data['zipcode'] = zipcode;
    data['city'] = city;
    data['state'] = state;
    data['county'] = county;
    data['country'] = country;
    data['response'] = response;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_active'] = isActive;
    data['is_verified'] = isVerified;
    data['last_login'] = lastLogin;
    data['last_time_logout'] = lastTimeLogout;
    data['uuid'] = uuid;
    data['deviceTokenweb'] = deviceTokenweb;
    data['deviceToken'] = deviceToken;
    return data;
  }
}

class Company {
  int? id;
  String? image;
  String? owner;
  String? companyName;
  String? site;
  String? code;
  String? extra;
  String? email;
  String? contactPhone;
  String? formatcontactPhone;
  String? faxNum;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zipcode;
  bool? isActive;
  bool? isVerified;
  String? password;
  bool? isStaff;
  String? createdAt;
  String? updatedAt;

  Company(
      {this.id,
      this.image,
      this.owner,
      this.companyName,
      this.site,
      this.code,
      this.extra,
      this.email,
      this.contactPhone,
      this.formatcontactPhone,
      this.faxNum,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.zipcode,
      this.isActive,
      this.isVerified,
      this.password,
      this.isStaff,
      this.createdAt,
      this.updatedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    owner = json['owner'];
    companyName = json['companyName'];
    site = json['site'];
    code = json['code'];
    extra = json['extra'];
    email = json['email'];
    contactPhone = json['contactPhone'];
    formatcontactPhone = json['formatcontactPhone'];
    faxNum = json['faxNum'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    zipcode = json['zipcode'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    password = json['password'];
    isStaff = json['is_staff'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['owner'] = this.owner;
    data['companyName'] = this.companyName;
    data['site'] = this.site;
    data['code'] = this.code;
    data['extra'] = this.extra;
    data['email'] = this.email;
    data['contactPhone'] = this.contactPhone;
    data['formatcontactPhone'] = this.formatcontactPhone;
    data['faxNum'] = this.faxNum;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipcode'] = this.zipcode;
    data['is_active'] = this.isActive;
    data['is_verified'] = this.isVerified;
    data['password'] = this.password;
    data['is_staff'] = this.isStaff;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, logged_in, api_key, api_secret, name, dob, mobile, email,
    address, city, district, referred_by, gstin, pincode, time,
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String logged_in = 'logged_in';
  static final String api_key = 'api_key';
  static final String api_secret = 'api_secret';
  static final String name = 'name';
  static final String dob = 'dob';
  static final String mobile = 'mobile';
  static final String email = 'email';
  static final String address = 'address';
  static final String city = 'city';
  static final String district = 'district';
  static final String referred_by = 'referred_by';
  static final String gstin = 'gstin';
  static final String pincode = 'pincode';

  static final String time = 'time';
}

class Note {
  final int? id;
  final bool isImportant;
  final bool logged_in;
  final String api_key;
  final String api_secret;
  final String name;
  final String dob;
  final String mobile;
  final String email;
  final String address;
  final String city;
  final String district;
  final String referred_by;
  final String gstin;
  final String pincode;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.isImportant,
    required this.logged_in,
    required this.api_key,
    required this.api_secret,
    required this.name,
    required this.dob,
    required this.mobile,
    required this.email,
    required this.address,
    required this.city,
    required this.district,
    required this.referred_by,
    required this.gstin,
    required this.pincode,
    required this.createdTime,
  });

  Note copy({
    int? id,
    bool? isImportant,
    bool? logged_in,
    String? api_key,
    String? api_secret,
    String? name,
    String? dob,
    String? mobile,
    String? email,
    String? address,
    String? city,
    String? district,
    String? referred_by,
    String? gstin,
    String? pincode,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        logged_in: logged_in ?? this.logged_in,
        api_key: api_key ?? this.api_key,
        api_secret: api_secret ?? this.api_secret,
        name: name ?? this.name,
        dob: dob ?? this.dob,
        mobile: mobile ?? this.mobile,
        email: email ?? this.email,
        address: address ?? this.address,
        city: city ?? this.city,
        district: district ?? this.district,
        referred_by: referred_by ?? this.referred_by,
        gstin: gstin ?? this.gstin,
        pincode: pincode ?? this.pincode,
        createdTime: createdTime ?? this.createdTime,
      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1,
        logged_in: json[NoteFields.isImportant] == 0,
        api_key: json[NoteFields.api_key] as String,
        api_secret: json[NoteFields.api_secret] as String,
        name: json[NoteFields.name] as String,
        dob: json[NoteFields.dob] as String,
        mobile: json[NoteFields.mobile] as String,
        email: json[NoteFields.email] as String,
        address: json[NoteFields.address] as String,
        city: json[NoteFields.city] as String,
        district: json[NoteFields.district] as String,
        referred_by: json[NoteFields.referred_by] as String,
        gstin: json[NoteFields.gstin] as String,
        pincode: json[NoteFields.pincode] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.logged_in: logged_in ? 1 : 0,
        NoteFields.api_key: api_key,
        NoteFields.api_secret: api_secret,
        NoteFields.name: name,
        NoteFields.dob: dob,
        NoteFields.mobile: mobile,
        NoteFields.email: email,
        NoteFields.address: address,
        NoteFields.city: city,
        NoteFields.district: district,
        NoteFields.referred_by: referred_by,
        NoteFields.gstin: gstin,
        NoteFields.pincode: pincode,
        NoteFields.time: createdTime.toIso8601String(),
      };
}

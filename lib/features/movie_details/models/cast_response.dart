class CastResponse {
  final int moiveId;
  final List<CastModel> cast;
  final List<CrewModel> crew;

  CastResponse({required this.moiveId, required this.cast, required this.crew});
  factory CastResponse.fromJson(Map<String, dynamic> json) {
    return CastResponse(
      moiveId: json['id'],
      cast:
          (json['cast'] as List<dynamic>)
              .map((e) => CastModel.fromJson(e))
              .toList(),
      crew:
          (json['crew'] as List<dynamic>)
              .map((e) => CrewModel.fromJson(e))
              .toList(),
    );
  }
}

class CastModel {
  final int castId;
  final String knownForDepartment;
  final String name;
  final String? profileImage;
  final String character;

  CastModel({
    required this.castId,
    required this.knownForDepartment,
    required this.name,
    required this.profileImage,
    required this.character,
  });
  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      castId: json['id'],
      knownForDepartment: json['known_for_department'],
      name: json['name'],
      profileImage: json['profile_path'],
      character: json['character'],
    );
  }
}

class CrewModel {
  final int crewId;
  final String knownForDepartment;
  final String name;
  final String? profileImage;
  final String department;

  CrewModel({
    required this.crewId,
    required this.knownForDepartment,
    required this.name,
    required this.profileImage,
    required this.department,
  });
  factory CrewModel.fromJson(Map<String, dynamic> json) {
    return CrewModel(
      crewId: json['id'],
      knownForDepartment: json['known_for_department'],
      name: json['name'],
      profileImage: json['profile_path'],
      department: json['department'],
    );
  }
}

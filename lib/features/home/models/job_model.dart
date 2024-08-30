class JobModel {
  int? status;
  Data? data;
  String? message;

  JobModel({this.status, this.data, this.message});

  JobModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<Job>? job;
  int? totalCount;

  Data({this.job, this.totalCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['job'] != null) {
      job = <Job>[];
      json['job'].forEach((v) {
        job!.add(new Job.fromJson(v));
      });
    }
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.job != null) {
      data['job'] = this.job!.map((v) => v.toJson()).toList();
    }
    data['total_count'] = this.totalCount;
    return data;
  }
}

class Job {
  String? jobId;
  String? jobTitle;
  String? description;
  String? location;
  String? locationType;
  String? jobType;
  int? minCharge;
  int? maxCharge;
  String? minExperience;
  String? maxExperience;
  String? jobReferralUrl;
  List<Skills>? skills;
  List<Positions>? positions;
  String? currencySymbol;
  String? currency;

  Job(
      {this.jobId,
      this.jobTitle,
      this.description,
      this.location,
      this.locationType,
      this.jobType,
      this.minCharge,
      this.maxCharge,
      this.minExperience,
      this.maxExperience,
      this.jobReferralUrl,
      this.skills,
      this.positions,
      this.currencySymbol,
      this.currency});

  Job.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    jobTitle = json['job_title'];
    description = json['description'];
    location = json['location'];
    locationType = json['location_type'];
    jobType = json['job_type'];
    minCharge = json['min_charge'];
    maxCharge = json['max_charge'];
    minExperience = json['min_experience'];
    maxExperience = json['max_experience'];
    jobReferralUrl = json['job_referral_url'];
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills!.add(new Skills.fromJson(v));
      });
    }
    if (json['positions'] != null) {
      positions = <Positions>[];
      json['positions'].forEach((v) {
        positions!.add(new Positions.fromJson(v));
      });
    }
    currencySymbol = json['currencySymbol'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['job_title'] = this.jobTitle;
    data['description'] = this.description;
    data['location'] = this.location;
    data['location_type'] = this.locationType;
    data['job_type'] = this.jobType;
    data['min_charge'] = this.minCharge;
    data['max_charge'] = this.maxCharge;
    data['min_experience'] = this.minExperience;
    data['max_experience'] = this.maxExperience;
    data['job_referral_url'] = this.jobReferralUrl;
    if (this.skills != null) {
      data['skills'] = this.skills!.map((v) => v.toJson()).toList();
    }
    if (this.positions != null) {
      data['positions'] = this.positions!.map((v) => v.toJson()).toList();
    }
    data['currencySymbol'] = this.currencySymbol;
    data['currency'] = this.currency;
    return data;
  }
}

class Skills {
  String? skillName;
  String? years;
  String? level;

  Skills({this.skillName, this.years, this.level});

  Skills.fromJson(Map<String, dynamic> json) {
    skillName = json['skill_name'];
    years = json['years'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skill_name'] = this.skillName;
    data['years'] = this.years;
    data['level'] = this.level;
    return data;
  }
}

class Positions {
  String? positionName;

  Positions({this.positionName});

  Positions.fromJson(Map<String, dynamic> json) {
    positionName = json['position_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['position_name'] = this.positionName;
    return data;
  }
}

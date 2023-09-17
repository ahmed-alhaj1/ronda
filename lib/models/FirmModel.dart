class EmployeeModel {
  String? userId;
  int? earning;
  String? id,
      email,
      phoneNumber,
      firmName,
      insuranceUrl,
      certUrl,
      licenseUrl,
      address,
      resumeUrl;

  EmployeeModel(
      {this.userId,
      this.id,
      this.firmName,
      this.insuranceUrl,
      this.certUrl,
      this.licenseUrl,
      this.address,
      this.email,
      this.resumeUrl,
      this.earning,
      this.phoneNumber});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    firmName = json['firmName'];
    email = json['email'];
    address = json['address'];
    certUrl = json['certUrl'];
    insuranceUrl = json['insuranceUrl'];
    licenseUrl = json['licenseUrl'];
    phoneNumber = json['phoneNumber'];
    id = json['id'];
    resumeUrl = json['resumeUrl'];
    earning = json['earning'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firmName'] = this.firmName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['certUrl'] = this.certUrl;
    data['insuranceUrl'] = this.insuranceUrl;
    data['licenseUrl'] = this.licenseUrl;
    data['address'] = this.address;
    data['id'] = this.id;
    data['resumeUrl'] = this.resumeUrl;
    data['userId'] = this.userId;
    data['earning'] = this.earning;
    return data;
  }
}

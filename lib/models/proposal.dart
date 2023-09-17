class Proposal {
  String? title;
  int? duration;
  String? cvletter;
  String? files;
  int? submissionOpt;
  int? cost;
  int? id;
  int? userId;

  Proposal({
    this.title,
    this.duration,
    this.cvletter,
    this.files,
    this.submissionOpt,
    this.id,
    this.cost,
    this.userId,
  });

  Proposal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    duration = json['duration'];
    cvletter = json['cvletter'];
    files = json['files'];
    submissionOpt = json['submissoinOpt'];
    cost = json['cost'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['duration'] = this.duration;
    data['cvletter'] = this.cvletter;
    data['files'] = this.files;
    data['cost'] = this.cost;
    data['id'] = this.id;
    data['userId'] = this.userId;
    return data;
  }
}

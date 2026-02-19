import '../models/job_model.dart';

class JobService {
  static final JobService _instance = JobService._internal();

  factory JobService() {
    return _instance;
  }

  JobService._internal();

  final List<Job> _jobs = [
    Job(
      title: "Retail Assistant",
      company: "ABC Store",
      location: "East London",
      description: "Assist customers and manage stock.",
    ),
    Job(
      title: "Admin Clerk",
      company: "XYZ Office",
      location: "King Williams Town",
      description: "Office administration duties.",
      isFeatured: true,
    ),
  ];

  List<Job> getJobs() {
    return _jobs;
  }

  void addJob(Job job) {
    _jobs.add(job);
  }
}

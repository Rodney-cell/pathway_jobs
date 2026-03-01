enum UserRole {
  jobseeker,
  employer,
  government,
}

UserRole roleFromString(String role) {
  switch (role) {
    case 'employer':
      return UserRole.employer;
    case 'government':
      return UserRole.government;
    default:
      return UserRole.jobseeker;
  }
}
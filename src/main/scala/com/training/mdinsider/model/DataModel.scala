package com.training.mdinsider.model

/**
 * Created by: Leonid Furman
 * Date:       10/11/15.
 */
case class ScoreComponents(median: Double, overall: Double, background: Double, experience: Double, topPercentile: Boolean)

case class CcsGroup(code: String, scoreComponents: Option[ScoreComponents])

case class PracticeLocation(
  addr1: String,
  addr2: Option[String],
  city: String,
  state: String,
  country: String,
  zip: Option[String],
  phone: Option[String],
  fax: Option[String],
  practiceName: Option[String],
  isPrimary: Boolean, // "Y" or "N"
  msa: Option[String],
  languages: Option[List[String]]
)

case class HospitalAffiliation(
  name: String,
  address: String,
  phone: String
)

case class Provider(
  npid: String,
  fullName: String,
  gender: String,
  medSchoolName: String,
  gradYear: String,
  practiceLocationLatitude: Double,
  practiceLocationLongitude: Double,
  practiceLocations: List[PracticeLocation],
  healthPlanAffiliations: List[String],
  hospitalAffiliations: List[HospitalAffiliation],
  diagnosesTreated: List[CcsGroup],
  proceduresPerformed: List[CcsGroup],
  practicingSpecialties: List[CcsGroup],
  certifications: List[String]
)

case class ProviderExperience(
  npid: String,
  groupType: String,
  groupCode: String,
  overallScore: Option[Double],
  medianScore: Option[Double],
  backgroundScore: Option[Double],
  experienceScore: Option[Double],
  topPercentile: Option[Boolean]
)

case class ProviderLocation(
  npid: String,
  latitude: Double,
  longitude: Double
)
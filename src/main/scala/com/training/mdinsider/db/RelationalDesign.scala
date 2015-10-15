package com.training.mdinsider.db

import com.training.mdinsider.model.DataModelJson._
import com.training.mdinsider.model._
import play.api.libs.json.Json
import scalikejdbc._

/**
 * Created by: Leonid Furman
 * Date:       10/11/15.
 */
object ProviderDB extends SQLSyntaxSupport[Provider] {
  override def tableName: String = "docfinder_master_fact"

  override def nameConverters: Map[String, String] = Map(
    "npid" -> "npid",
    "fullName" -> "provider_full_name",
    "gender" -> "provider_gender",
    "medSchoolName" -> "provider_med_school_name",
    "gradYear" -> "provider_graduation_year",
    "practiceLocationLatitude" -> "practice_location_latitude",
    "practiceLocationLongitude" -> "practice_location_longitude",
    "practiceLocations" -> "practice_locations",
    "healthPlanAffiliations" -> "health_plan_affiliations",
    "hospitalAffiliations" -> "hospital_affiliations",
    "diagnosesTreated" -> "diagnoses_treated",
    "proceduresPerformed" -> "procedures_performed",
    "practicingSpecialties" -> "practicing_specialties",
    "certifcations" -> "certifications"
  )

  def apply(p: ResultName[Provider])(rs: WrappedResultSet) = {
    new Provider(
      npid = rs.string(p.npid),
      fullName = rs.string(p.fullName),
      gender = rs.string(p.gender),
      medSchoolName = rs.string(p.medSchoolName),
      gradYear = rs.string(p.gradYear),
      practiceLocationLatitude = rs.double(p.practiceLocationLatitude),
      practiceLocationLongitude = rs.double(p.practiceLocationLongitude),
      practiceLocations = rs.stringOpt(p.practiceLocations).fold(List.empty[PracticeLocation])(Json.parse(_).as[List[PracticeLocation]]),
      healthPlanAffiliations = rs.stringOpt(p.healthPlanAffiliations).fold(List.empty[String])(Json.parse(_).as[List[String]]),
      hospitalAffiliations = rs.stringOpt(p.hospitalAffiliations).fold(List.empty[HospitalAffiliation])(Json.parse(_).as[List[HospitalAffiliation]]),
      diagnosesTreated = rs.stringOpt(p.diagnosesTreated).fold(List.empty[CcsGroup])(Json.parse(_).as[List[CcsGroup]]),
      proceduresPerformed = rs.stringOpt(p.proceduresPerformed).fold(List.empty[CcsGroup])(Json.parse(_).as[List[CcsGroup]]),
      practicingSpecialties = rs.stringOpt(p.practicingSpecialties).fold(List.empty[CcsGroup])(Json.parse(_).as[List[CcsGroup]]),
      certifications = rs.stringOpt(p.certifications).fold(List.empty[String])(Json.parse(_).as[List[String]])
    )
  }
}

object ProviderExperienceDB extends SQLSyntaxSupport[ProviderExperience] {
  override def tableName: String = "provider_experience"

  override def nameConverters: Map[String, String] = Map(
    "npid" -> "npid",
    "groupType" -> "group_type",
    "groupCode" -> "group_code",
    "overallScore" -> "overall_score",
    "medianScore" -> "median_score",
    "backgroundScore" -> "background_score",
    "experienceScore" -> "experience_score",
    "topPercentile" -> "top_percentile"
  )

  def apply(pexp: ResultName[ProviderExperience])(rs: WrappedResultSet) = {
    new ProviderExperience(
      npid = rs.string(pexp.npid),
      groupType = rs.string(pexp.groupType),
      groupCode = rs.string(pexp.groupCode),
      overallScore = rs.doubleOpt(pexp.overallScore),
      medianScore = rs.doubleOpt(pexp.medianScore),
      backgroundScore = rs.doubleOpt(pexp.backgroundScore),
      experienceScore = rs.doubleOpt(pexp.experienceScore),
      topPercentile = rs.booleanOpt(pexp.topPercentile)
    )
  }
}

object ProviderLocationDB extends SQLSyntaxSupport[ProviderLocation] {
  override def tableName: String = "provider_location"

  override def nameConverters: Map[String, String] = Map(
    "npid" -> "npid",
    "latitude" -> "latitude",
    "longitude" -> "longitude"
  )

  def apply(loc: ResultName[ProviderLocation])(rs: WrappedResultSet) = {
    new ProviderLocation(
      npid = rs.string(loc.npid),
      latitude = rs.double(loc.latitude),
      longitude = rs.double(loc.longitude)
    )
  }
}
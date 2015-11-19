package com.training.mdinsider.model

import play.api.libs.json._

/**
 * Created by: Leonid Furman
 * Date:       10/11/15.
 */
object DataModelJson {
  implicit val scoreComponentsFormat = new Format[ScoreComponents] {
    override def writes(scoreComponents: ScoreComponents): JsValue = {
      Json.obj(
        "median" -> scoreComponents.median,
        "overall" -> scoreComponents.overall,
        "background" -> scoreComponents.overall,
        "experience" -> scoreComponents.experience,
        "losPercentile" -> scoreComponents.losPercentile,
        "topPercentile" -> (if (scoreComponents.topPercentile) 1 else 0)
      )
    }

    override def reads(json: JsValue): JsResult[ScoreComponents] = {
      JsSuccess(
        ScoreComponents(
          (json \ "median").as[Double],
          (json \ "overall").as[Double],
          (json \ "background").as[Double],
          (json \ "experience").as[Double],
          (json \ "losPercentile").asOpt[Double],
          (json \ "topPercentile").as[Int].equals(1)
        )
      )
    }
  }

  implicit val ccsGroupFormat = new Format[CcsGroup] {
    override def writes(ccsGroup: CcsGroup): JsValue = {
      Json.obj(
        "code" -> ccsGroup.code,
        "scoreComponents" -> ccsGroup.scoreComponents
      )
    }

    override def reads(json: JsValue): JsResult[CcsGroup] = {
      JsSuccess(
        CcsGroup(
          (json \ "code").as[String],
          (json \ "scoreComponents").asOpt[ScoreComponents]
        )
      )
    }
  }

  implicit val practiceLocationFormat = new Format[PracticeLocation] {
    override def reads(json: JsValue): JsResult[PracticeLocation] = {
      JsSuccess(
        PracticeLocation(
          (json \ "addr1").as[String],
          (json \ "addr2").asOpt[String],
          (json \ "city").as[String],
          (json \ "state").as[String],
          (json \ "country").as[String],
          (json \ "zip").asOpt[String],
          (json \ "phone").asOpt[String],
          (json \ "fax").asOpt[String],
          (json \ "practiceName").asOpt[String],
          (json \ "isPrimary").asOpt[String].fold(false)(_.matches("Y")),
          (json \ "msa").asOpt[String],
          (json \ "languages").asOpt[List[String]]
        )
      )
    }

    override def writes(practiceLocation: PracticeLocation): JsValue = {
      Json.obj(
        "addr1" -> practiceLocation.addr1,
        "addr2" -> practiceLocation.addr2,
        "city" -> practiceLocation.city,
        "state" -> practiceLocation.state,
        "country" -> practiceLocation.country,
        "zip" -> practiceLocation.zip,
        "phone" -> practiceLocation.phone,
        "fax" -> practiceLocation.fax,
        "practiceName" -> practiceLocation.practiceName,
        "isPrimary" -> (if (practiceLocation.isPrimary) "Y" else "N"),
        "msa" -> practiceLocation.addr1,
        "languages" -> practiceLocation.addr1
      )
    }
  }

  implicit val practiceLocationListFormat = new Format[List[PracticeLocation]] {
    override def reads(json: JsValue): JsResult[List[PracticeLocation]] = {
      json match {
        case JsArray(v) => JsSuccess(v.toList.flatMap(practiceLocationFormat.reads(_).asOpt))
        case _ => JsError("Invalid json for List[PracticeLocation]")
      }
    }

    override def writes(practiceLocationList: List[PracticeLocation]): JsValue = {
      JsArray(practiceLocationList.map(practiceLocationFormat.writes))
    }
  }

  implicit val hospitalAffiliationFormat = Json.format[HospitalAffiliation]
}
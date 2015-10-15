package com.training.mdinsider.db

import java.io.PrintWriter

import com.training.mdinsider.model.Provider
import scalikejdbc._

/**
 * Created by: Leonid Furman
 * Date:       10/13/15.
 */
object DatabaseManager {

  def selectProviderList(): Seq[Provider] = {
    val p = ProviderDB.syntax("p")
    DB localTx {
      implicit session => {
        withSQL {
          selectFrom(ProviderDB as p)
            .orderBy(p.npid)
        }.map(ProviderDB(p.resultName)).list().apply()
      }
    }
  }

  def saveProviderExperience(provider: Provider, fileWriter: PrintWriter) = {
    val ccsGroupTypes = Map(
      "DX" -> provider.diagnosesTreated,
      "PX" -> provider.proceduresPerformed,
      "SPX" -> provider.practicingSpecialties
    )
    ccsGroupTypes.foreach(
      (ccsGroupsEntry) => {
        ccsGroupsEntry._2.foreach(
          ccsGroup => {
            val providerExperience = ccsGroup.scoreComponents.fold(
              List(provider.npid, ccsGroupsEntry._1, ccsGroup.code, "", "", "", "", "")
            )(
                scoreComponents =>
                  List(provider.npid, ccsGroupsEntry._1, ccsGroup.code, scoreComponents.overall, scoreComponents.median, scoreComponents.background, scoreComponents.experience, scoreComponents.topPercentile).map(_.toString)
              )
            fileWriter.append(providerExperience.mkString("|"))
            fileWriter.flush()
            fileWriter.append("\n")
            fileWriter.flush()
          }
        )
      }
    )
  }

  def saveProviderHospitals(provider: Provider, fileWriter: PrintWriter) = {
    provider.hospitalAffiliations.foreach(
      hospitalAffiliation => {
        fileWriter.append(List(provider.npid, hospitalAffiliation.name, hospitalAffiliation.address, hospitalAffiliation.phone).mkString("|"))
        fileWriter.flush()
        fileWriter.append("\n")
        fileWriter.flush()
      }
    )
  }

  def saveProviderLocation(provider: Provider, fileWriter: PrintWriter) = {
    fileWriter.append(List(provider.npid, provider.practiceLocationLatitude, provider.practiceLocationLongitude).mkString("|"))
    fileWriter.flush()
    fileWriter.append("\n")
    fileWriter.flush()
  }
}

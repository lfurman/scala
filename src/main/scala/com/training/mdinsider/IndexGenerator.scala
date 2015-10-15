package com.training.mdinsider

import java.io.{File, PrintWriter}

import com.training.mdinsider.db.DatabaseManager._
import com.training.mdinsider.model.Provider
import scalikejdbc._
import scalikejdbc.config.DBs

/**
 * Created by: Leonid Furman
 * Date:       10/13/15.
 */
object IndexGenerator extends App {

  // load database configuration
  DBs.setupAll()

  // ensure single line per query
  GlobalSettings.loggingSQLAndTime = new LoggingSQLAndTimeSettings(
    enabled = true,
    singleLineMode = true,
    logLevel = 'DEBUG
  )

  val providerList: Seq[Provider] = selectProviderList()
  println( s"""Number of providers is ${providerList.size}""")

  // generate providers entities
  saveProviderAttributes(saveProviderExperience, "provider_experience.txt")
  saveProviderAttributes(saveProviderLocation, "provider_location.txt")
  saveProviderAttributes(saveProviderHospitals, "provider_hospitals.txt")

  def saveProviderAttributes(f: (Provider, PrintWriter) => Unit, filePath: String) = {
    new File(filePath).delete()
    using(new PrintWriter(filePath)) {
      fileWriter => providerList.foreach(provider => f(provider, fileWriter))
    }
  }
}
